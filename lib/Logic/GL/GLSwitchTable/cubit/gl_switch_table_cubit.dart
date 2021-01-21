import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gl_switch_table_state.dart';

class GLSwitchTableCubit extends Cubit<GLSwitchTableState> {
  GLSwitchTableCubit() : super(GLSwitchTableInitial());

  void switchToAll() => emit(GLSwitchTableAll());

  void switchToOpen() => emit(GLSwitchTableOpen());
}
