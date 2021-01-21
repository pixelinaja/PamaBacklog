part of 'gl_approve_order_bloc.dart';

abstract class GLApproveOrderState extends Equatable {
  const GLApproveOrderState();

  @override
  List<Object> get props => [];
}

class GLApproveOrderInitial extends GLApproveOrderState {}

class GLApproveOrderSuccess extends GLApproveOrderState {
  final int approvalPengawas;
  final String tanggal;
  final String cnNumber;

  GLApproveOrderSuccess({this.approvalPengawas, this.tanggal, this.cnNumber});

  @override
  List<Object> get props => [approvalPengawas, tanggal, cnNumber];
}

class GLApproveOrderFailed extends GLApproveOrderState {
  final String error;

  GLApproveOrderFailed({this.error});

  @override
  List<Object> get props => [error];
}

class GLApproveOrderLoading extends GLApproveOrderState {}
