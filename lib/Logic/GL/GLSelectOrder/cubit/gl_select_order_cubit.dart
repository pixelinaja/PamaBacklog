import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gl_select_order_state.dart';

class GLSelectOrderCubit extends Cubit<GLSelectOrderState> {
  GLSelectOrderCubit() : super(GLSelectOrderInitial());

  void selectOrder({Order order}) => emit(GLSelectOrderSelected(order: order));
}
