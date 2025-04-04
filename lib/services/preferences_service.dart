import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that manages user preferences like activity durations
class PreferencesService {
  // Singleton pattern implementation
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();
  
  // Keys for preferences
  static const String _customDurationsKey = 'custom_activity_durations';
  static const String _selectedLanguageKey = 'selected_language';
  static const String _selectedThemeKey = 'selected_theme';
  
  // Save custom durations to shared preferences
  Future<void> saveCustomDurations(Map<String, int> durations) async {
    try {
      debugPrint('💾 Saving custom durations: $durations');
      final prefs = await SharedPreferences.getInstance();
      
      // Convert durations map to a simple string format for storage
      // Format: "activityId:duration,activityId2:duration2"
      final durationsString = durations.entries
          .map((entry) => '${entry.key}:${entry.value}')
          .join(',');
      
      await prefs.setString(_customDurationsKey, durationsString);
    } catch (e) {
      debugPrint('💾 Error saving custom durations: $e');
    }
  }
  
  // Get custom durations from shared preferences
  Future<Map<String, int>> getCustomDurations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final durationsString = prefs.getString(_customDurationsKey) ?? '';
      
      if (durationsString.isEmpty) {
        return {};
      }
      
      // Parse the string back into a map
      final durationsMap = <String, int>{};
      durationsString.split(',').forEach((item) {
        final parts = item.split(':');
        if (parts.length == 2) {
          final activityId = parts[0];
          final duration = int.tryParse(parts[1]) ?? 0;
          if (duration > 0) {
            durationsMap[activityId] = duration;
          }
        }
      });
      
      debugPrint('💾 Loaded custom durations: $durationsMap');
      return durationsMap;
    } catch (e) {
      debugPrint('💾 Error loading custom durations: $e');
      return {};
    }
  }
  
  // Clear all custom durations
  Future<void> clearCustomDurations() async {
    try {
      debugPrint('💾 Clearing custom durations');
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_customDurationsKey);
    } catch (e) {
      debugPrint('💾 Error clearing custom durations: $e');
    }
  }
  
  // Save selected language
  Future<void> saveSelectedLanguage(String language) async {
    try {
      debugPrint('💾 Saving selected language: $language');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_selectedLanguageKey, language);
    } catch (e) {
      debugPrint('💾 Error saving selected language: $e');
    }
  }
  
  // Get selected language
  Future<String?> getSelectedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final language = prefs.getString(_selectedLanguageKey);
      debugPrint('💾 Retrieved selected language: $language');
      return language;
    } catch (e) {
      debugPrint('💾 Error getting selected language: $e');
      return null;
    }
  }
  
  // Save selected theme
  Future<void> saveSelectedTheme(String theme) async {
    try {
      debugPrint('💾 Saving selected theme: $theme');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_selectedThemeKey, theme);
    } catch (e) {
      debugPrint('💾 Error saving selected theme: $e');
    }
  }
  
  // Get selected theme
  Future<String?> getSelectedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final theme = prefs.getString(_selectedThemeKey);
      debugPrint('💾 Retrieved selected theme: $theme');
      return theme;
    } catch (e) {
      debugPrint('💾 Error getting selected theme: $e');
      return null;
    }
  }
}