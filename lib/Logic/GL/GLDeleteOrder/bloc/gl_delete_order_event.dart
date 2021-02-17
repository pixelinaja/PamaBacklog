part of 'gl_delete_order_bloc.dart';

abstract class GlDeleteOrderEvent extends Equatable {
  const GlDeleteOrderEvent();

  @override
  List<Object> get props => [];
}

class GlDeleteOrderStart extends GlDeleteOrderEvent {
  final Order order;

  GlDeleteOrderStart({this.order});

  @override
  List<Object> get props => [order];
}
