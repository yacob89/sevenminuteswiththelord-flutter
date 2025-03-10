import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/language_selection_screen.dart';
import 'utils/localization.dart';
import 'services/notifications_service.dart';
import 'services/wakelock_service.dart';
import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notification service
  await NotificationsService().initialize();
  
  // Initialize wake lock service to keep screen on
  await WakeLockService().initialize();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          color: AppColors.primary,
          elevation: 0,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primary,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
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
      ],
    );
  }
}