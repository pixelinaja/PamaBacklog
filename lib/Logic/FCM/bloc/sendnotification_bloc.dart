import 'dart:async';

import 'package:PamaBacklog/Model/NotificationMsgModel.dart';
import 'package:PamaBacklog/Service/FCMRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'sendnotification_event.dart';
part 'sendnotification_state.dart';

class SendNotificationBloc
    extends Bloc<SendNotificationEvent, SendNotificationState> {
  final FCMRepository fcmRepository;
  SendNotificationBloc({@required this.fcmRepository})
      : super(SendNotificationInitial());

  @override
  Stream<SendNotificationState> mapEventToState(
    SendNotificationEvent event,
  ) async* {
    if (event is SendNotification) {
      yield SendNotificationLoading();
      try {
        await fcmRepository.sendPushNotification(
          msg: event.notificationMsg,
          topic: event.notificationTopic,
        );
        yield SendNotificationSuccess();
      } catch (e) {
        yield SendNotificationFailed(e.toString());
      }
    }
  }
}
