part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

/// Initial Order Fetch state
class OrdersInitial extends OrdersState {}

/// Order is Fetching
class OrdersLoading extends OrdersState {}

/// Order is completely fetched
class OrdersFetched extends OrdersState {
  final List<Order> orders;
  final List<Order> orderPerluPersetujuan;

  OrdersFetched({this.orders, this.orderPerluPersetujuan});

  @override
  List<Object> get props => [orders, orderPerluPersetujuan];
}

/// Order fetch is failed
class OrdersFailed extends OrdersState {
  final String message;

  OrdersFailed({this.message});

  @override
  List<Object> get props => [message];
}
