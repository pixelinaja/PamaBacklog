part of 'sendnotification_bloc.dart';

abstract class SendNotificationState extends Equatable {
  const SendNotificationState();

  @override
  List<Object> get props => [];
}

class SendNotificationInitial extends SendNotificationState {}

class SendNotificationLoading extends SendNotificationState {}

class SendNotificationSuccess extends SendNotificationState {}

class SendNotificationFailed extends SendNotificationState {
  final String error;

  SendNotificationFailed(this.error);

  @override
  List<Object> get props => [error];
}
