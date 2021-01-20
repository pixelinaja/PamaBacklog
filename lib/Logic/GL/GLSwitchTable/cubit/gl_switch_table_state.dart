part of 'gl_switch_table_cubit.dart';

abstract class GLSwitchTableState extends Equatable {
  const GLSwitchTableState();

  @override
  List<Object> get props => [];
}

class GLSwitchTableInitial extends GLSwitchTableState {}

class GLSwitchTableAll extends GLSwitchTableState {}

class GLSwitchTableOpen extends GLSwitchTableState {}
