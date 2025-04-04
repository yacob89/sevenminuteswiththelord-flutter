import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/activity_definitions.dart';
import '../models/activity_data.dart';
import '../services/preferences_service.dart';
import '../utils/localization.dart';

class SettingsScreen extends StatefulWidget {
  final Locale locale;

  const SettingsScreen({super.key, required this.locale});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late List<ActivityData> _activities;
  final Map<String, int> _customDurations = {};
  final PreferencesService _preferencesService = PreferencesService();
  
  @override
  void initState() {
    super.initState();
    _loadActivities();
  }
  
  Future<void> _loadActivities() async {
    // Get default activities
    _activities = ActivityDefinitions.getActivities();
    
    // Load user customized durations
    final customDurations = await _preferencesService.getCustomDurations();
    
    setState(() {
      _customDurations.clear();
      _customDurations.addAll(customDurations);
    });
  }
  
  void _updateDuration(String activityId, int newDuration) {
    setState(() {
      _customDurations[activityId] = newDuration;
    });
    
    // Save to preferences
    _preferencesService.saveCustomDurations(_customDurations);
  }
  
  int _getDuration(String activityId) {
    // Get activity default duration
    final activity = _activities.firstWhere((a) => a.id == activityId);
    final defaultDuration = activity.durationInSeconds;
    
    // Return custom duration if set, otherwise return default
    return _customDurations[activityId] ?? defaultDuration;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations(widget.locale);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: const TextStyle(color: AppColors.textOnPrimary),
        ),
        elevation: 0,
      ),
      body: Container(
        color: AppColors.background,
        child: ListView(
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Activity Durations',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Customize the duration for each activity in 30-second increments. The minimum value is the default duration.',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            
            const Divider(),
            
            // Activity duration settings
            ..._activities.map((activity) => _buildActivityDurationSetting(activity, appLocalizations)),
            
            const SizedBox(height: 24.0),
            
            // Reset button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    _customDurations.clear();
                  });
                  await _preferencesService.clearCustomDurations();
                },
                icon: const Icon(Icons.restore, color: AppColors.textOnPrimary),
                label: Text(
                  'Reset to Defaults',
                  style: const TextStyle(color: AppColors.textOnPrimary),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
            
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActivityDurationSetting(ActivityData activity, AppLocalizations appLocalizations) {
    // Get current duration (custom or default)
    final currentDuration = _getDuration(activity.id);
    final defaultDuration = activity.durationInSeconds;
    
    // Format duration as minutes:seconds
    String formatDuration(int seconds) {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity name
          Text(
            appLocalizations.translate(activity.title),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          const SizedBox(height: 8.0),
          
          // Duration controls
          Row(
            children: [
              // Decrease button
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColors.primary,
                onPressed: currentDuration <= defaultDuration
                    ? null // Disable if at minimum value
                    : () => _updateDuration(activity.id, currentDuration - 30),
              ),
              
              // Current duration display
              Expanded(
                child: Text(
                  formatDuration(currentDuration),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: currentDuration > defaultDuration
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              
              // Increase button
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.primary,
                onPressed: () => _updateDuration(activity.id, currentDuration + 30),
              ),
            ],
          ),
          
          // Default duration info
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${'Default'}: ${formatDuration(defaultDuration)}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          
          const Divider(),
        ],
      ),
    );
  }
}