import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfileService {
  // --- SharedPreferences Keys ---
  static const String _keyUserId = 'user_id'; // 🔹 Added user_id
  static const String _keyName = 'user_name';
  static const String _keyEmail = 'user_email';
  static const String _keyGender = 'user_gender';
  static const String _keyAge = 'user_age';
  static const String _keyWeight = 'user_weight';
  static const String _keyHeight = 'user_height';
  static const String _keyDiabetesStatus = 'user_diabetes_status';
  static const String _keyInsulinUsage = 'user_insulin_usage';
  static const String _keyInsulinDose = 'user_insulin_dose';
  static const String _keyBloodSugar = 'user_blood_sugar';
  static const String _keyActivityLevel = 'user_activity_level';
  static const String _keyGoals = 'user_goals';
  static const String _keyPreferences = 'user_preferences';

  // --- Backend URL ---
  // Android emulator ke liye: 10.0.2.2
  static const String baseUrl =
      "http://10.0.2.2:8000/profile/create"; // 🔹 Local backend for emulator

  // --- Save User ID after login ---
  static Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, id);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  // --- SharedPreferences Methods ---
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<void> saveProfileData({
    String? gender,
    String? age,
    String? weight,
    String? height,
    String? diabetesStatus,
    String? insulinUsage,
    String? insulinDose,
    String? bloodSugar,
    String? activityLevel,
    List<String>? goals,
    List<String>? preferences,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (gender != null) await prefs.setString(_keyGender, gender);
    if (age != null) await prefs.setString(_keyAge, age);
    if (weight != null) await prefs.setString(_keyWeight, weight);
    if (height != null) await prefs.setString(_keyHeight, height);
    if (diabetesStatus != null)
      await prefs.setString(_keyDiabetesStatus, diabetesStatus);
    if (insulinUsage != null)
      await prefs.setString(_keyInsulinUsage, insulinUsage);
    if (insulinDose != null)
      await prefs.setString(_keyInsulinDose, insulinDose);
    if (bloodSugar != null) await prefs.setString(_keyBloodSugar, bloodSugar);
    if (activityLevel != null)
      await prefs.setString(_keyActivityLevel, activityLevel);
    if (goals != null) await prefs.setStringList(_keyGoals, goals);
    if (preferences != null)
      await prefs.setStringList(_keyPreferences, preferences);

    // --- Send data to backend ---
    await _sendProfileToBackend(
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      diabetesStatus: diabetesStatus,
      insulinUsage: insulinUsage,
      insulinDose: insulinDose,
      bloodSugar: bloodSugar,
      activityLevel: activityLevel,
      goals: goals,
      preferences: preferences,
    );
  }

  static Future<Map<String, dynamic>> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'user_id': prefs.getInt(_keyUserId),
      'name': prefs.getString(_keyName),
      'email': prefs.getString(_keyEmail),
      'gender': prefs.getString(_keyGender),
      'age': prefs.getString(_keyAge),
      'weight': prefs.getString(_keyWeight),
      'height': prefs.getString(_keyHeight),
      'diabetes_status': prefs.getString(_keyDiabetesStatus),
      'insulin_usage': prefs.getString(_keyInsulinUsage),
      'insulin_dosage': prefs.getString(_keyInsulinDose),
      'activity_level': prefs.getString(_keyActivityLevel),
      'goals': prefs.getStringList(_keyGoals) ?? [],
      'preferences': prefs.getStringList(_keyPreferences) ?? [],
      'blood_sugar': {
        'reading_value': prefs.getDouble('${_keyBloodSugar}_value') ?? 0.0,
        'reading_unit': prefs.getString('${_keyBloodSugar}_unit') ?? '',
        'notes': prefs.getString('${_keyBloodSugar}_notes') ?? '',
      },
    };
  }

  static Future<void> clearProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // --- Backend API Method ---
  static Future<bool> _sendProfileToBackend({
    String? gender,
    String? age,
    String? weight,
    String? height,
    String? diabetesStatus,
    String? insulinUsage,
    String? insulinDose,
    String? bloodSugar,
    String? activityLevel,
    List<String>? goals,
    List<String>? preferences,
  }) async {
    try {
      final url = Uri.parse(baseUrl);
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_keyUserId);

      if (userId == null) {
        print("Error: user_id not found. Make sure user is logged in.");
        return false;
      }

      final body = {
        "user_id": userId,
        "gender": gender,
        "age": age != null ? int.tryParse(age) ?? 0 : 0,
        "weight_kg": weight != null ? double.tryParse(weight) ?? 0 : 0,
        "height_cm": height != null ? double.tryParse(height) ?? 0 : 0,
        "diabetes_status": diabetesStatus ?? "none", // Enum match
        "insulin_usage": insulinUsage == "true" || insulinUsage == "yes",
        "insulin_dosage":
            insulinDose != null ? double.tryParse(insulinDose) ?? 0 : 0,
        "activity_level": activityLevel ?? "sedentary", // Enum match
        "health_goals": goals?.map((e) => int.tryParse(e) ?? 0).toList() ?? [],
        "dietary_preferences":
            preferences?.map((e) => int.tryParse(e) ?? 0).toList() ?? [],
        "blood_sugar": bloodSugar != null ? jsonDecode(bloodSugar) : null,
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Profile saved to backend successfully!");
        return true;
      } else {
        print("Failed to save profile to backend: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error sending profile to backend: $e");
      return false;
    }
  }
}
