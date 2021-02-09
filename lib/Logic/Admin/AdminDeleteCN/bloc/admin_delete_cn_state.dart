part of 'admin_delete_cn_bloc.dart';

abstract class AdminDeleteCnState extends Equatable {
  const AdminDeleteCnState();

  @override
  List<Object> get props => [];
}

class AdminDeleteCnInitial extends AdminDeleteCnState {}

class AdminDeleteCnLoading extends AdminDeleteCnState {}

class AdminDeleteCnCompleted extends AdminDeleteCnState {
  final String msg;

  AdminDeleteCnCompleted({this.msg});

  @override
  List<Object> get props => [msg];
}

class AdminDeleteCnFailed extends AdminDeleteCnState {
  final String error;

  AdminDeleteCnFailed({this.error});

  @override
  List<Object> get props => [error];
}
