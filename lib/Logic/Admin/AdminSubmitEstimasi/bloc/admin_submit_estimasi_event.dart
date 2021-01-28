part of 'admin_submit_estimasi_bloc.dart';

abstract class AdminSubmitEstimasiEvent extends Equatable {
  const AdminSubmitEstimasiEvent();

  @override
  List<Object> get props => [];
}

class AdminSubmitEstimasiStart extends AdminSubmitEstimasiEvent {
  final Order order;
  final TableOrderModel tableOrder;
  final DateTime tanggalEstimasi;

  AdminSubmitEstimasiStart({this.order, this.tableOrder, this.tanggalEstimasi});

  List<Object> get props => [order, tableOrder, tanggalEstimasi];

  AdminSubmitEstimasiStart copyWith({
    Order order,
    TableOrderModel tableOrder,
    DateTime tanggalEstimasi,
  }) {
    return AdminSubmitEstimasiStart(
      order: order ?? this.order,
      tableOrder: tableOrder ?? this.tableOrder,
      tanggalEstimasi: tanggalEstimasi ?? this.tanggalEstimasi,
    );
  }
}
