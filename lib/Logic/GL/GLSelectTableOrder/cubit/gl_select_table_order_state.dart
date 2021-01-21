part of 'gl_select_table_order_cubit.dart';

abstract class GLSelectTableOrderState extends Equatable {
  const GLSelectTableOrderState();

  @override
  List<Object> get props => [];
}

class GLSelectTableOrderInitial extends GLSelectTableOrderState {}

class GLSelectTableOrderSelected extends GLSelectTableOrderState {
  final TableOrderModel tableOrder;

  const GLSelectTableOrderSelected({this.tableOrder});

  @override
  List<Object> get props => [tableOrder];
}
