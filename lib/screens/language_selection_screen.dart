import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/localization.dart';
import '../widgets/custom_button.dart';
import '../services/notifications_service.dart';
import 'activity_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> with SingleTickerProviderStateMixin {
  String _selectedLanguage = 'English';
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  
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
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  void _setLocale(BuildContext context, String language) {
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
      default:
        locale = Locale('en', '');
    }
    
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => ActivityScreen(locale: locale),
      ),
    );
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
          color: AppColors.primary,
        ),
        child: Column(
          children: <Widget>[
            // App title section
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: _fadeInAnimation,
                child: Text(
                  appLocalizations?.translate('appTitle') ?? 'Seven Minutes With The Lord',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                              setState(() {
                                _selectedLanguage = newValue!;
                              });
                            },
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                            ),
                            items: <String>['عربي', 'Bahasa Indonesia', '中文(简体)', '中文(繁體)', 'Deutsch', 'English',  'Español', '한국어', 'Portuguese', 'русский язык', 'Tagalog', 'українська мова']
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
                        
                        // Test notification button (for debugging)
                        SizedBox(height: 20),
                        TextButton.icon(
                          icon: Icon(Icons.notifications, color: AppColors.primary),
                          label: Text('Test notification'),
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