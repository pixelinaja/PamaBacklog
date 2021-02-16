part of 'gl_approve_order_bloc.dart';

abstract class GLApproveOrderEvent extends Equatable {
  const GLApproveOrderEvent();

  @override
  List<Object> get props => [];
}

class GLApproveOrderApproved extends GLApproveOrderEvent {
  final Order order;
  final DateTime tanggalEksekusi;

  GLApproveOrderApproved({this.order, this.tanggalEksekusi});
}

class GLApproveOrderNotApproved extends GLApproveOrderEvent {
  final Order order;
  final DateTime tanggalEksekusi;
  final String rejectNote;

  GLApproveOrderNotApproved(
      {this.order, this.tanggalEksekusi, this.rejectNote});
}
