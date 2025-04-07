import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/activity_definitions.dart';
import '../models/activity_data.dart';
import '../services/preferences_service.dart';
import '../services/theme_service.dart';
import '../utils/localization.dart';

class SettingsScreen extends StatefulWidget {
  final Locale locale;

  const SettingsScreen({super.key, required this.locale});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late List<ActivityData> _activities;
  final Map<String, int> _customDurations = {};
  final PreferencesService _preferencesService = PreferencesService();
  final ThemeService _themeService = ThemeService();
  String _selectedTheme = 'purple'; // Default theme
  String _pendingTheme =
      'purple'; // Theme that will be applied when Apply button is pressed

  @override
  void initState() {
    super.initState();
    _loadActivities();
    _loadSelectedTheme();
  }

  Future<void> _loadSelectedTheme() async {
    final savedTheme = await _preferencesService.getSelectedTheme();
    if (savedTheme != null && mounted) {
      setState(() {
        _selectedTheme = savedTheme;
        _pendingTheme = savedTheme;
      });
    }
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

  // Select theme (just updates UI, doesn't apply yet)
  void _selectTheme(String themeKey) {
    if (_pendingTheme != themeKey) {
      setState(() {
        _pendingTheme = themeKey;
      });
    }
  }

  // Apply and save the selected theme
  Future<void> _applyTheme() async {
    if (_selectedTheme != _pendingTheme) {
      // Apply theme immediately
      _themeService.applyTheme(_pendingTheme);

      // Save theme to preferences
      await _themeService.saveTheme(_pendingTheme);

      setState(() {
        _selectedTheme = _pendingTheme;
      });

      // Show success snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Theme applied successfully'),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations(widget.locale);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
          onPressed: () {
            Navigator.pop(
              context,
              true,
            ); // Return true to indicate settings were changed
          },
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
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
            ..._activities.map(
              (activity) =>
                  _buildActivityDurationSetting(activity, appLocalizations),
            ),

            const SizedBox(height: 16.0),

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

            const SizedBox(height: 16.0),

            // Theme selection section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'App Theme',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Theme description
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                'Choose a color theme for the app.',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const Divider(),

            // Theme options
            _buildThemeSelector(appLocalizations),

            // Apply Theme button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: ElevatedButton.icon(
                onPressed: _applyTheme,
                icon: const Icon(
                  Icons.check_circle,
                  color: AppColors.textOnPrimary,
                ),
                label: Text(
                  'Apply Theme',
                  style: const TextStyle(color: AppColors.textOnPrimary),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),

            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityDurationSetting(
    ActivityData activity,
    AppLocalizations appLocalizations,
  ) {
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
                onPressed:
                    currentDuration <= defaultDuration
                        ? null // Disable if at minimum value
                        : () =>
                            _updateDuration(activity.id, currentDuration - 30),
              ),

              // Current duration display
              Expanded(
                child: Text(
                  formatDuration(currentDuration),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        currentDuration > defaultDuration
                            ? AppColors.primary
                            : AppColors.textPrimary,
                  ),
                ),
              ),

              // Increase button
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.primary,
                onPressed:
                    () => _updateDuration(activity.id, currentDuration + 30),
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

  // Build theme selection grid
  Widget _buildThemeSelector(AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: ThemeService.themeOptions.length,
        itemBuilder: (context, index) {
          final themeKey = ThemeService.themeOptions.keys.elementAt(index);
          final theme = ThemeService.themeOptions[themeKey]!;
          final isSelected = _pendingTheme == themeKey;

          return GestureDetector(
            onTap: () => _selectTheme(themeKey),
            child: Container(
              decoration: BoxDecoration(
                color: theme.primaryLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? theme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: theme.primary,
                      shape: BoxShape.circle,
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: theme.primary.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ]
                              : null,
                    ),
                    child:
                        isSelected
                            ? Icon(Icons.check, color: Colors.white)
                            : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    theme.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
