part of 'admin_submit_wr_bloc.dart';

abstract class AdminSubmitWrState extends Equatable {
  const AdminSubmitWrState();

  @override
  List<Object> get props => [];
}

class AdminSubmitWrInitial extends AdminSubmitWrState {}

class AdminSubmitWrLoading extends AdminSubmitWrState {}

class AdminSubmitWrSuccess extends AdminSubmitWrState {
  final String msg;

  AdminSubmitWrSuccess({this.msg});

  @override
  List<Object> get props => [msg];
}

class AdminSubmitWrFailed extends AdminSubmitWrState {
  final String error;

  AdminSubmitWrFailed({this.error});

  @override
  List<Object> get props => [error];
}
