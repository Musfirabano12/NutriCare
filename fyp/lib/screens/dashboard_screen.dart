import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_card.dart';
import '../services/user_profile_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _userName = 'User';
  String _greeting = 'Good Morning!';
  Map<String, dynamic> _profileData = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final profileData = await UserProfileService.getProfileData();
    final hour = DateTime.now().hour;

    setState(() {
      _profileData = profileData;
      _userName = profileData['name'] ?? 'User';

      // Set greeting based on time of day
      if (hour < 12) {
        _greeting = 'Good Morning!';
      } else if (hour < 17) {
        _greeting = 'Good Afternoon!';
      } else {
        _greeting = 'Good Evening!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Menu and Greeting
            Builder(
              builder: (context) => Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                  const SizedBox(width: 8),
                  // Logo
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  // Greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _userName,
                          style: AppTextStyles.heading4.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Notification Icon
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.3, end: 0),
            ),

            const SizedBox(height: 24),

            // Health Metrics Cards (Average Random & Average Fasting)
            Row(
              children: [
                Expanded(
                  child: _buildGlucoseMetricCard(
                    'Average Random',
                    'mg/dL',
                    'hypoglycemia',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildGlucoseMetricCard(
                    'Average Fasting',
                    'mg/dL',
                    'normal',
                    Colors.purple,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

            const SizedBox(height: 24),

            // Detailed Profile Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Health Profile',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.lightbulb_outline,
                            color: AppColors.primary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildProfileRow(
                      'Type', _profileData['diabetesStatus'] ?? 'Not Set'),
                  _buildProfileRow(
                      'Frequency',
                      _profileData['insulinUsage'] == 'Yes, I use insulin'
                          ? '2x/day'
                          : 'N/A'),
                  _buildProfileRow('Dosage',
                      '${_profileData['insulinDose'] ?? '0'} units/day'),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildNutritionRow('Calories', '930', '842'),
                  _buildNutritionRow('Carbs', '56g', '63g'),
                  _buildNutritionRow('Protein', '90g', '84g'),
                  _buildNutritionRow('Fat', '37g', '28g'),
                  const SizedBox(height: 8),
                  _buildNutritionRow('Fiber', '20g', ''),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),

            const SizedBox(height: 32),

            // Today's Overview
            Text(
              "Today's Overview",
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.3, end: 0),

            const SizedBox(height: 20),

            // Stats Cards Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Calories',
                    '1,850',
                    'kcal',
                    Icons.local_fire_department,
                    AppColors.calories,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Water',
                    '6',
                    'glasses',
                    Icons.water_drop,
                    AppColors.water,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Steps',
                    '8,420',
                    'steps',
                    Icons.directions_walk,
                    AppColors.steps,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Sleep',
                    '7.5',
                    'hours',
                    Icons.bedtime,
                    AppColors.sleep,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),

            const SizedBox(height: 32),

            // Recent Meals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Meals',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 1000.ms).slideX(begin: -0.3, end: 0),

            const SizedBox(height: 16),

            // Meal Cards
            Column(
              children: [
                _buildMealCard(
                  'Breakfast',
                  'Oatmeal with berries',
                  '320 kcal',
                  '8:00 AM',
                  Icons.free_breakfast,
                ),
                const SizedBox(height: 12),
                _buildMealCard(
                  'Lunch',
                  'Grilled chicken salad',
                  '450 kcal',
                  '1:00 PM',
                  Icons.lunch_dining,
                ),
                const SizedBox(height: 12),
                _buildMealCard(
                  'Snack',
                  'Greek yogurt',
                  '150 kcal',
                  '4:00 PM',
                  Icons.local_dining,
                ),
              ],
            ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.3, end: 0),

            const SizedBox(height: 32),

            // Health Insights
            Text(
              'Health Insights',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(delay: 1400.ms).slideX(begin: -0.3, end: 0),

            const SizedBox(height: 16),

            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.trending_up,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Great Progress!',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'You\'re on track with your daily goals',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily Goal Progress',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '75%',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: AppColors.borderLight,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 1600.ms).slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, String unit, IconData icon, Color color) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  size: 20,
                ),
              ),
              Text(
                unit,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(String mealType, String description, String calories,
      String time, IconData icon) {
    return CustomCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
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
                  mealType,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                calories,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                time,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlucoseMetricCard(
      String title, String unit, String status, Color color) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                unit,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          // Simple line graph representation
          Container(
            height: 40,
            child: CustomPaint(
              painter: _LineGraphPainter(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
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

  Widget _buildNutritionRow(String label, String current, String target) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            target.isNotEmpty ? '$current / $target' : current,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Simple line graph painter
class _LineGraphPainter extends CustomPainter {
  final Color color;

  _LineGraphPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.5),
      Offset(size.width * 0.4, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.4),
      Offset(size.width * 0.8, size.height * 0.5),
      Offset(size.width, size.height * 0.3),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
