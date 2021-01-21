import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gl_select_table_order_state.dart';

class GLSelectTableOrderCubit extends Cubit<GLSelectTableOrderState> {
  GLSelectTableOrderCubit() : super(GLSelectTableOrderInitial());

  void selectTableOrder({TableOrderModel tableOrder}) =>
      emit(GLSelectTableOrderSelected(tableOrder: tableOrder));
}
