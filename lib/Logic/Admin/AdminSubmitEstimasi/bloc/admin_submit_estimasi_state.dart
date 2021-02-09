part of 'admin_submit_estimasi_bloc.dart';

abstract class AdminSubmitEstimasiState extends Equatable {
  const AdminSubmitEstimasiState();

  @override
  List<Object> get props => [];
}

class AdminSubmitEstimasiInitial extends AdminSubmitEstimasiState {}

class AdminSubmitEstimasiLoading extends AdminSubmitEstimasiState {}

class AdminSubmitEstimasiSuccess extends AdminSubmitEstimasiState {
  final String msg;

  AdminSubmitEstimasiSuccess({this.msg});

  @override
  List<Object> get props => [msg];
}

class AdminSubmitEstimasiFailed extends AdminSubmitEstimasiState {
  final String error;

  AdminSubmitEstimasiFailed(this.error);

  @override
  List<Object> get props => [error];
}
