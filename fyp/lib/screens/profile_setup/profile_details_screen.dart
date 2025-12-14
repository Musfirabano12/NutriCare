import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import 'profile_goals_screen.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _selectedGender = '';

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

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
          child: Form(
            key: _formKey,
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
                    _buildProgressStep(3, false),
                    _buildProgressLine(false),
                    _buildProgressStep(4, false),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Title with animation
                Text(
                  'Personal Details',
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
                  'Tell us about yourself for personalized recommendations',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 400))
                    .slideY(begin: 0.3, end: 0),
                
                const SizedBox(height: 40),
                
                // Form fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Age field
                        CustomInput(
                          label: 'Age',
                          hintText: 'Enter your age',
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Age is required';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 600))
                            .slideX(begin: -0.3, end: 0),
                        
                        const SizedBox(height: 20),
                        
                        // Gender selection
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
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
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 700))
                            .slideX(begin: -0.3, end: 0),
                        
                        const SizedBox(height: 20),
                        
                        // Weight field
                        CustomInput(
                          label: 'Weight (kg)',
                          hintText: 'Enter your weight',
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Weight is required';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid weight';
                            }
                            return null;
                          },
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 800))
                            .slideX(begin: -0.3, end: 0),
                        
                        const SizedBox(height: 20),
                        
                        // Height field
                        CustomInput(
                          label: 'Height (cm)',
                          hintText: 'Enter your height',
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Height is required';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid height';
                            }
                            return null;
                          },
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 900))
                            .slideX(begin: -0.3, end: 0),
                      ],
                    ),
                  ),
                ),
                
                // Continue button
                CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _selectedGender.isNotEmpty) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const ProfileGoalsScreen(),
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

  Widget _buildGenderOption(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              gender,
              style: AppTextStyles.bodySmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
