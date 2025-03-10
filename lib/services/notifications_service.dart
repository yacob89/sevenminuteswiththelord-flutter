import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// NotificationsService
/// 
/// A service that handles local notifications and sound alerts without external packages.
/// This implementation uses platform channels to communicate with native code.
class NotificationsService {
  // Singleton pattern implementation
  static final NotificationsService _instance = NotificationsService._internal();
  
  // Factory constructor that returns the singleton instance
  factory NotificationsService() => _instance;
  
  // Named constructor for singleton
  NotificationsService._internal();
  
  // Platform channel for notifications
  static const MethodChannel _notificationsChannel = MethodChannel('app.channel.notifications');
  
  // Platform channel for audio/sound
  static const MethodChannel _audioChannel = MethodChannel('app.channel.audio');
  
  /// Initialize the notification service
  /// 
  /// This should be called once at app startup
  Future<void> initialize() async {
    debugPrint('Initializing notification service');
    try {
      // Request notification permissions from the platform
      await _requestPermissions();
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
    }
  }
  
  /// Request notification permissions from the platform
  /// 
  /// For iOS, this will request permission from the user to show notifications
  /// For Android 13+, this will trigger the runtime permission request dialog
  Future<bool> _requestPermissions() async {
    try {
      final bool result = await _notificationsChannel.invokeMethod('requestPermissions');
      debugPrint('Notification permissions granted: $result');
      return result;
    } on PlatformException catch (e) {
      debugPrint("Failed to request notification permissions: '${e.message}'");
      return false;
    } catch (e) {
      debugPrint("Unknown error requesting permissions: $e");
      return false;
    }
  }
  
  /// Show a local notification
  /// 
  /// Parameters:
  /// - title: The title of the notification
  /// - body: The body text of the notification
  /// - payload: Optional payload data to be passed with the notification
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('Showing notification: $title - $body');
    
    try {
      await _notificationsChannel.invokeMethod('showNotification', {
        'title': title,
        'body': body,
        'payload': payload,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to show notification: '${e.message}'");
    } catch (e) {
      debugPrint("Unknown error showing notification: $e");
    }
  }
  
  /// Play a notification sound
  /// 
  /// This will play the default system notification sound
  Future<void> playNotificationSound() async {
    debugPrint('Playing notification sound');
    
    try {
      await _audioChannel.invokeMethod('playNotificationSound');
    } on PlatformException catch (e) {
      debugPrint("Failed to play notification sound: '${e.message}'");
    } catch (e) {
      debugPrint("Unknown error playing sound: $e");
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                    NATIVE CODE IMPLEMENTATION REFERENCE                    */
/* -------------------------------------------------------------------------- */
/*                                                                            */
/* The following sections contain sample code that should be implemented      */
/* in your Android and iOS projects to handle the platform channel methods.   */
/* Copy these implementations to the appropriate native files.                */
/*                                                                            */
/* -------------------------------------------------------------------------- */

// ANDROID IMPLEMENTATION (Kotlin)
// File: android/app/src/main/kotlin/your/package/name/MainActivity.kt
/*
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.RingtoneManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull

class MainActivity: FlutterActivity() {
    private val NOTIFICATIONS_CHANNEL = "app.channel.notifications"
    private val AUDIO_CHANNEL = "app.channel.audio"
    
    private val CHANNEL_ID = "seven_minutes_with_the_lord_channel"
    private val CHANNEL_NAME = "Prayer Notifications"
    private val CHANNEL_DESCRIPTION = "Notifications for prayer activities"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Create notification channel for Android O and above
        createNotificationChannel()
        
        // Set up notifications method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NOTIFICATIONS_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "requestPermissions" -> {
                        // For Android 13+ (API 33+), request notification permission at runtime
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            ActivityCompat.requestPermissions(
                                this,
                                arrayOf(android.Manifest.permission.POST_NOTIFICATIONS),
                                0
                            )
                            // Just return success as the result, the actual permission result 
                            // will be handled in onRequestPermissionsResult
                            result.success(true)
                        } else {
                            // Prior to Android 13, permission was granted at install time
                            result.success(true)
                        }
                    }
                    "showNotification" -> {
                        val title = call.argument<String>("title") ?: ""
                        val body = call.argument<String>("body") ?: ""
                        val payload = call.argument<String>("payload")
                        
                        showNotification(title, body, payload)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        
        // Set up audio method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, AUDIO_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "playNotificationSound" -> {
                        playNotificationSound()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
    
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(CHANNEL_ID, CHANNEL_NAME, importance).apply {
                description = CHANNEL_DESCRIPTION
                enableLights(true)
                enableVibration(true)
            }
            
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
    
    private fun showNotification(title: String, body: String, payload: String?) {
        // Create an intent to open the app when notification is tapped
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
            putExtra("notification_payload", payload)
        }
        
        val pendingIntentFlags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT
        }
        
        val pendingIntent = PendingIntent.getActivity(
            this, 0, intent, pendingIntentFlags
        )
        
        // Create notification
        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_notification) // Make sure you have this icon in your drawable resources
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION))
        
        // Show notification
        val notificationManager = NotificationManagerCompat.from(this)
        
        if (ActivityCompat.checkSelfPermission(
                this,
                android.Manifest.permission.POST_NOTIFICATIONS
            ) == PackageManager.PERMISSION_GRANTED || Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU
        ) {
            notificationManager.notify(System.currentTimeMillis().toInt(), builder.build())
        }
    }
    
    private fun playNotificationSound() {
        try {
            val notification = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
            val ringtone = RingtoneManager.getRingtone(applicationContext, notification)
            ringtone.play()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
*/

// iOS IMPLEMENTATION (Swift)
// File: ios/Runner/AppDelegate.swift
/*
import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UNUserNotificationCenterDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        
        // Register as notification delegate to handle notifications when app is in foreground
        UNUserNotificationCenter.current().delegate = self
        
        // Set up notifications method channel
        let notificationsChannel = FlutterMethodChannel(
            name: "app.channel.notifications",
            binaryMessenger: controller.binaryMessenger
        )
        
        notificationsChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            if call.method == "requestPermissions" {
                self.requestNotificationPermissions(result: result)
            } else if call.method == "showNotification" {
                guard let args = call.arguments as? [String: Any],
                      let title = args["title"] as? String,
                      let body = args["body"] as? String else {
                    result.error("INVALID_ARGUMENTS", "Missing required arguments", nil)
                    return
                }
                
                let payload = args["payload"] as? String
                self.showNotification(title: title, body: body, payload: payload)
                result.success(nil)
            } else {
                result.notImplemented()
            }
        }
        
        // Set up audio method channel
        let audioChannel = FlutterMethodChannel(
            name: "app.channel.audio",
            binaryMessenger: controller.binaryMessenger
        )
        
        audioChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            if call.method == "playNotificationSound" {
                self.playNotificationSound()
                result.success(nil)
            } else {
                result.notImplemented()
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Request notification permissions
    private func requestNotificationPermissions(result: @escaping FlutterResult) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error)")
                result.success(false)
                return
            }
            
            DispatchQueue.main.async {
                result.success(granted)
            }
        }
    }
    
    // Show a local notification
    private func showNotification(title: String, body: String, payload: String?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        if let payload = payload {
            content.userInfo = ["payload": payload]
        }
        content.sound = UNNotificationSound.default
        
        // Create a trigger (immediate delivery)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        // Create notification request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        // Add to notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error showing notification: \(error)")
            }
        }
    }
    
    // Play notification sound
    private func playNotificationSound() {
        // The sound is already played by the notification itself
        // But if you want to play it separately:
        // AudioServicesPlaySystemSound(1007) // You would need to import AudioToolbox
    }
    
    // Handle notification when app is in foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show the notification even when the app is in foreground
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound])
        } else {
            completionHandler([.alert, .sound])
        }
    }
    
    // Handle notification tap
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        
        // Handle the payload if needed
        if let payload = userInfo["payload"] as? String {
            print("Notification payload: \(payload)")
            // You could send this back to Flutter using a method channel if needed
        }
        
        completionHandler()
    }
}
*/