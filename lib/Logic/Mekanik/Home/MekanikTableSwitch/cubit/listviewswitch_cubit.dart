import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listviewswitch_state.dart';

class MekanikTableSwitchCubit extends Cubit<MekanikTableSwitchState> {
  MekanikTableSwitchCubit() : super(MekanikTableSwitchAll());

  /// Switch to All Cubit Function
  void switchToAll() => emit(MekanikTableSwitchAll());

  /// Switch to Open Cubit Function
  void switchToOpen() => emit(MekanikTableSwitchOpen());
}
