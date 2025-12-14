import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  AuthService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://10.232.176.51:8000", // change later for production
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        // attach access token
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString("access_token");

        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }

        return handler.next(options);
      },
      onError: (error, handler) async {
        // if token expired, refresh it
        if (error.response?.statusCode == 401) {
          bool refreshed = await _refreshToken();

          if (refreshed) {
            final prefs = await SharedPreferences.getInstance();
            String? newToken = prefs.getString("access_token");

            error.requestOptions.headers["Authorization"] = "Bearer $newToken";

            final clonedRequest = await _dio.fetch(error.requestOptions);

            return handler.resolve(clonedRequest);
          }
        }
        return handler.next(error);
      },
    ));
  }

  late Dio _dio;

  // SAVE TOKENS
  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", accessToken);
    await prefs.setString("refresh_token", refreshToken);
  }

  // REGISTER
  Future<bool> register(String email, String password) async {
    try {
      final response = await _dio.post("/auth/register", data: {
        "email": email,
        "password": password,
      });

      await _saveTokens(
        response.data["access_token"],
        response.data["refresh_token"],
      );
      return true;
    } catch (e) {
      print("Register failed: $e");
      return false;
    }
  }

  // LOGIN
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post("/auth/login", data: {
        "email": email,
        "password": password,
      });

      await _saveTokens(
        response.data["access_token"],
        response.data["refresh_token"],
      );

      return true;
    } catch (e) {
      print("Login failed: $e");
      return false;
    }
  }

  // REFRESH TOKEN
  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs.getString("refresh_token");

      final response = await _dio.post("/auth/refresh", data: {
        "refresh_token": refreshToken,
      });

      await prefs.setString("access_token", response.data["access_token"]);
      return true;
    } catch (e) {
      print("Token refresh failed: $e");
      return false;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString("refresh_token");

      if (refreshToken != null) {
        await _dio.post("/auth/logout", data: {
          "refresh_token": refreshToken,
        });
      }

      await prefs.remove("access_token");
      await prefs.remove("refresh_token");
    } catch (_) {}
  }
}
