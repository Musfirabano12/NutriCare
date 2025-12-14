import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_card.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              Row(
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/Logo.png',
                    height: AppConstants.logoSizeM,
                    width: AppConstants.logoSizeM,
                    fit: BoxFit.contain,
                  )
                      .animate()
                      .fadeIn(duration: AppConstants.animationMedium)
                      .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.0, 1.0)),

                  const SizedBox(width: AppConstants.spacingM),

                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Progress',
                          style: GoogleFonts.poppins(
                            textStyle: AppTextStyles.heading3.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 200))
                            .slideX(begin: -0.3, end: 0),
                        Text(
                          'Track your health journey',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 400))
                            .slideX(begin: -0.3, end: 0),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.spacingXXL),

              // Progress Overview Card
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Overview',
                        style: GoogleFonts.poppins(
                          textStyle: AppTextStyles.heading4.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: const Duration(milliseconds: 600))
                          .slideY(begin: 0.3, end: 0),

                      const SizedBox(height: 20),

                      // Progress Stats
                      Row(
                        children: [
                          Expanded(
                            child: _buildProgressStat(
                              'Weight Lost',
                              '2.5 kg',
                              Icons.trending_down,
                              AppColors.calories,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildProgressStat(
                              'Calories Burned',
                              '1,200',
                              Icons.local_fire_department,
                              AppColors.steps,
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(delay: const Duration(milliseconds: 800))
                          .slideY(begin: 0.3, end: 0),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.spacingXL),

              // Charts Section
              Text(
                'Health Metrics',
                style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.heading4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 1000))
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: AppConstants.spacingM),

              // Weight Chart
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.monitor_weight,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Weight Trend',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppConstants.radiusM),
                        ),
                        child: Center(
                          child: Text(
                            '📈 Weight Chart\n(Chart implementation)',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 1200))
                  .slideX(begin: -0.3, end: 0),

              const SizedBox(height: 16),

              // Calories Chart
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: AppColors.calories,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Calories Burned',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.calories.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppConstants.radiusM),
                        ),
                        child: Center(
                          child: Text(
                            '🔥 Calories Chart\n(Chart implementation)',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 1400))
                  .slideX(begin: 0.3, end: 0),

              const SizedBox(height: AppConstants.spacingXXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStat(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
