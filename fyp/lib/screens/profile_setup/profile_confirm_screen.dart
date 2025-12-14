import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../dashboard_screen.dart';

class ProfileConfirmScreen extends StatelessWidget {
  const ProfileConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile Setup',
          style: AppTextStyles.heading4.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Progress indicator
              Row(
                children: [
                  _buildProgressStep(1, true),
                  _buildProgressLine(true),
                  _buildProgressStep(2, true),
                  _buildProgressLine(true),
                  _buildProgressStep(3, true),
                  _buildProgressLine(true),
                  _buildProgressStep(4, true),
                ],
              ),
              
              const SizedBox(height: 60),
              
              // Success icon with animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 60,
                  color: AppColors.primary,
                ),
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 800))
                  .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0)),
              
              const SizedBox(height: 40),
              
              // Title with animation
              Text(
                'Profile Complete!',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 400))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 16),
              
              // Description with animation
              Text(
                'Your personalized nutrition journey starts now. We\'ll create a custom plan based on your preferences and goals.',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 600))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 60),
              
              // Summary cards
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusL),
                  boxShadow: AppConstants.shadowMedium,
                ),
                child: Column(
                  children: [
                    _buildSummaryItem('Profile Picture', 'Added', Icons.camera_alt),
                    const SizedBox(height: 16),
                    _buildSummaryItem('Personal Details', 'Age, Weight, Height', Icons.person),
                    const SizedBox(height: 16),
                    _buildSummaryItem('Dietary Goals', 'Weight Loss, Balanced', Icons.flag),
                    const SizedBox(height: 16),
                    _buildSummaryItem('Preferences', 'Vegetarian, Keto', Icons.favorite),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 800))
                  .slideY(begin: 0.3, end: 0),
              
              const Spacer(),
              
              // Get Started button
              CustomButton(
                text: 'Get Started with NutriCareAI',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                    (route) => false,
                  );
                },
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 1000))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStep(int step, bool isActive) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.borderLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          '$step',
          style: AppTextStyles.bodySmall.copyWith(
            color: isActive ? AppColors.white : AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? AppColors.primary : AppColors.borderLight,
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusS),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.check_circle,
          color: AppColors.primary,
          size: 20,
        ),
      ],
    );
  }
}
