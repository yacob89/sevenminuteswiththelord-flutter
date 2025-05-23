import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/localization.dart';
import '../widgets/custom_button.dart';
import '../services/notifications_service.dart';
import '../services/preferences_service.dart';
import '../utils/theme_change_notification.dart';
import 'activity_screen.dart';
import 'settings_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  LanguageSelectionScreenState createState() => LanguageSelectionScreenState();
}

class LanguageSelectionScreenState extends State<LanguageSelectionScreen> with SingleTickerProviderStateMixin {
  String _selectedLanguage = 'English';
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  Locale _currentLocale = Locale('en', '');
  final PreferencesService _preferencesService = PreferencesService();
  final ThemeChangeNotifier _themeChangeNotifier = ThemeChangeNotifier();
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    
    // Listen for theme changes to rebuild this screen
    _themeChangeNotifier.themeChanged.addListener(_onThemeChanged);
    
    _loadSavedLanguage();
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _themeChangeNotifier.themeChanged.removeListener(_onThemeChanged);
    super.dispose();
  }
  
  // Rebuild screen when theme changes
  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        // Rebuild with new theme
      });
    }
  }
  
  // Load the saved language if any
  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await _preferencesService.getSelectedLanguage();
    if (savedLanguage != null && mounted) {
      setState(() {
        _selectedLanguage = savedLanguage;
        _setLocaleWithoutNavigation(savedLanguage);
      });
    }
  }
  
  // Set locale without navigation (used for loading saved language)
  void _setLocaleWithoutNavigation(String language) {
    Locale locale;
    switch (language) {
      case 'Deutsch':
        locale = Locale('de', '');
        break;
      case 'Español':
        locale = Locale('es', '');
        break;
      case 'عربي':
        locale = Locale('ar', '');
        break;
      case 'Bahasa Indonesia':
        locale = Locale('id', '');
        break;
      case '中文(简体)':
        locale = Locale('zh', '');
        break;
      case '中文(繁體)':
        locale = Locale('zt', '');
        break;
      case '日本語':
        locale = Locale('ja', '');
        break;
      case '한국어':
        locale = Locale('ko', '');
        break;
      case 'Portuguese':
        locale = Locale('pt', '');
        break;
      case 'русский язык':
        locale = Locale('ru', '');
        break;
      case 'Tagalog':
        locale = Locale('tl', '');
        break;
      case 'українська мова':
        locale = Locale('uk', '');
        break;
      case 'فارسی':
        locale = Locale('fa', '');
        break;
      case 'ქართული':
        locale = Locale('ka', '');
        break;
      case 'Język polski':
        locale = Locale('pl', '');
        break;
      case 'தமிழ்':
        locale = Locale('ta', '');
        break;
      default:
        locale = Locale('en', '');
    }
    
    setState(() {
      _currentLocale = locale;
    });
  }
  
  void _setLocale(BuildContext context, String language) {
    // Set the locale
    _setLocaleWithoutNavigation(language);
    
    // Save the selected language
    _preferencesService.saveSelectedLanguage(language);
    
    // Navigate to the activity screen
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => ActivityScreen(locale: _currentLocale),
      ),
    );
  }
  
  void _openSettings() async {
    // Navigate to settings and wait for result
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(locale: _currentLocale),
      ),
    );
    
    // Force rebuild after returning from settings
    if (mounted) {
      setState(() {
        // Rebuild with current theme
      });
    }
  }
  
  void _testNotification() {
    NotificationsService().testNotification();
  }
  
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primary, // This will update with the new theme
        ),
        child: Column(
          children: <Widget>[
            // App title section with settings button
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Stack(
                children: [
                  // App title
                  Center(
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Text(
                        appLocalizations?.translate('appTitle') ?? '7 Minutes With The Lord',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  // Settings button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: AppColors.textOnPrimary,
                        size: 28,
                      ),
                      onPressed: _openSettings,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content section with white background
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          appLocalizations?.translate('language') ?? 'Language',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Language dropdown
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(bottom: 50),
                          child: DropdownButtonFormField<String>(
                            value: _selectedLanguage,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary, width: 2),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedLanguage = newValue;
                                });
                              }
                            },
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                            ),
                            items: <String>['عربي', 'Bahasa Indonesia', '中文(简体)', '中文(繁體)', 'Deutsch', 'English',  'Español', '日本語', 'فارسی', 'ქართული', 'Język polski', '한국어', 'Portuguese', 'русский язык', 'Tagalog', 'தமிழ்', 'українська мова']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        // Start button
                        PrimaryButton(
                          text: appLocalizations?.translate('start') ?? 'Start!',
                          onPressed: () => _setLocale(context, _selectedLanguage),
                        ),
                        SizedBox(height: 20),
                        TextButton.icon(
                          icon: Icon(Icons.notifications, color: AppColors.primary),
                          label: Text('Test notification sound'),
                          onPressed: _testNotification,
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}