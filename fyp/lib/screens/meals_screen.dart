import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final List<Map<String, dynamic>> _todayMeals = [
    {
      'name': 'Breakfast',
      'time': '8:00 AM',
      'calories': 350,
      'items': ['Oatmeal with berries', 'Greek yogurt', 'Green tea'],
      'color': AppColors.calories,
    },
    {
      'name': 'Lunch',
      'time': '1:00 PM',
      'calories': 450,
      'items': ['Grilled chicken salad', 'Quinoa', 'Mixed vegetables'],
      'color': AppColors.water,
    },
    {
      'name': 'Dinner',
      'time': '7:00 PM',
      'calories': 400,
      'items': ['Salmon fillet', 'Brown rice', 'Steamed broccoli'],
      'color': AppColors.steps,
    },
  ];

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
                      .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
                  
                  const SizedBox(width: AppConstants.spacingM),
                  
                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s Meals',
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
                          'Track your nutrition intake',
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

              // Add Meal Button
              CustomButton(
                text: 'Add New Meal',
                onPressed: () {
                  // TODO: Navigate to add meal screen
                },
                backgroundColor: AppColors.primary,
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 600))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: AppConstants.spacingXL),

              // Today's Meals
              Text(
                'Today\'s Meals',
                style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.heading4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 800))
                  .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: AppConstants.spacingM),
              
              // Meals List
              ...List.generate(_todayMeals.length, (index) {
                final meal = _todayMeals[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildMealCard(meal, index),
                );
              }),
              
              const SizedBox(height: AppConstants.spacingXXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal, int index) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: meal['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Icon(
                    Icons.restaurant,
                    color: meal['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal['name'],
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        meal['time'],
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: meal['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Text(
                    '${meal['calories']} cal',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: meal['color'],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(meal['items'].length, (itemIndex) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: meal['color'],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        meal['items'][itemIndex],
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 1000 + (index * 200)))
        .slideX(begin: -0.3, end: 0);
  }
}
