import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_input_field.dart';
import 'widgets/custom_card.dart';
import 'main_navigation_screen.dart';
import '../services/user_profile_service.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 7;

  // Form controllers
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bloodSugarController = TextEditingController();
  final _insulinDoseController = TextEditingController();

  // Selected values
  String? _selectedGender;
  String? _diabetesStatus;
  String? _insulinUsage;
  String? _activityLevel;
  final List<String> _selectedGoals = [];
  final List<String> _selectedPreferences = [];

  final List<String> _diabetesStatusOptions = [
    'Type 1 Diabetes',
    'Type 2 Diabetes',
    'Pre-diabetes',
    'Gestational Diabetes',
    'No Diabetes',
  ];

  final List<String> _insulinUsageOptions = [
    'Yes, I use insulin',
    'No, I don\'t use insulin',
    'Sometimes',
  ];

  final List<String> _activityLevels = [
    'Sedentary (little to no exercise)',
    'Lightly Active (light exercise 1-3 days/week)',
    'Moderately Active (moderate exercise 3-5 days/week)',
    'Very Active (hard exercise 6-7 days/week)',
    'Extremely Active (very hard exercise, physical job)',
  ];

  final List<String> _goals = [
    'Weight Loss',
    'Blood Sugar Control',
    'Muscle Gain',
    'Maintain Weight',
    'Improve Energy',
    'Better Sleep',
    'General Health',
    'Heart Health',
  ];

  final List<String> _preferences = [
    'Vegetarian',
    'Vegan',
    'Keto',
    'Paleo',
    'Gluten-Free',
    'Dairy-Free',
    'Low-Carb',
    'Mediterranean',
    'Balanced Diet',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _bloodSugarController.dispose();
    _insulinDoseController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeSetup();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeSetup() async {
    // Save all profile data
    await UserProfileService.saveProfileData(
      gender: _selectedGender,
      age: _ageController.text.trim(),
      weight: _weightController.text.trim(),
      height: _heightController.text.trim(),
      diabetesStatus: _diabetesStatus,
      insulinUsage: _insulinUsage,
      insulinDose: _insulinDoseController.text.trim().isNotEmpty
          ? _insulinDoseController.text.trim()
          : null,
      bloodSugar: _bloodSugarController.text.trim(),
      activityLevel: _activityLevel,
      goals: _selectedGoals.isNotEmpty ? _selectedGoals : null,
      preferences:
          _selectedPreferences.isNotEmpty ? _selectedPreferences : null,
    );

    // Navigate to Dashboard
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainNavigationScreen(),
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
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0: // Personal Info
        return _selectedGender != null &&
            _ageController.text.isNotEmpty &&
            _weightController.text.isNotEmpty &&
            _heightController.text.isNotEmpty;
      case 1: // Diabetes Status
        return _diabetesStatus != null;
      case 2: // Insulin Usage
        return _insulinUsage != null;
      case 3: // Blood Sugar Reading
        return _bloodSugarController.text.isNotEmpty;
      case 4: // Activity Level
        return _activityLevel != null;
      case 5: // Goals
        return _selectedGoals.isNotEmpty;
      case 6: // Preferences
        return _selectedPreferences.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: _currentStep > 0
            ? IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: _previousStep,
              )
            : null,
        title: Text(
          'Profile Setup',
          style: AppTextStyles.heading4.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              children: [
                Text(
                  'Step ${_currentStep + 1} of $_totalSteps',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${((_currentStep + 1) / _totalSteps * 100).round()}%',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: (_currentStep + 1) / _totalSteps,
            backgroundColor: AppColors.borderLight,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),

          // Page View
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildPersonalInfoStep(),
                _buildDiabetesStatusStep(),
                _buildInsulinUsageStep(),
                _buildBloodSugarStep(),
                _buildActivityLevelStep(),
                _buildGoalsStep(),
                _buildPreferencesStep(),
              ],
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: CustomButton(
                      text: 'Back',
                      onPressed: _previousStep,
                      isOutlined: true,
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: _currentStep == _totalSteps - 1 ? 'Complete' : 'Next',
                    onPressed: _canProceed() ? _nextStep : () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 8),

          Text(
            'Tell us about yourself to personalize your experience',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 32),

          // Gender Selection
          Text(
            'Gender',
            style: AppTextStyles.label.copyWith(
              color: AppColors.primary,
            ),
          ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.3, end: 0),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildGenderOption('Male', Icons.male),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildGenderOption('Female', Icons.female),
              ),
            ],
          ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 24),

          // Age Field
          CustomInputField(
            label: 'Age',
            hintText: 'Enter your age',
            icon: Icons.cake_outlined,
            controller: _ageController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              final age = int.tryParse(value);
              if (age == null || age < 1 || age > 120) {
                return 'Please enter a valid age';
              }
              return null;
            },
          ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 20),

          // Weight Field
          CustomInputField(
            label: 'Weight (kg)',
            hintText: 'Enter your weight',
            icon: Icons.monitor_weight_outlined,
            controller: _weightController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your weight';
              }
              final weight = double.tryParse(value);
              if (weight == null || weight < 1 || weight > 500) {
                return 'Please enter a valid weight';
              }
              return null;
            },
          ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 20),

          // Height Field
          CustomInputField(
            label: 'Height (cm)',
            hintText: 'Enter your height',
            icon: Icons.height_outlined,
            controller: _heightController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your height';
              }
              final height = double.tryParse(value);
              if (height == null || height < 50 || height > 250) {
                return 'Please enter a valid height';
              }
              return null;
            },
          ).animate().fadeIn(delay: 1400.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textHint,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              gender,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiabetesStatusStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Diabetes Status',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          Text(
            'Please select your diabetes status to help us provide personalized recommendations',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          ...List.generate(_diabetesStatusOptions.length, (index) {
            final status = _diabetesStatusOptions[index];
            final isSelected = _diabetesStatus == status;

            return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _diabetesStatus = status;
                  });
                },
                child: CustomCard(
                  backgroundColor: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.white,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.borderLight,
                    width: isSelected ? 2 : 1,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color:
                            isSelected ? AppColors.primary : AppColors.textHint,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          status,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(delay: (600 + index * 100).ms)
                .slideY(begin: 0.3, end: 0);
          }),
        ],
      ),
    );
  }

  Widget _buildInsulinUsageStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Insulin Usage',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          Text(
            'Do you currently use insulin? This helps us understand your treatment plan',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          ...List.generate(_insulinUsageOptions.length, (index) {
            final usage = _insulinUsageOptions[index];
            final isSelected = _insulinUsage == usage;

            return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _insulinUsage = usage;
                  });
                },
                child: CustomCard(
                  backgroundColor: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.white,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.borderLight,
                    width: isSelected ? 2 : 1,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.medication,
                        color:
                            isSelected ? AppColors.primary : AppColors.textHint,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          usage,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(delay: (600 + index * 100).ms)
                .slideY(begin: 0.3, end: 0);
          }),
          if (_insulinUsage == 'Yes, I use insulin') ...[
            const SizedBox(height: 24),
            CustomInputField(
              label: 'Insulin Dose (units)',
              hintText: 'Enter your daily insulin dose',
              icon: Icons.medication_liquid,
              controller: _insulinDoseController,
              keyboardType: TextInputType.number,
            ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0),
          ],
        ],
      ),
    );
  }

  Widget _buildBloodSugarStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Blood Sugar Reading',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 8),

          Text(
            'Please enter your most recent blood sugar reading (mg/dL)',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 32),

          CustomInputField(
            label: 'Blood Sugar Level (mg/dL)',
            hintText: 'Enter your blood sugar reading',
            icon: Icons.bloodtype,
            controller: _bloodSugarController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                // Trigger rebuild to update button state
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your blood sugar reading';
              }
              final reading = double.tryParse(value);
              if (reading == null || reading < 20 || reading > 600) {
                return 'Please enter a valid blood sugar reading';
              }
              return null;
            },
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 24),

          // Blood Sugar Level Indicator
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blood Sugar Guidelines:',
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Normal: 70-100 mg/dL\n• Pre-diabetes: 100-125 mg/dL\n• Diabetes: 126+ mg/dL',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildActivityLevelStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Level',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          Text(
            'How active are you on a daily basis? This helps us calculate your calorie needs',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          ...List.generate(_activityLevels.length, (index) {
            final level = _activityLevels[index];
            final isSelected = _activityLevel == level;

            return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _activityLevel = level;
                  });
                },
                child: CustomCard(
                  backgroundColor: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.white,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.borderLight,
                    width: isSelected ? 2 : 1,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fitness_center,
                        color:
                            isSelected ? AppColors.primary : AppColors.textHint,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          level,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(delay: (600 + index * 100).ms)
                .slideY(begin: 0.3, end: 0);
          }),
        ],
      ),
    );
  }

  Widget _buildGoalsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Goals',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          Text(
            'What are your primary health goals? Select all that apply',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _goals.map((goal) {
              final isSelected = _selectedGoals.contains(goal);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedGoals.remove(goal);
                    } else {
                      _selectedGoals.add(goal);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    goal,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildPreferencesStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dietary Preferences',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          Text(
            'What are your dietary preferences and restrictions? Select all that apply',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _preferences.map((preference) {
              final isSelected = _selectedPreferences.contains(preference);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedPreferences.remove(preference);
                    } else {
                      _selectedPreferences.add(preference);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    preference,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }
}
