part of 'admin_update_cn_bloc.dart';

abstract class AdminUpdateCnState extends Equatable {
  const AdminUpdateCnState();

  @override
  List<Object> get props => [];
}

class AdminUpdateCnInitial extends AdminUpdateCnState {}

class AdminUpdateCnLoading extends AdminUpdateCnState {}

class AdminUpdateCnCompleted extends AdminUpdateCnState {
  final String msg;

  AdminUpdateCnCompleted({this.msg});

  @override
  List<Object> get props => [msg];
}

class AdminUpdateCnFailed extends AdminUpdateCnState {
  final String error;

  AdminUpdateCnFailed({this.error});

  @override
  List<Object> get props => [error];
}
