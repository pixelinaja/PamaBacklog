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
  final List<Order> adminLaporan;
  final List<TableOrderModel> tableOrder;
  final List<TableOrderModel> tableOrderPerluPersetujuan;
  final List<TableOrderModel> tableOrderAdminLaporan;
  final List<TableOrderModel> tableOrderAdminTerbuka;

  OrdersFetched({
    this.orders,
    this.orderPerluPersetujuan,
    this.adminLaporan,
    this.tableOrder,
    this.tableOrderPerluPersetujuan,
    this.tableOrderAdminLaporan,
    this.tableOrderAdminTerbuka,
  });

  @override
  List<Object> get props => [
        orders,
        orderPerluPersetujuan,
        adminLaporan,
        tableOrder,
        tableOrderAdminTerbuka
      ];

  OrdersFetched copyWith({
    List<Order> orders,
    List<Order> orderPerluPersetujuan,
    List<Order> adminLaporan,
    List<TableOrderModel> tableOrder,
    List<TableOrderModel> tableOrderPerluPersetujuan,
    List<TableOrderModel> tableOrderAdminLaporan,
    List<TableOrderModel> tableOrderAdminTerbuka,
  }) {
    return OrdersFetched(
      orders: orders ?? this.orders,
      orderPerluPersetujuan:
          orderPerluPersetujuan ?? this.orderPerluPersetujuan,
      adminLaporan: adminLaporan ?? this.adminLaporan,
      tableOrder: tableOrder ?? this.tableOrder,
      tableOrderAdminLaporan:
          tableOrderPerluPersetujuan ?? this.tableOrderPerluPersetujuan,
      tableOrderPerluPersetujuan:
          tableOrderAdminLaporan ?? this.tableOrderAdminLaporan,
      tableOrderAdminTerbuka:
          tableOrderAdminTerbuka ?? this.tableOrderAdminTerbuka,
    );
  }
}

/// Order fetch is failed
class OrdersFailed extends OrdersState {
  final String message;

  OrdersFailed({this.message});

  @override
  List<Object> get props => [message];
}
