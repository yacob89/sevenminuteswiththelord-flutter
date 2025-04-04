import 'package:flutter/foundation.dart';

// Notifier for theme changes
class ThemeChangeNotifier {
  // Singleton pattern implementation
  static final ThemeChangeNotifier _instance = ThemeChangeNotifier._internal();
  factory ThemeChangeNotifier() => _instance;
  ThemeChangeNotifier._internal();
  
  // ValueNotifier to broadcast theme changes
  final ValueNotifier<bool> themeChanged = ValueNotifier<bool>(false);
  
  // Notify listeners of theme change
  void notifyThemeChanged() {
    themeChanged.value = !themeChanged.value;
  }
}