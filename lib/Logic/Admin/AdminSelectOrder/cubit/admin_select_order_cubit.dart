import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_select_order_state.dart';

class AdminSelectOrderCubit extends Cubit<AdminSelectOrderState> {
  AdminSelectOrderCubit() : super(AdminSelectOrderInitial());

  void selectOrder({Order order, TableOrderModel tableOrder}) =>
      emit(AdminSelectOrderSelected(order: order, tableOrder: tableOrder));
}
