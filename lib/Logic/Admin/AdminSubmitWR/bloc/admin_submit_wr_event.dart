part of 'admin_submit_wr_bloc.dart';

abstract class AdminSubmitWrEvent extends Equatable {
  const AdminSubmitWrEvent();

  @override
  List<Object> get props => [];
}

class AdminSubmitWrStart extends AdminSubmitWrEvent {
  final Order order;
  final TableOrderModel tableOrder;
  final String wrNumber;

  AdminSubmitWrStart({this.order, this.tableOrder, this.wrNumber});

  List<Object> get props => [order, tableOrder, wrNumber];

  AdminSubmitWrStart copyWith({
    Order order,
    TableOrderModel tableOrder,
    String wrNumber,
  }) {
    return AdminSubmitWrStart(
      order: order ?? this.order,
      tableOrder: tableOrder ?? this.tableOrder,
      wrNumber: wrNumber ?? this.wrNumber,
    );
  }
}
