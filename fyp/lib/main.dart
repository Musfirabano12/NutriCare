import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/colors.dart';
import 'theme/text_styles.dart';
import 'screens/get_started_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/reset_password_screen.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const NutriCareApp());
}

class NutriCareApp extends StatefulWidget {
  const NutriCareApp({super.key});

  @override
  State<NutriCareApp> createState() => _NutriCareAppState();
}

class _NutriCareAppState extends State<NutriCareApp> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      // Mobile deep links
      _handleIncomingLinks();
    }
  }

  void _handleIncomingLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _navigateToDeepLink(uri);
      }
    }, onError: (err) {
      print('Failed to receive link: $err');
    });

    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        _navigateToDeepLink(initialUri);
      }
    } catch (err) {
      print('Failed to get initial uri: $err');
    }
  }

  void _navigateToDeepLink(Uri uri) {
    if (uri.path == '/reset-password') {
      final token = uri.queryParameters['token'];
      if (token != null && context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(token: token),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriCareAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          titleTextStyle: AppTextStyles.heading4.copyWith(
            color: AppColors.textPrimary,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.textPrimary,
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          displayLarge:
              AppTextStyles.heading1.copyWith(color: AppColors.textPrimary),
          displayMedium:
              AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
          displaySmall:
              AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
          headlineLarge:
              AppTextStyles.heading4.copyWith(color: AppColors.textPrimary),
          headlineMedium:
              AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
          headlineSmall:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          titleLarge:
              AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
          titleMedium:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          titleSmall:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
          bodyLarge:
              AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
          bodyMedium:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          bodySmall:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
          labelLarge:
              AppTextStyles.button.copyWith(color: AppColors.textPrimary),
          labelMedium:
              AppTextStyles.label.copyWith(color: AppColors.textPrimary),
          labelSmall:
              AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            elevation: 0,
            textStyle: AppTextStyles.button,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            textStyle: AppTextStyles.button,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide:
                const BorderSide(color: AppColors.borderLight, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide:
                const BorderSide(color: AppColors.borderLight, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintStyle:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
          labelStyle: AppTextStyles.label.copyWith(color: AppColors.primary),
        ),
      ),
      initialRoute: '/get-started',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name!);

        // Reset password route (web + mobile)
        if (uri.path == '/reset-password') {
          final token = uri.queryParameters['token'];
          if (token != null) {
            return MaterialPageRoute(
              builder: (_) => ResetPasswordScreen(token: token),
            );
          } else {
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          }
        }

        // Other routes
        switch (uri.path) {
          case '/get-started':
            return MaterialPageRoute(builder: (_) => const GetStartedScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/signup':
            return MaterialPageRoute(builder: (_) => const SignupScreen());
          case '/forgot-password':
            return MaterialPageRoute(
                builder: (_) => const ForgotPasswordScreen());
          case '/profile-setup':
            return MaterialPageRoute(
                builder: (_) => const ProfileSetupScreen());
          case '/dashboard':
            return MaterialPageRoute(
                builder: (_) => const MainNavigationScreen());
          default:
            return MaterialPageRoute(builder: (_) => const GetStartedScreen());
        }
      },
    );
  }
}
