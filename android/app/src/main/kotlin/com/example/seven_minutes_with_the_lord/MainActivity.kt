package com.example.seven_minutes_with_the_lord

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.RingtoneManager
import android.os.Build
import android.os.PowerManager
import android.view.WindowManager
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
    private val WAKELOCK_CHANNEL = "app.channel.wakelock"
    
    private val CHANNEL_ID = "seven_minutes_prayer_channel"
    private val CHANNEL_NAME = "Prayer Notifications"
    private val CHANNEL_DESCRIPTION = "Prayer activity notifications"
    
    private var wakeLock: PowerManager.WakeLock? = null

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
                        if (Build.VERSION.SDK_INT >= 33) {
                            try {
                                ActivityCompat.requestPermissions(
                                    this,
                                    arrayOf(android.Manifest.permission.POST_NOTIFICATIONS),
                                    0
                                )
                                println("Requested POST_NOTIFICATIONS permission")
                                result.success(true)
                            } catch (e: Exception) {
                                println("Error requesting permissions: ${e.message}")
                                result.success(false)
                            }
                        } else {
                            // Prior to Android 13, permission was granted at install time
                            println("Android version < 13, no runtime permission needed")
                            result.success(true)
                        }
                    }
                    "showNotification" -> {
                        try {
                            val title = call.argument<String>("title") ?: ""
                            val body = call.argument<String>("body") ?: ""
                            val payload = call.argument<String>("payload") ?: ""
                            
                            println("Showing notification: $title - $body")
                            showNotification(title, body, payload)
                            result.success("Notification sent")
                        } catch (e: Exception) {
                            println("Error showing notification: ${e.message}")
                            result.error("NOTIFICATION_ERROR", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
        
        // Set up audio method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, AUDIO_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "playNotificationSound" -> {
                        try {
                            playNotificationSound()
                            result.success("Sound played")
                        } catch (e: Exception) {
                            println("Error playing sound: ${e.message}")
                            result.error("SOUND_ERROR", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
            
        // Set up wake lock method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WAKELOCK_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "enableWakeLock" -> {
                        try {
                            val enabled = enableWakeLock()
                            result.success(enabled)
                        } catch (e: Exception) {
                            println("Error enabling wake lock: ${e.message}")
                            result.error("WAKELOCK_ERROR", e.message, null)
                        }
                    }
                    "disableWakeLock" -> {
                        try {
                            val disabled = disableWakeLock()
                            result.success(disabled)
                        } catch (e: Exception) {
                            println("Error disabling wake lock: ${e.message}")
                            result.error("WAKELOCK_ERROR", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
            
        // Enable wake lock by default
        enableWakeLock()
    }
    
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(CHANNEL_ID, CHANNEL_NAME, importance).apply {
                description = CHANNEL_DESCRIPTION
                enableLights(true)
                enableVibration(true)
            }
            
            println("Creating notification channel: $CHANNEL_ID")
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
    
    private fun showNotification(title: String, body: String, payload: String) {
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
        
        // Create notification with the app icon
        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.launch_background) // Using launch_background as fallback
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION))
        
        // Show notification
        val notificationManager = NotificationManagerCompat.from(this)
        
        // Check for permission on Android 13+
        if (ActivityCompat.checkSelfPermission(
                this,
                android.Manifest.permission.POST_NOTIFICATIONS
            ) == PackageManager.PERMISSION_GRANTED || Build.VERSION.SDK_INT < 33
        ) {
            println("Showing notification with ID: ${System.currentTimeMillis().toInt()}")
            notificationManager.notify(System.currentTimeMillis().toInt(), builder.build())
        } else {
            println("Notification permission not granted")
        }
    }
    
    private fun playNotificationSound() {
        try {
            val notification = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
            val ringtone = RingtoneManager.getRingtone(applicationContext, notification)
            ringtone.play()
            println("Playing notification sound")
        } catch (e: Exception) {
            println("Error playing notification sound: ${e.message}")
            e.printStackTrace()
        }
    }
    
    private fun enableWakeLock(): Boolean {
        try {
            println("Enabling wake lock")
            
            // Method 1: Using FLAG_KEEP_SCREEN_ON
            runOnUiThread {
                window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
            }
            
            // Method 2: Using PowerManager WakeLock (as a backup)
            if (wakeLock == null) {
                val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
                wakeLock = powerManager.newWakeLock(
                    PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
                    "SevenMinutes:WakeLock"
                )
            }
            
            wakeLock?.let {
                if (!it.isHeld) {
                    it.acquire()
                    println("PowerManager wake lock acquired")
                }
            }
            
            return true
        } catch (e: Exception) {
            println("Error enabling wake lock: ${e.message}")
            e.printStackTrace()
            return false
        }
    }
    
    private fun disableWakeLock(): Boolean {
        try {
            println("Disabling wake lock")
            
            // Method 1: Clear FLAG_KEEP_SCREEN_ON
            runOnUiThread {
                window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
            }
            
            // Method 2: Release PowerManager WakeLock
            wakeLock?.let {
                if (it.isHeld) {
                    it.release()
                    println("PowerManager wake lock released")
                }
            }
            
            return true
        } catch (e: Exception) {
            println("Error disabling wake lock: ${e.message}")
            e.printStackTrace()
            return false
        }
    }
    
    override fun onResume() {
        super.onResume()
        // Re-enable wake lock when activity is resumed
        enableWakeLock()
    }
    
    override fun onPause() {
        super.onPause()
        // Keep screen on even when app is paused
        // (don't disable the wake lock here)
    }
    
    override fun onDestroy() {
        // Clean up wake lock when activity is destroyed
        disableWakeLock()
        super.onDestroy()
    }
}