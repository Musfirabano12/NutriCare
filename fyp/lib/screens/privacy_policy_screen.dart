import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 255, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(227, 255, 249, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/logo.jpeg',
          height: 100,
          width: 100,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Privacy & Data Protection',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your privacy and data security are our top priorities',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 40),

              // Policy Cards
              _buildPolicyCard(
                icon: Icons.security,
                title: 'Data is Safe',
                description: 'We use industry-standard encryption to protect your personal information and health data.',
                color: const Color(0xFF4ECDC4),
              ),
              const SizedBox(height: 16),

              _buildPolicyCard(
                icon: Icons.block,
                title: 'Data not Sold',
                description: 'We never sell, rent, or share your personal information with third parties for marketing purposes.',
                color: const Color(0xFFFF6B6B),
              ),
              const SizedBox(height: 16),

              _buildPolicyCard(
                icon: Icons.lock,
                title: 'Encryption',
                description: 'All data is encrypted in transit and at rest using AES-256 encryption standards.',
                color: const Color(0xFF38ADB6),
              ),
              const SizedBox(height: 16),

              _buildPolicyCard(
                icon: Icons.storage,
                title: 'Secure Storage',
                description: 'Your data is stored on secure, HIPAA-compliant servers with regular security audits.',
                color: const Color(0xFF96CEB4),
              ),
              const SizedBox(height: 16),

              _buildPolicyCard(
                icon: Icons.gavel,
                title: 'Your Rights',
                description: 'You have the right to access, modify, or delete your data at any time through your account settings.',
                color: const Color(0xFF45B7D1),
              ),
              const SizedBox(height: 50),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Decline',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.transparent,
                      textColor: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: 'Accept & Continue',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      },
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
