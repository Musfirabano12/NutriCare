import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Heading Styles - Exact from Figma
  static final TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  static final TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  static final TextStyle heading3 = GoogleFonts.poppins(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );
  
  static final TextStyle heading4 = GoogleFonts.poppins(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // Body Styles - Exact from Figma
  static final TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
  
  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
  
  static final TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
  
  // Label and Caption Styles
  static final TextStyle label = GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  
  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );
  
  // Button Style
  static final TextStyle button = GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
