part of 'admin_export_bloc.dart';

abstract class AdminExportState extends Equatable {
  const AdminExportState();

  @override
  List<Object> get props => [];
}

class AdminExportInitial extends AdminExportState {}

class AdminExportLoading extends AdminExportState {}

class AdminExportCompleted extends AdminExportState {
  final String msg;

  AdminExportCompleted({this.msg});

  @override
  List<Object> get props => [msg];
}

class AdminExportFailed extends AdminExportState {
  final String error;

  AdminExportFailed({this.error});

  @override
  List<Object> get props => [error];
}
