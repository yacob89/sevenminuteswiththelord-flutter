import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsService {
  static final NotificationsService _instance = NotificationsService._internal();
  factory NotificationsService() => _instance;
  
  NotificationsService._internal();
  
  // Platform channels
  static const MethodChannel _notificationsChannel = MethodChannel('app.channel.notifications');
  static const MethodChannel _audioChannel = MethodChannel('app.channel.audio');
  
  // For debugging
  final bool _debugMode = true;
  
  // Initialize notification service
  Future<void> initialize() async {
    if (_debugMode) debugPrint('⏰ Initializing NotificationsService');
    
    try {
      final bool? result = await _notificationsChannel.invokeMethod<bool>('requestPermissions');
      if (_debugMode) debugPrint('⏰ Notification permissions granted: $result');
    } catch (e) {
      debugPrint('⏰ Error requesting notification permissions: $e');
    }
  }
  
  // Show notification
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (_debugMode) debugPrint('⏰ Showing notification: "$title" - "$body"');
    
    try {
      final result = await _notificationsChannel.invokeMethod<String>('showNotification', {
        'title': title,
        'body': body,
        'payload': payload ?? '',
      });
      
      if (_debugMode) debugPrint('⏰ Notification result: $result');
    } catch (e) {
      debugPrint('⏰ Error showing notification: $e');
    }
  }
  
  // Play notification sound
  Future<void> playNotificationSound() async {
    if (_debugMode) debugPrint('⏰ Playing notification sound');
    
    try {
      final result = await _audioChannel.invokeMethod<String>('playNotificationSound');
      if (_debugMode) debugPrint('⏰ Sound result: $result');
    } catch (e) {
      debugPrint('⏰ Error playing notification sound: $e');
    }
  }
  
  // Simple notification test method
  Future<void> testNotification() async {
    // showNotification(
    //   title: 'Test Notification',
    //   body: 'This is a test notification from Seven Minutes With The Lord app',
    // );
    playNotificationSound();
  }
}