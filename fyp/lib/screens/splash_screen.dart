import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToGetStarted();
  }

  _navigateToGetStarted() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const GetStartedScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // NutriCareAI Logo with animation
            Image.asset(
              'assets/images/Logo.png',
              height: 120,
              width: 120,
              fit: BoxFit.contain,
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 1000))
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: const Duration(milliseconds: 1000),
                ),

            const SizedBox(height: 24),

            // App Name with animation
            Text(
              'NutriCareAI',
              style: AppTextStyles.heading1.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 500))
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 8),

            // Tagline with animation
            Text(
              'Your AI-powered nutrition companion',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 1000))
                .slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
}
