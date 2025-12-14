import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_card.dart';

class DietPlanScreen extends StatelessWidget {
  const DietPlanScreen({super.key});

  Widget _buildNutritionBar(String label, int current, int target, Color color) {
    final percentage = (current / target).clamp(0.0, 1.0);
    final isOverTarget = current > target;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '$current / $target${label == 'Calories' ? '' : 'g'}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.borderLight,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: 280 * percentage,
                decoration: BoxDecoration(
                  color: isOverTarget ? AppColors.warning : color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMealCard({
    required String title,
    required String serving,
    required String calories,
    required String protein,
    required String carbs,
    required String fat,
    required String ingredients,
    required Color iconColor,
  }) {
    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      elevation: 3,
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowLight.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.white,
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
                      style: AppTextStyles.heading4.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      serving,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: Text(
                  'Low GI',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildNutritionInfo('Calories', calories),
              ),
              Expanded(
                child: _buildNutritionInfo('Protein', protein),
              ),
              Expanded(
                child: _buildNutritionInfo('Carbs', carbs),
              ),
              Expanded(
                child: _buildNutritionInfo('Fat', fat),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: AppColors.borderLight,
          ),
          const SizedBox(height: 12),
          Text(
            'Ingredients',
            style: AppTextStyles.label.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ingredients,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.grid_view,
                color: AppColors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Diet Plan',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle regenerate
              },
              icon: const Icon(Icons.refresh, color: AppColors.white, size: 18),
              label: Text(
                'Regenerate',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Nutrition Summary
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Daily Nutrition Summary',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildNutritionBar('Calories', 930, 842, AppColors.calories),
                  const SizedBox(height: 16),
                  _buildNutritionBar('Protein', 56, 63, AppColors.primary),
                  const SizedBox(height: 16),
                  _buildNutritionBar('Carbs', 90, 84, AppColors.warning),
                  const SizedBox(height: 16),
                  _buildNutritionBar('Fats', 37, 28, AppColors.error),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Meals Section
            Text(
              'Today\'s Meals',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Meal Cards
            _buildMealCard(
              title: 'Besan Chilla (Chickpea Pancake)',
              serving: '2 medium chillas',
              calories: '250',
              protein: '12g',
              carbs: '30g',
              fat: '8g',
              ingredients: 'Chickpea flour, Onions, Tomatoes, Green chilies, Spices',
              iconColor: Colors.orange,
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
            
            _buildMealCard(
              title: 'Baingan Bharta with Roti',
              serving: '1 plate bharta + 2 roti',
              calories: '360',
              protein: '12g',
              carbs: '48g',
              fat: '14g',
              ingredients: 'Eggplant, Whole wheat flour, Tomatoes, Onions, Spices',
              iconColor: Colors.blue,
            ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: 0.2, end: 0),
            
            _buildMealCard(
              title: 'Grilled Fish with Raita',
              serving: '150g fish + 1 cup raita',
              calories: '320',
              protein: '32g',
              carbs: '12g',
              fat: '15g',
              ingredients: 'Fish, Yogurt, Cucumber, Mint, Lemon',
              iconColor: Colors.pink,
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Important Reminders
            CustomCard(
              padding: const EdgeInsets.all(20),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Important Reminders',
                    style: AppTextStyles.heading4.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '• Always monitor your blood sugar levels before and after meals\n'
                    '• Check the "Cheat Tricks" tab for glucose management tips\n'
                    '• Consult your healthcare provider before making major dietary changes',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
