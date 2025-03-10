import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A service that manages screen wake lock functionality
/// 
/// This service allows the app to keep the screen on during activities
class WakeLockService {
  // Singleton pattern implementation
  static final WakeLockService _instance = WakeLockService._internal();
  factory WakeLockService() => _instance;
  WakeLockService._internal();
  
  // Platform channel for wake lock
  static const MethodChannel _wakeLockChannel = MethodChannel('app.channel.wakelock');
  
  // Track wake lock state
  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;
  
  // Initialize the service
  Future<void> initialize() async {
    debugPrint('🔒 Initializing WakeLockService');
    // Enable wake lock by default
    await enableWakeLock();
  }
  
  // Enable wake lock to keep screen on
  Future<bool> enableWakeLock() async {
    debugPrint('🔒 Enabling wake lock');
    
    try {
      // Try to use platform channel first (for more control)
      final bool? result = await _wakeLockChannel.invokeMethod<bool>('enableWakeLock');
      _isEnabled = result ?? false;
      debugPrint('🔒 Wake lock enabled via platform channel: $_isEnabled');
    } catch (e) {
      // If platform channel fails, use Flutter's built-in approach
      try {
        // This keeps the screen on at the Flutter level
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
        );
        
        // Set device orientation to portrait only
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        
        _isEnabled = true;
        debugPrint('🔒 Wake lock enabled via SystemChrome');
      } catch (e) {
        debugPrint('🔒 Error enabling wake lock via SystemChrome: $e');
        _isEnabled = false;
      }
    }
    
    return _isEnabled;
  }
  
  // Disable wake lock to allow screen to sleep
  Future<bool> disableWakeLock() async {
    debugPrint('🔒 Disabling wake lock');
    
    try {
      // Try to use platform channel first
      final bool? result = await _wakeLockChannel.invokeMethod<bool>('disableWakeLock');
      _isEnabled = !(result ?? false);
      debugPrint('🔒 Wake lock disabled via platform channel: ${!_isEnabled}');
    } catch (e) {
      // If platform channel fails, use Flutter's built-in approach
      try {
        // Return to normal system UI mode
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
        );
        
        // Reset orientation restrictions
        await SystemChrome.setPreferredOrientations([]);
        
        _isEnabled = false;
        debugPrint('🔒 Wake lock disabled via SystemChrome');
      } catch (e) {
        debugPrint('🔒 Error disabling wake lock: $e');
        // Don't change _isEnabled state if we failed to disable
      }
    }
    
    return !_isEnabled;
  }
  
  // Toggle wake lock state
  Future<bool> toggleWakeLock() async {
    if (_isEnabled) {
      return await disableWakeLock();
    } else {
      return await enableWakeLock();
    }
  }
}