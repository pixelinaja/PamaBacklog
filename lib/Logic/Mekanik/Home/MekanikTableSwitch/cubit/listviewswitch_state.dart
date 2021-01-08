part of 'listviewswitch_cubit.dart';

abstract class MekanikTableSwitchState extends Equatable {
  const MekanikTableSwitchState();

  @override
  List<Object> get props => [];
}

/// Switch All State
class MekanikTableSwitchAll extends MekanikTableSwitchState {
  final List<TableOrderModel> tableOrder;

  MekanikTableSwitchAll({this.tableOrder});

  @override
  List<Object> get props => [tableOrder];

  MekanikTableSwitchAll copyWith({
    List<TableOrderModel> tableOrder,
  }) {
    return MekanikTableSwitchAll(
      tableOrder: tableOrder ?? this.tableOrder,
    );
  }
}

/// Switch Open only State
class MekanikTableSwitchOpen extends MekanikTableSwitchState {
  final List<TableOrderModel> tableOrder;

  MekanikTableSwitchOpen({this.tableOrder});

  @override
  List<Object> get props => [tableOrder];
}
