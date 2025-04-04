import 'package:flutter/material.dart';

class AppColors {
  // Default primary colors
  static const Color defaultPrimary = Color(0xFF673AB7); // Deep Purple
  static const Color defaultPrimaryLight = Color(0xFFEEE6FF);
  static const Color defaultPrimaryDark = Color(0xFF4527A0);
  
  // Dynamic primary colors (will be changed based on selected theme)
  static Color primary = defaultPrimary;
  static Color primaryLight = defaultPrimaryLight;
  static Color primaryDark = defaultPrimaryDark;
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Colors.white;
  
  // Background colors
  static const Color background = Colors.white;
  static const Color surfaceLight = Color(0xFFF5F5F5);
  
  // Button colors
  static const Color buttonSecondary = Color(0xFFE0E0E0);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Update theme colors
  static void updateThemeColors({
    required Color newPrimary,
    required Color newPrimaryLight,
    required Color newPrimaryDark,
  }) {
    primary = newPrimary;
    primaryLight = newPrimaryLight;
    primaryDark = newPrimaryDark;
  }
}