import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings();

  const InitializationSettings settings =
      InitializationSettings(iOS: iosSettings);

  await notificationsPlugin.initialize(settings);
}
