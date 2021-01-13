part of 'mekaniktable_bloc.dart';

abstract class MekanikTableState extends Equatable {
  const MekanikTableState();

  @override
  List<Object> get props => [];
}

class MekanikTableInitial extends MekanikTableState {}

/// Fetch is on loading
class MekanikTableLoading extends MekanikTableState {}

/// Fetch is complete
class MekanikTableCompleted extends MekanikTableState {
  final List<Order> orders;
  final List<TableOrderModel> tableOrder;

  MekanikTableCompleted({@required this.orders, @required this.tableOrder});

  @override
  List<Object> get props => [orders, tableOrder];

  MekanikTableCompleted copyWith({
    List<Order> orders,
    List<TableOrderModel> tableOrder,
  }) {
    return MekanikTableCompleted(
      orders: orders ?? this.orders,
      tableOrder: tableOrder ?? this.tableOrder,
    );
  }
}

/// Fetch is failed
class MekanikTableFailed extends MekanikTableState {
  final String message;

  MekanikTableFailed(this.message);

  @override
  List<Object> get props => [message];
}
