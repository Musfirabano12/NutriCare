import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import 'profile_details_screen.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({super.key});

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  String? _selectedImagePath;

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
              const SizedBox(height: 40),

              // Progress indicator
              Row(
                children: [
                  _buildProgressStep(1, true),
                  _buildProgressLine(true),
                  _buildProgressStep(2, false),
                  _buildProgressLine(false),
                  _buildProgressStep(3, false),
                  _buildProgressLine(false),
                  _buildProgressStep(4, false),
                ],
              ),

              const SizedBox(height: 60),

              // Title with animation
              Text(
                'Add Your Photo',
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
                'Upload a clear photo of yourself for better personalization',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 400))
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 60),

              // Profile picture upload area
              GestureDetector(
                onTap: _selectImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: _selectedImagePath != null
                          ? AppColors.primary
                          : AppColors.borderLight,
                      width: 2,
                    ),
                    boxShadow: AppConstants.shadowLight,
                  ),
                  child: _selectedImagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            _selectedImagePath!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              size: 48,
                              color: AppColors.textHint,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to add photo',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 600))
                  .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0)),

              const Spacer(),

              // Continue button
              CustomButton(
                text: 'Continue',
                onPressed: _selectedImagePath != null
                    ? () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const ProfileDetailsScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: animation.drive(
                                  Tween(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero)
                                      .chain(
                                          CurveTween(curve: Curves.easeInOut)),
                                ),
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 300),
                          ),
                        );
                      }
                    : () {},
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 800))
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

  void _selectImage() {
    // Simulate image selection
    setState(() {
      _selectedImagePath = null; // No default image selected
    });
  }
}
