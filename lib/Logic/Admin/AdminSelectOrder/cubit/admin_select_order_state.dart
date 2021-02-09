part of 'admin_select_order_cubit.dart';

abstract class AdminSelectOrderState extends Equatable {
  const AdminSelectOrderState();

  @override
  List<Object> get props => [];
}

class AdminSelectOrderInitial extends AdminSelectOrderState {}

class AdminSelectOrderSelected extends AdminSelectOrderState {
  final Order order;
  final TableOrderModel tableOrder;

  AdminSelectOrderSelected({this.order, this.tableOrder});

  @override
  List<Object> get props => [order, tableOrder];
}
