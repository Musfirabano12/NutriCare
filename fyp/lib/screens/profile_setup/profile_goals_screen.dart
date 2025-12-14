import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import 'profile_confirm_screen.dart';

class ProfileGoalsScreen extends StatefulWidget {
  const ProfileGoalsScreen({super.key});

  @override
  State<ProfileGoalsScreen> createState() => _ProfileGoalsScreenState();
}

class _ProfileGoalsScreenState extends State<ProfileGoalsScreen> {
  final List<String> _selectedGoals = [];

  final List<Map<String, dynamic>> _dietaryGoals = [
    {
      'title': 'Weight Loss',
      'description': 'Lose weight safely and sustainably',
      'icon': Icons.trending_down,
      'color': AppColors.calories,
    },
    {
      'title': 'Weight Gain',
      'description': 'Build healthy muscle mass',
      'icon': Icons.trending_up,
      'color': AppColors.steps,
    },
    {
      'title': 'Maintain Weight',
      'description': 'Keep your current healthy weight',
      'icon': Icons.balance,
      'color': AppColors.water,
    },
    {
      'title': 'Muscle Building',
      'description': 'Focus on strength and muscle development',
      'icon': Icons.fitness_center,
      'color': AppColors.primary,
    },
  ];

  final List<Map<String, dynamic>> _dietaryPreferences = [
    {
      'title': 'Vegetarian',
      'description': 'Plant-based diet',
      'icon': Icons.eco,
      'color': AppColors.sleep,
    },
    {
      'title': 'Vegan',
      'description': 'No animal products',
      'icon': Icons.eco,
      'color': AppColors.water,
    },
    {
      'title': 'Keto',
      'description': 'Low-carb, high-fat',
      'icon': Icons.local_fire_department,
      'color': AppColors.calories,
    },
    {
      'title': 'Balanced',
      'description': 'All food groups in moderation',
      'icon': Icons.restaurant,
      'color': AppColors.primary,
    },
  ];

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
                  _buildProgressStep(4, false),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Title with animation
              Text(
                'Your Goals & Preferences',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 200))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 16),
              
              // Description with animation
              Text(
                'Help us personalize your nutrition plan',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 400))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 40),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dietary Goals Section
                      Text(
                        'Dietary Goals',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      )
                          .animate()
                          .fadeIn(delay: const Duration(milliseconds: 600))
                          .slideX(begin: -0.3, end: 0),
                      
                      const SizedBox(height: 16),
                      
                      ...List.generate(_dietaryGoals.length, (index) {
                        final goal = _dietaryGoals[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildGoalCard(
                            goal['title'],
                            goal['description'],
                            goal['icon'],
                            goal['color'],
                            'goal_${goal['title']}',
                          ),
                        );
                      }),
                      
                      const SizedBox(height: 32),
                      
                      // Dietary Preferences Section
                      Text(
                        'Dietary Preferences',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      )
                          .animate()
                          .fadeIn(delay: const Duration(milliseconds: 800))
                          .slideX(begin: -0.3, end: 0),
                      
                      const SizedBox(height: 16),
                      
                      ...List.generate(_dietaryPreferences.length, (index) {
                        final preference = _dietaryPreferences[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildGoalCard(
                            preference['title'],
                            preference['description'],
                            preference['icon'],
                            preference['color'],
                            'preference_${preference['title']}',
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              
              // Continue button
              CustomButton(
                text: 'Continue',
                onPressed: _selectedGoals.isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const ProfileConfirmScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position: animation.drive(
                                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                                      .chain(CurveTween(curve: Curves.easeInOut)),
                                ),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                        );
                      }
                    : () {},
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

  Widget _buildGoalCard(String title, String description, IconData icon, Color color, String id) {
    final isSelected = _selectedGoals.contains(id);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedGoals.remove(id);
          } else {
            _selectedGoals.add(id);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(
            color: isSelected ? color : AppColors.borderLight,
            width: 2,
          ),
          boxShadow: AppConstants.shadowLight,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? color : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.white : color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected ? color : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? color : AppColors.textHint,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
