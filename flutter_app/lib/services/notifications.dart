import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  LocalNotifications._();
  static final _instance = FlutterLocalNotificationsPlugin();

  static FlutterLocalNotificationsPlugin get instance => _instance;

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(android: androidSettings);
    await _instance.initialize(settings);
  }

  static Future<void> show(int id, String title, String body) async {
    const android = AndroidNotificationDetails('reminders', 'Reminders', importance: Importance.max, priority: Priority.high);
    const platform = NotificationDetails(android: android);
    await _instance.show(id, title, body, platform);
  }
}
