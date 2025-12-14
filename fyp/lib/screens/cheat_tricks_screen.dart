import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_card.dart';

class CheatTricksScreen extends StatefulWidget {
  const CheatTricksScreen({super.key});

  @override
  State<CheatTricksScreen> createState() => _CheatTricksScreenState();
}

class _CheatTricksScreenState extends State<CheatTricksScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Before', 'During', 'After', 'General'];

  final List<Map<String, dynamic>> _tricks = [
    {
      'title': 'Eat Vegetables First',
      'category': 'Before',
      'icon': Icons.access_time,
      'iconColor': Colors.red,
      'description': 'Start your meal with a salad or cooked vegetables. This creates a "veggie wall" in your stomach that slows down the absorption of glucose from carbs eaten later.',
      'scientificBasis': 'Studies show eating vegetables first can reduce glucose spikes by up to 75%',
    },
    {
      'title': 'Eat Protein & Fat Before Carbs',
      'category': 'During',
      'icon': Icons.restaurant,
      'iconColor': Colors.orange,
      'description': 'When eating your meal, follow this order: vegetables → protein → fats → carbs. This sequence dramatically reduces glucose spikes.',
      'scientificBasis': 'The order of food consumption impacts glucose response significantly',
    },
    {
      'title': '10-Minute Walk After Eating',
      'category': 'After',
      'icon': Icons.directions_walk,
      'iconColor': Colors.blue,
      'description': 'Take a short 10-15 minute walk after meals. This helps your muscles use up the glucose from your food, preventing spikes.',
      'scientificBasis': 'Light physical activity immediately after eating can reduce post-meal glucose by 30%',
    },
    {
      'title': 'Don\'t Eat Carbs Alone',
      'category': 'General',
      'icon': Icons.lightbulb,
      'iconColor': Colors.green,
      'description': 'Never eat carbohydrates (roti, rice, bread) by themselves. Always pair them with protein, healthy fats, or fiber-rich vegetables.',
      'scientificBasis': 'Combining carbs with protein/fat slows digestion and prevents rapid glucose spikes',
    },
  ];

  List<Map<String, dynamic>> get _filteredTricks {
    if (_selectedFilter == 'All') {
      return _tricks;
    }
    return _tricks.where((trick) => trick['category'] == _selectedFilter).toList();
  }

  Widget _buildTrickCard(Map<String, dynamic> trick) {
    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
          // Header with icon, title, and category tag
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: trick['iconColor'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  trick['icon'],
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  trick['title'],
                  style: AppTextStyles.heading4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(trick['category']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _getCategoryColor(trick['category']).withOpacity(0.3)),
                ),
                child: Text(
                  '${trick['category']} Meal',
                  style: AppTextStyles.caption.copyWith(
                    color: _getCategoryColor(trick['category']),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            trick['description'],
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Separator
          Container(
            height: 1,
            color: AppColors.borderLight,
          ),
          
          const SizedBox(height: 12),
          
          // Scientific Basis
          Text(
            'Scientific Basis:',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            trick['scientificBasis'],
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Before':
        return Colors.blue;
      case 'During':
        return Colors.purple;
      case 'After':
        return Colors.red;
      case 'General':
        return Colors.orange;
      default:
        return AppColors.primary;
    }
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
              'Cheat Tricks',
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
            // Introduction Card
            CustomCard(
              padding: const EdgeInsets.all(20),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Glucose Management Cheat Tricks',
                          style: AppTextStyles.heading4.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Science-backed tips to keep your blood sugar levels stable',
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
            
            const SizedBox(height: 20),
            
            // Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
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
                        filter,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isSelected ? AppColors.white : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Trick Cards
            ..._filteredTricks.asMap().entries.map((entry) {
              final index = entry.key;
              final trick = entry.value;
              return _buildTrickCard(trick)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: (400 + index * 100).ms)
                  .slideY(begin: 0.2, end: 0);
            }).toList(),
            
            const SizedBox(height: 24),
            
            // Pro Tips Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pro Tips',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '• Combine multiple tricks for maximum effect (e.g., vinegar + veggie first + walk after)\n'
                    '• Track which tricks work best for YOUR body - everyone responds differently\n'
                    '• Consistency is key - make these tricks part of your daily routine',
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
