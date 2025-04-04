import UIKit
import Flutter
import UserNotifications
import AudioToolbox

@main
@objc class AppDelegate: FlutterAppDelegate {

    var soundID: SystemSoundID = 0
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        
        // Set up notification method channel
        let notificationsChannel = FlutterMethodChannel(
            name: "app.channel.notifications",
            binaryMessenger: controller.binaryMessenger
        )
        
        // Set up audio method channel
        let audioChannel = FlutterMethodChannel(
            name: "app.channel.audio",
            binaryMessenger: controller.binaryMessenger
        )
        
        // Set up wakelock method channel
        let wakelockChannel = FlutterMethodChannel(
            name: "app.channel.wakelock",
            binaryMessenger: controller.binaryMessenger
        )
        
        // Handle notification method calls
        notificationsChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            switch call.method {
            case "requestPermissions":
                self.requestNotificationPermission(result: result)
            case "showNotification":
                if let args = call.arguments as? [String: Any],
                   let title = args["title"] as? String,
                   let body = args["body"] as? String {
                    let payload = args["payload"] as? String ?? ""
                    self.showNotification(title: title, body: body, payload: payload, result: result)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        // Handle audio method calls
        audioChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            switch call.method {
            case "playNotificationSound":
                self.playNotificationSound(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        // Handle wakelock method calls
        wakelockChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            switch call.method {
            case "enableWakeLock":
                UIApplication.shared.isIdleTimerDisabled = true
                result(true)
            case "disableWakeLock":
                UIApplication.shared.isIdleTimerDisabled = false
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        // Set delegate for notification center
        UNUserNotificationCenter.current().delegate = self
        
        // Enable screen to stay on by default
        UIApplication.shared.isIdleTimerDisabled = true
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Request notification permission
    private func requestNotificationPermission(result: @escaping FlutterResult) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error requesting notification permission: \(error.localizedDescription)")
                    result(false)
                } else {
                    print("Notification permission granted: \(granted)")
                    result(granted)
                }
            }
        }
    }
    
    // Show local notification
    private func showNotification(title: String, body: String, payload: String, result: @escaping FlutterResult) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        // Create an immediate trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        // Create a unique identifier
        let identifier = "SevenMinutes_\(Date().timeIntervalSince1970)"
        
        // Create request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Add request to notification center
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error showing notification: \(error.localizedDescription)")
                    result(FlutterError(code: "NOTIFICATION_ERROR", message: error.localizedDescription, details: nil))
                } else {
                    print("Notification scheduled with ID: \(identifier)")
                    result("Notification sent")
                }
            }
        }
    }
    
    // Play notification sound
    private func playNotificationSound(result: @escaping FlutterResult) {
        // Play a system sound
        if let soundURL = Bundle.main.url(forResource: "notification_sound", withExtension: "aiff") {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
            AudioServicesPlaySystemSound(soundID)
            result("Sound played")
        } else {
            // Fallback to default system sound
            AudioServicesPlaySystemSound(1007) // Default iOS notification sound
            result("Default sound played")
        }
    }
    
    // Show notifications even when app is in foreground
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show notification even when app is in foreground
        completionHandler([.alert, .sound, .badge])
    }
}