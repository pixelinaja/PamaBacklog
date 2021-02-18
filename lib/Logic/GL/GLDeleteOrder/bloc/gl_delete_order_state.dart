part of 'gl_delete_order_bloc.dart';

abstract class GlDeleteOrderState extends Equatable {
  const GlDeleteOrderState();

  @override
  List<Object> get props => [];
}

class GlDeleteOrderInitial extends GlDeleteOrderState {}

class GlDeleteOrderLoading extends GlDeleteOrderState {}

class GlDeleteOrderSuccess extends GlDeleteOrderState {
  final String msg;

  GlDeleteOrderSuccess({this.msg});

  @override
  List<Object> get props => [msg];
}

class GlDeleteOrderFailed extends GlDeleteOrderState {
  final String error;

  GlDeleteOrderFailed({this.error});

  @override
  List<Object> get props => [error];
}
