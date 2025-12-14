import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF38ADB6);
  static const Color primaryLight = Color(0xFF4ECDC4);
  static const Color primaryDark = Color(0xFF2A8B91);
  
  // Background Colors
  static const Color background = Color.fromRGBO(227, 255, 249, 1);
  static const Color white = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color textLight = Color(0xFFCCCCCC);
  
  // Accent Colors
  static const Color accent = Color(0xFF4ECDC4);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  
  // Health Stats Colors
  static const Color calories = Color(0xFFFF6B6B);
  static const Color water = Color(0xFF4ECDC4);
  static const Color steps = Color(0xFF45B7D1);
  static const Color sleep = Color(0xFF96CEB4);
  
  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMedium = Color(0xFFCCCCCC);
  static const Color borderDark = Color(0xFF999999);
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [background, white],
  );
}
