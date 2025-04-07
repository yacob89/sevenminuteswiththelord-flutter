import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/preferences_service.dart';
import '../utils/theme_change_notification.dart';

class ThemeService {
  // Singleton pattern implementation
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  final PreferencesService _preferencesService = PreferencesService();
  final ThemeChangeNotifier _themeChangeNotifier = ThemeChangeNotifier();

  // Available theme options
  static const Map<String, ThemeOption> themeOptions = {
    'purple': ThemeOption(
      name: 'Purple',
      primary: AppColors.defaultPrimary,
      primaryLight: AppColors.defaultPrimaryLight,
      primaryDark: AppColors.defaultPrimaryDark,
    ),
    'blue': ThemeOption(
      name: 'Blue',
      primary: Color(0xFF2196F3),
      primaryLight: Color(0xFFE3F2FD),
      primaryDark: Color(0xFF1976D2),
    ),
    'teal': ThemeOption(
      name: 'Teal',
      primary: Color(0xFF009688),
      primaryLight: Color(0xFFE0F2F1),
      primaryDark: Color(0xFF00796B),
    ),
    'green': ThemeOption(
      name: 'Green',
      primary: Color(0xFF4CAF50),
      primaryLight: Color(0xFFE8F5E9),
      primaryDark: Color(0xFF388E3C),
    ),
    'red': ThemeOption(
      name: 'Red',
      primary: Color(0xFFF44336),
      primaryLight: Color(0xFFFFEBEE),
      primaryDark: Color(0xFFD32F2F),
    ),
    'orange': ThemeOption(
      name: 'Orange',
      primary: Color(0xFFFF9800),
      primaryLight: Color(0xFFFFF3E0),
      primaryDark: Color(0xFFF57C00),
    ),
  };

  // Current theme
  ThemeOption _currentTheme = themeOptions['purple']!;

  // Get current theme
  ThemeOption get currentTheme => _currentTheme;

  // Load saved theme
  Future<void> loadSavedTheme() async {
    final themeKey = await _preferencesService.getSelectedTheme();
    if (themeKey != null && themeOptions.containsKey(themeKey)) {
      _currentTheme = themeOptions[themeKey]!;
    }
  }

  // Save selected theme
  Future<void> saveTheme(String themeKey) async {
    if (themeOptions.containsKey(themeKey)) {
      _currentTheme = themeOptions[themeKey]!;
      await _preferencesService.saveSelectedTheme(themeKey);
      _themeChangeNotifier.notifyThemeChanged();
    }
  }

  // Apply theme immediately (without saving to preferences)
  void applyTheme(String themeKey) {
    if (themeOptions.containsKey(themeKey)) {
      _currentTheme = themeOptions[themeKey]!;

      // Update AppColors
      AppColors.updateThemeColors(
        newPrimary: _currentTheme.primary,
        newPrimaryLight: _currentTheme.primaryLight,
        newPrimaryDark: _currentTheme.primaryDark,
      );

      // Notify listeners that theme has changed
      _themeChangeNotifier.notifyThemeChanged();
    }
  }

  // Get a ThemeData object for the current theme
  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: _currentTheme.primary,
      scaffoldBackgroundColor: AppColors.background,
      primarySwatch: _createMaterialColor(_currentTheme.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(color: _currentTheme.primary, elevation: 0),
      buttonTheme: ButtonThemeData(
        buttonColor: _currentTheme.primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  // Create a MaterialColor from a single Color
  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
    Map<int, Color> swatch = {};

    // Convert the double values to int
    final int r = color.r.toInt();
    final int g = color.g.toInt();
    final int b = color.b.toInt();

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        (r + ((ds < 0 ? r : (255 - r)) * ds).round()).toInt(),
        (g + ((ds < 0 ? g : (255 - g)) * ds).round()).toInt(),
        (b + ((ds < 0 ? b : (255 - b)) * ds).round()).toInt(),
        1,
      );
    }

    // Use color.toARGB32() instead of color.value
    return MaterialColor(color.toARGB32(), swatch);
  }
}

// Theme option model
class ThemeOption {
  final String name;
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;

  const ThemeOption({
    required this.name,
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
  });
}
