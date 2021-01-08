import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listviewswitch_state.dart';

class MekanikTableSwitchCubit extends Cubit<MekanikTableSwitchState> {
  MekanikTableSwitchCubit() : super(MekanikTableSwitchAll());

  /// Switch to All Cubit Function
  void switchToAll({List<TableOrderModel> tableOrder}) {
    return emit(MekanikTableSwitchAll(tableOrder: tableOrder));
  }

  /// Switch to Open Cubit Function
  void switchToOpen({List<TableOrderModel> tableOrder}) {
    List<TableOrderModel> filteredTableOrder = [];
    filteredTableOrder.addAll(tableOrder);
    filteredTableOrder
        .removeWhere((element) => element.statusAction == "CLOSE");
    emit(MekanikTableSwitchOpen(tableOrder: filteredTableOrder));
  }
}
