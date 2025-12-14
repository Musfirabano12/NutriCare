import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'NutriCareAI';
  static const String appVersion = '1.0.0';
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 40.0;
  
  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  
  // Button Heights
  static const double buttonHeightS = 40.0;
  static const double buttonHeightM = 50.0;
  static const double buttonHeightL = 56.0;
  
  // Input Field Heights
  static const double inputHeight = 56.0;
  
  // Icon Sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 20.0;
  static const double iconSizeL = 24.0;
  static const double iconSizeXL = 32.0;
  static const double iconSizeXXL = 48.0;
  
  // Logo Sizes
  static const double logoSizeS = 80.0;
  static const double logoSizeM = 120.0;
  static const double logoSizeL = 160.0;
  static const double logoSizeXL = 200.0;
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 40.0,
  );
  
  static const EdgeInsets cardPadding = EdgeInsets.all(24.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 16.0,
  );
  
  // Shadow Styles
  static const List<BoxShadow> shadowLight = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8.0,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 12.0,
      offset: Offset(0, 4),
    ),
  ];
  
  static const List<BoxShadow> shadowHeavy = [
    BoxShadow(
      color: Color(0x4D000000),
      blurRadius: 16.0,
      offset: Offset(0, 6),
    ),
  ];
  
  // Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}
