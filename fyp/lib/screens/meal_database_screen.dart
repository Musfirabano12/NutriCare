import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_card.dart';

class MealDatabaseScreen extends StatefulWidget {
  const MealDatabaseScreen({super.key});

  @override
  State<MealDatabaseScreen> createState() => _MealDatabaseScreenState();
}

class _MealDatabaseScreenState extends State<MealDatabaseScreen> {
  String _selectedMealType = 'All Meals';
  String _selectedGIFilter = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _mealTypes = ['All Meals', 'Breakfast', 'Lunch', 'Dinner'];
  final List<String> _giFilters = ['Low GI', 'Medium GI', 'High GI'];

  final List<Map<String, dynamic>> _meals = [
    {
      'name': 'Dalia (Broken Wheat Porridge)',
      'serving': '1 cup cooked',
      'mealType': 'Breakfast',
      'giLevel': 'Low GI',
      'giColor': AppColors.success,
      'calories': '280',
      'protein': '10g',
      'carbs': '45g',
      'fat': '6g',
      'fiber': '8g',
      'ingredients': ['Broken Wheat', 'Vegetables', 'Spices', 'Milk'],
    },
    {
      'name': 'Moong Dal with Brown Rice',
      'serving': '1 cup dal + 1 cup rice',
      'mealType': 'Lunch',
      'giLevel': 'Medium GI',
      'giColor': AppColors.warning,
      'calories': '420',
      'protein': '18g',
      'carbs': '65g',
      'fat': '8g',
      'fiber': '12g',
      'ingredients': ['Moong Daal', 'Brown Rice', 'Turmeric', 'Garlic & Tomatoes'],
    },
    {
      'name': 'Grilled Fish With Raita',
      'serving': '150g fish + 1 cup raita',
      'mealType': 'Dinner',
      'giLevel': 'Low GI',
      'giColor': AppColors.success,
      'calories': '320',
      'protein': '32g',
      'carbs': '12g',
      'fat': '15g',
      'fiber': '3g',
      'ingredients': ['Fish', 'Cucumber', 'Lemon', 'Yogurt', 'Mint'],
    },
  ];

  List<Map<String, dynamic>> get _filteredMeals {
    return _meals.where((meal) {
      final matchesMealType = _selectedMealType == 'All Meals' || meal['mealType'] == _selectedMealType;
      final matchesGI = _selectedGIFilter.isEmpty || meal['giLevel'] == _selectedGIFilter;
      final matchesSearch = _searchController.text.isEmpty || 
          meal['name'].toLowerCase().contains(_searchController.text.toLowerCase());
      
      return matchesMealType && matchesGI && matchesSearch;
    }).toList();
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
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
          // Meal Title and Labels
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal['name'],
                      style: AppTextStyles.heading4.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meal['serving'],
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: meal['giColor'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: meal['giColor'].withOpacity(0.3)),
                    ),
                    child: Text(
                      meal['giLevel'],
                      style: AppTextStyles.caption.copyWith(
                        color: meal['giColor'],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Text(
                      meal['mealType'],
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Nutritional Information Grid
          Row(
            children: [
              Expanded(
                child: _buildNutritionBox('Calories', meal['calories']),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildNutritionBox('Protein', meal['protein']),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildNutritionBox('Carbs', meal['carbs']),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildNutritionBox('Fat', meal['fat']),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildNutritionBox('Fiber', meal['fiber']),
              ),
              const SizedBox(width: 8),
              const Expanded(child: SizedBox()), // Empty space
            ],
          ),
          
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: AppColors.borderLight,
          ),
          const SizedBox(height: 12),
          
          // Ingredients
          Text(
            'Ingredients',
            style: AppTextStyles.label.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: (meal['ingredients'] as List<String>).map((ingredient) {
              return Text(
                '• $ingredient',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
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
              'Meal Database',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Desi Meal Database Info
            CustomCard(
              padding: const EdgeInsets.all(20),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Desi Meal Database',
                          style: AppTextStyles.heading4.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explore our collection of diabetic-friendly desi meals with complete nutritional information.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Search meals',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textHint,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 20),
            
            // Meal Type Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _mealTypes.map((type) {
                  final isSelected = _selectedMealType == type;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMealType = type;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.borderLight,
                        ),
                      ),
                      child: Text(
                        type,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isSelected ? AppColors.white : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Results Count and GI Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${_filteredMeals.length} meal${_filteredMeals.length != 1 ? 's' : ''}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: _giFilters.map((filter) {
                    final isSelected = _selectedGIFilter == filter;
                    Color filterColor;
                    switch (filter) {
                      case 'Low GI':
                        filterColor = AppColors.success;
                        break;
                      case 'Medium GI':
                        filterColor = AppColors.warning;
                        break;
                      case 'High GI':
                        filterColor = AppColors.error;
                        break;
                      default:
                        filterColor = AppColors.textSecondary;
                    }
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedGIFilter = isSelected ? '' : filter;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? filterColor : filterColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: filterColor),
                        ),
                        child: Text(
                          filter,
                          style: AppTextStyles.caption.copyWith(
                            color: isSelected ? AppColors.white : filterColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 20),
            
            // Meal Cards
            ..._filteredMeals.asMap().entries.map((entry) {
              final index = entry.key;
              final meal = entry.value;
              return _buildMealCard(meal)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: (800 + index * 100).ms)
                  .slideY(begin: 0.2, end: 0);
            }).toList(),
            
            const SizedBox(height: 24),
            
            // Understanding GI Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Understanding Glycemic Index (GI)',
                    style: AppTextStyles.heading4.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '• Low GI (55 or less): Best for diabetics - causes slow, steady rise in blood sugar\n'
                    '• Medium GI (56-69): Moderate impact - consume in controlled portions\n'
                    '• High GI (70+): Causes rapid blood sugar spikes - limit consumption',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
