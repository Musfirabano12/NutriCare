import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_card.dart';
import 'login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Header
              Text(
                'Get Started (Nutricare AI)',
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.3, end: 0),

              const SizedBox(height: 32),

              // Main Card with Logo and Content
              CustomCard(
                child: Column(
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/Logo.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                    ).animate().fadeIn(delay: 400.ms).scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.0, 1.0)),

                    const SizedBox(height: 24),

                    // Tagline
                    Text(
                      'Your Personal Health Companion',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 32),

                    // Feature Cards Grid
                    Row(
                      children: [
                        Expanded(
                          child: _buildFeatureCard(
                            'AI-Powered Planning',
                            'Personalized meal plans based on your health conditions',
                            Icons.psychology,
                            AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildFeatureCard(
                            'Progress Tracking',
                            'Monitor your health metrics and dietary goals',
                            Icons.trending_up,
                            AppColors.steps,
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 800.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _buildFeatureCard(
                            'Multi-Condition Support',
                            'Diabetes, hypertension, obesity, heart health & more',
                            Icons.favorite,
                            AppColors.calories,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildFeatureCard(
                            'Cultural Foods',
                            'Includes des foods and global cuisine options',
                            Icons.public,
                            AppColors.water,
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 1000.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 32),

                    // Get Started Button
                    CustomButton(
                      text: 'Get Started With NutriCare',
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: animation.drive(
                                  Tween(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero)
                                      .chain(
                                          CurveTween(curve: Curves.easeInOut)),
                                ),
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 300),
                          ),
                        );
                      },
                    )
                        .animate()
                        .fadeIn(delay: 1200.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 16),

                    // Disclaimer
                    Text(
                      '*NutriCare AI provides general wellness guidance. Always consult healthcare professionals for medical advice.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(delay: 1400.ms)
                        .slideY(begin: 0.3, end: 0),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
