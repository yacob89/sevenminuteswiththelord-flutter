import 'package:flutter/material.dart';
import 'dart:async';
import '../constants/app_colors.dart';
import '../models/activity_data.dart';
import '../constants/activity_definitions.dart';
import '../services/notifications_service.dart';
import '../utils/localization.dart';
import '../widgets/custom_button.dart';
import '../widgets/timer_display.dart';

class ActivityScreen extends StatefulWidget {
  final Locale locale;
  
  const ActivityScreen({super.key, required this.locale});
  
  @override
  ActivityScreenState createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  int _currentActivityIndex = 0;
  int _seconds = 0;
  bool _isPlaying = true;
  Timer? _timer;
  late List<ActivityData> _activities;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    // Set up animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    // Set up fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    
    // Load customized activities
    _loadActivities();
  }
  
  Future<void> _loadActivities() async {
    try {
      // Load customized activities
      final customizedActivities = await ActivityDefinitions.getCustomizedActivities();
      
      setState(() {
        _activities = customizedActivities;
        _seconds = _activities[_currentActivityIndex].durationInSeconds;
        _isLoading = false;
      });
      
      // Start animation and timer
      _animationController.forward();
      _startTimer();
    } catch (e) {
      // Fallback to default activities if there's an error
      setState(() {
        _activities = ActivityDefinitions.getActivities();
        _seconds = _activities[_currentActivityIndex].durationInSeconds;
        _isLoading = false;
      });
      
      // Start animation and timer
      _animationController.forward();
      _startTimer();
    }
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }
  
  // Start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          _playNotificationSound();
          _showLocalNotification();
          _moveToNextActivity();
        }
      });
    });
  }
  
  // Play a notification sound when activity completes
  void _playNotificationSound() {
    NotificationsService().playNotificationSound();
  }
  
  // Show a local notification when activity completes
  void _showLocalNotification() {
    final activity = _activities[_currentActivityIndex];
    final nextActivityIndex = _currentActivityIndex < _activities.length - 1 
        ? _currentActivityIndex + 1 
        : 0;
    
    final nextActivity = nextActivityIndex < _activities.length
        ? _activities[nextActivityIndex]
        : null;
    
    final appLocalizations = AppLocalizations(widget.locale);
    String title = appLocalizations.translate(activity.id);
    String body;
    
    if (nextActivity != null) {
      body = '${appLocalizations.translate('completed')}. ${appLocalizations.translate('next')}: ${appLocalizations.translate(nextActivity.id)}';
    } else {
      body = appLocalizations.translate('allActivitiesCompleted');
    }
    
    NotificationsService().showNotification(
      title: title,
      body: body,
    );
  }

  // Pause the timer
  void _pauseTimer() {
    setState(() {
      _isPlaying = false;
      _timer?.cancel();
    });
  }

  // Resume the timer
  void _resumeTimer() {
    setState(() {
      _isPlaying = true;
      _startTimer();
    });
  }

  // Move to the next activity
  void _moveToNextActivity() {
    if (_currentActivityIndex < _activities.length - 1) {
      // Reset animation for transition effect
      _animationController.reset();
      
      setState(() {
        _timer?.cancel();
        _currentActivityIndex++;
        _seconds = _activities[_currentActivityIndex].durationInSeconds;
        _isPlaying = true;
      });
      
      // Start animation and timer for new activity
      _animationController.forward();
      _startTimer();
    } else {
      // All activities completed, go back to first screen
      Navigator.pop(context);
    }
  }

  // Move to the previous activity
  void _moveToPreviousActivity() {
    if (_currentActivityIndex > 0) {
      // Reset animation for transition effect
      _animationController.reset();
      
      setState(() {
        _timer?.cancel();
        _currentActivityIndex--;
        _seconds = _activities[_currentActivityIndex].durationInSeconds;
        _isPlaying = true;
      });
      
      // Start animation and timer for new activity
      _animationController.forward();
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations(widget.locale);
    
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Loading...',
            style: const TextStyle(color: AppColors.textOnPrimary),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }
    
    final currentActivity = _activities[_currentActivityIndex];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          appLocalizations.translate(currentActivity.id),
          style: const TextStyle(color: AppColors.textOnPrimary),
        ),
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Activity description
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  appLocalizations.translate('${currentActivity.id}Description'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16, 
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Timer display
              TimerDisplay(seconds: _seconds),
              
              const SizedBox(height: 50),
              
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Previous button
                  RoundIconButton(
                    icon: Icons.skip_previous,
                    onPressed: _moveToPreviousActivity,
                    backgroundColor: AppColors.buttonSecondary,
                    iconColor: AppColors.primary,
                  ),
                  
                  const SizedBox(width: 20),
                  
                  // Play/Pause button
                  RoundIconButton(
                    icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: _isPlaying ? _pauseTimer : _resumeTimer,
                    backgroundColor: AppColors.primary,
                    iconColor: AppColors.textOnPrimary,
                    size: 70,
                  ),
                  
                  const SizedBox(width: 20),
                  
                  // Next button
                  RoundIconButton(
                    icon: Icons.skip_next,
                    onPressed: _moveToNextActivity,
                    backgroundColor: AppColors.buttonSecondary,
                    iconColor: AppColors.primary,
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Back button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  appLocalizations.translate('goBack'),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}