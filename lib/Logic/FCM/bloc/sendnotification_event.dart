part of 'sendnotification_bloc.dart';

abstract class SendNotificationEvent extends Equatable {
  const SendNotificationEvent();

  @override
  List<Object> get props => [];
}

/// Send FCM Notification to the topic Subscriber
///
/// Example:
///
/// SendNotification(notificationTopic: FCMConstant.TOPIC_ORDER_CREATED, notificationMsg: NotificationMsgModel( body: "Order xxx-xxx telah dibuat oleh xxxx", orderId: "1xlslkdiwokdf", orderStatus: "open", title: "Order baru"),)
class SendNotification extends SendNotificationEvent {
  final String notificationTopic;
  final NotificationMsgModel notificationMsg;

  SendNotification({
    @required this.notificationTopic,
    @required this.notificationMsg,
  });

  @override
  List<Object> get props => [notificationTopic, notificationMsg];
}
