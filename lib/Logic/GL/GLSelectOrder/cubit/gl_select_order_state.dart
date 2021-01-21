part of 'gl_select_order_cubit.dart';

abstract class GLSelectOrderState extends Equatable {
  const GLSelectOrderState();

  @override
  List<Object> get props => [];
}

class GLSelectOrderInitial extends GLSelectOrderState {}

class GLSelectOrderSelected extends GLSelectOrderState {
  final Order order;

  GLSelectOrderSelected({this.order});

  @override
  List<Object> get props => [order];
}
