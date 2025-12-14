import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_card.dart';
import 'widgets/custom_input_field.dart';
import 'widgets/custom_button.dart';

class DailyTrackerScreen extends StatefulWidget {
  const DailyTrackerScreen({super.key});

  @override
  State<DailyTrackerScreen> createState() => _DailyTrackerScreenState();
}

class _DailyTrackerScreenState extends State<DailyTrackerScreen> {
  final TextEditingController _morningGlucoseController = TextEditingController();
  final TextEditingController _eveningGlucoseController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _sleepController = TextEditingController();
  final TextEditingController _stressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  final List<Map<String, dynamic>> _meals = [];

  @override
  void dispose() {
    _morningGlucoseController.dispose();
    _eveningGlucoseController.dispose();
    _weightController.dispose();
    _exerciseController.dispose();
    _waterController.dispose();
    _sleepController.dispose();
    _stressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _addMeal() {
    setState(() {
      _meals.add({
        'name': '',
        'calories': '',
        'time': '',
      });
    });
  }

  void _removeMeal(int index) {
    setState(() {
      _meals.removeAt(index);
    });
  }

  void _saveData() {
    // Handle save functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data saved successfully!'),
        backgroundColor: AppColors.success,
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
              'Daily Tracker',
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
            // Header
            Text(
              'Daily Tracker',
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            Text(
              'Track your daily health metrics to manage your diabetes better',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Date Selection
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Date',
                    style: AppTextStyles.heading4.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose which day to track.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.chevron_left,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${_selectedDate.day}, ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Has saved data',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = _selectedDate.add(const Duration(days: 1));
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: Text(
                        'Jump To Today',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Blood Glucose Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bloodtype,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Blood Glucose (mg/dL)',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Record your glucose readings.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Morning (Fasting)',
                    hintText: 'Enter morning glucose reading',
                    icon: Icons.wb_sunny,
                    controller: _morningGlucoseController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Evening (Before Dinner)',
                    hintText: 'Enter evening glucose reading',
                    icon: Icons.nightlight_round,
                    controller: _eveningGlucoseController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Physical Metrics Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Physical Metrics',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track your body and activity.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Weight (Kg)',
                    hintText: 'Enter your weight',
                    icon: Icons.monitor_weight,
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Exercise (Minutes)',
                    hintText: 'Enter exercise duration',
                    icon: Icons.fitness_center,
                    controller: _exerciseController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Meals & Food Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.restaurant,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Meals & Food',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: _addMeal,
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add Meal'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'What did you eat today?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._meals.asMap().entries.map((entry) {
                    final index = entry.key;
                    final meal = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Meal ${index + 1}',
                                style: AppTextStyles.label.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => _removeMeal(index),
                                child: Text(
                                  'Remove',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          CustomInputField(
                            label: 'Meal Name',
                            hintText: 'Enter meal name',
                            icon: Icons.restaurant_menu,
                            controller: TextEditingController(text: meal['name']),
                            onChanged: (value) {
                              _meals[index]['name'] = value;
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: CustomInputField(
                                  label: 'Calories',
                                  hintText: 'Enter calories',
                                  icon: Icons.local_fire_department,
                                  controller: TextEditingController(text: meal['calories']),
                                  onChanged: (value) {
                                    _meals[index]['calories'] = value;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomInputField(
                                  label: 'Time',
                                  hintText: 'Enter time',
                                  icon: Icons.access_time,
                                  controller: TextEditingController(text: meal['time']),
                                  onChanged: (value) {
                                    _meals[index]['time'] = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Lifestyle & Wellness Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.self_improvement,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Lifestyle And Wellness',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Other factors affecting your health.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Water Intake (glasses)',
                    hintText: 'Enter water intake',
                    icon: Icons.water_drop,
                    controller: _waterController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Sleep (hours)',
                    hintText: 'Enter sleep duration',
                    icon: Icons.bedtime,
                    controller: _sleepController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Stress Level',
                    hintText: 'Enter stress level (1-10)',
                    icon: Icons.psychology,
                    controller: _stressController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 1200.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 16),
            
            // Notes Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notes',
                    style: AppTextStyles.heading4.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Any additional observations or symptoms?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: TextField(
                      controller: _notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter your notes here...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textHint,
                        ),
                        border: InputBorder.none,
                      ),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 1400.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Save Button
            CustomButton(
              text: 'Save Today\'s Data',
              onPressed: _saveData,
              icon: Icons.save,
            ).animate().fadeIn(duration: 600.ms, delay: 1600.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Progress Section
            CustomCard(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Your Progress',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildProgressCard('1', 'Total days logged in'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildProgressCard('1', 'This Week'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildProgressCard('1', 'This Month'),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 1800.ms).slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
