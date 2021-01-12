import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mekaniktableswitch_state.dart';

class MekanikTableSwitchCubit extends Cubit<MekanikTableSwitchState> {
  MekanikTableSwitchCubit() : super(MekanikTableSwitchInitial());

  /// Switch to All Cubit Function
  void switchToAll({List<TableOrderModel> tableOrder}) {
    return emit(MekanikTableSwitchAll(tableOrder: tableOrder));
  }

  /// Switch to Open Cubit Function
  void switchToOpen({List<TableOrderModel> tableOrder}) {
    List<TableOrderModel> filteredTableOrder = [];
    filteredTableOrder.addAll(tableOrder);
    filteredTableOrder.removeWhere((element) =>
        element.statusAction == "CLOSE" ||
        element.statusAction == "PART KOSONG");
    emit(MekanikTableSwitchOpen(tableOrder: filteredTableOrder));
  }
}
