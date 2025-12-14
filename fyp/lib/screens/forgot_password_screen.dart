import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isEmailSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Backend URL
      final url = Uri.parse('http://127.0.0.1:8000/auth/forgot-password');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': _emailController.text}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isEmailSent = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['detail'] ?? 'Failed to send reset email'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child:
              _isEmailSent ? _buildEmailSentView() : _buildForgotPasswordForm(),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Forgot Password?',
            style:
                AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 8),
          Text(
            'Don\'t worry! Enter your email and we\'ll send you a reset link.',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 40),
          CustomInputField(
            label: 'Email',
            hintText: 'Enter your email address',
            icon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Please enter your email';
              if (!value.contains('@')) return 'Please enter a valid email';
              return null;
            },
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 32),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  text: 'Send Reset Email',
                  onPressed: _sendResetEmail,
                ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Remember your password? ',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Login',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildEmailSentView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read,
            color: AppColors.success,
            size: 64,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms)
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
        const SizedBox(height: 32),
        Text(
          'Email Sent!',
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Text(
          'We\'ve sent a password reset link to your email address. Please check your inbox and follow the instructions.',
          style:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 48),
        CustomButton(
          text: 'Back to Login',
          onPressed: () => Navigator.pop(context),
        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Resend Email',
          onPressed: () {
            setState(() {
              _isEmailSent = false;
            });
          },
          isOutlined: true,
        ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0),
      ],
    );
  }
}
