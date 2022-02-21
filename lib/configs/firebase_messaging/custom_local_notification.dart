import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel androidNotificationChannel;

  CustomLocalNotification() {
    androidNotificationChannel = AndroidNotificationChannel(
      'channelId',
      'channelName',
      description: 'channelDescription',
      importance: Importance.max,
    );

    _configuraAndroid().then((value) {
      flutterLocalNotificationsPlugin = value;
      inicializeNotification();
    });
  }
  Future<FlutterLocalNotificationsPlugin> _configuraAndroid() async {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    return flutterLocalNotificationsPlugin;
  }

  void inicializeNotification() {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: android,
      ),
    );
  }

  androidNotification(
      RemoteNotification notification, AndroidNotification android) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: androidNotificationChannel.description,
          icon: android.smallIcon,
        ),
      ),
    );
  }
}
