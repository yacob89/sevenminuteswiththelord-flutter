import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/language_selection_screen.dart';
import 'utils/localization.dart';
import 'services/notifications_service.dart';
import 'services/wakelock_service.dart';
import 'services/theme_service.dart';
import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notification service
  await NotificationsService().initialize();
  
  // Initialize wake lock service to keep screen on
  await WakeLockService().initialize();
  
  // Initialize theme
  final themeService = ThemeService();
  await themeService.loadSavedTheme();
  
  // Update AppColors with the saved theme
  final currentTheme = themeService.currentTheme;
  AppColors.updateThemeColors(
    newPrimary: currentTheme.primary,
    newPrimaryLight: currentTheme.primaryLight,
    newPrimaryDark: currentTheme.primaryDark,
  );
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final ThemeService _themeService = ThemeService();
  
  @override
  void initState() {
    super.initState();
    // Register to observe app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void dispose() {
    // Unregister observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Ensure wake lock is enabled when app is resumed
    if (state == AppLifecycleState.resumed) {
      WakeLockService().enableWakeLock();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seven Minutes With The Lord',
      debugShowCheckedModeBanner: false,
      theme: _themeService.getThemeData(),
      home: LanguageSelectionScreen(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English
        Locale('de', ''), // German
        Locale('es', ''), // Spanish
        Locale('ar', ''), // Arabic
        Locale('id', ''), // Bahasa Indonesia
        Locale('zh', ''), // Chinese (Simplified)
        Locale('zt', ''), // Chinese (Traditional)
        Locale('ko', ''), // Korean
        Locale('pt', ''), // Portuguese
        Locale('ru', ''), // Russian
        Locale('tl', ''), // Tagalog
        Locale('uk', ''), // Ukrainian
      ],
    );
  }
}