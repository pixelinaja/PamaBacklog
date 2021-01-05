import 'package:PamaBacklog/Global/FirestoreConstant/FCMConstant.dart';
import 'package:PamaBacklog/Model/NotificationMsgModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class FCMRepository {
  /// FCM Send Push Notification with Certain Topic and Message
  Future<void> sendPushNotification({
    @required String topic,
    @required NotificationMsgModel msg,
  });
}

class FCMService implements FCMRepository {
  /// Create Header
  static final fcmHeader = {
    'content-type': 'application/json',
    'Authorization': 'key=${FCMConstant.SERVER_KEY}'
  };

  static BaseOptions options = BaseOptions(
    headers: fcmHeader,
  );

  final Dio dio = Dio(options);

  /// Send Push Notification
  @override
  Future<void> sendPushNotification(
      {String topic, NotificationMsgModel msg}) async {
    /// Notification Data to Send
    final data = {
      "notification": {
        "title": msg.title,
        "body": msg.body,
        "android_channel_id": "fcm_default_channel",
        "tag": "order",
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "order_id": msg.orderId,
        "status": msg.orderStatus,
      },
      "to": "/topics/$topic"
    };

    /// Send Push Notification via Dio
    Response response = await dio.post(
      FCMConstant.FCM_BASE_URL,
      data: data,
    );
    return response;
  }
}
