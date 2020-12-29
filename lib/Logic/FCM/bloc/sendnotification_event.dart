part of 'sendnotification_bloc.dart';

abstract class SendNotificationEvent extends Equatable {
  const SendNotificationEvent();

  @override
  List<Object> get props => [];
}

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
