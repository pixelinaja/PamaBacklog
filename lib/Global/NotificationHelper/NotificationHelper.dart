import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  /// Show FCM Notification while app is foreground
  static Future<void> showNotification(
    int notificationId,
    String notificationTitle,
    String notificationContent,
    String payload,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, {
    String channelId = 'fcm_default_channel',
    String channelTitle = 'Order',
    String channelDescription =
        'Notification Channel for Foreground Notification',
    Priority notificationPriority = Priority.high,
    Importance notificationImportance = Importance.max,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: true,
      groupKey: "Order",
      channelShowBadge: true,
      enableVibration: true,
      enableLights: true,
      icon: '@mipmap/ic_launcher',
      // TODO: Change this notification icon's color
      color: Colors.blue,
      importance: notificationImportance,
      priority: notificationPriority,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentSound: true, presentAlert: true, presentBadge: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
