part of 'admin_edit_cn_bloc.dart';

abstract class AdminEditCnState extends Equatable {
  const AdminEditCnState();

  @override
  List<Object> get props => [];
}

class AdminEditCnInitial extends AdminEditCnState {}

class AdminEditCnLoading extends AdminEditCnState {}

class AdminEditCnCompleted extends AdminEditCnState {
  final String msg;

  AdminEditCnCompleted({this.msg});

  @override
  List<Object> get props => [msg];
}

class AdminEditCnFailed extends AdminEditCnState {
  final String error;

  AdminEditCnFailed({this.error});

  @override
  List<Object> get props => [error];
}
