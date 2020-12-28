import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationHelper {
  /// Perform on notification click operataion
  static Future<dynamic> onSelectNotification(String payload) async {
    Fluttertoast.showToast(msg: payload.toString());
  }

  /// Show FCM Notification while app is foreground
  static Future<void> showNotification(
    int notificationId,
    String notificationTitle,
    String notificationContent,
    String payload,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, {
    String channelId = 'Order_Foreground',
    String channelTitle = 'Order Foreground',
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
      channelShowBadge: true,
      enableVibration: true,
      importance: notificationImportance,
      priority: notificationPriority,
    );
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: true);
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
