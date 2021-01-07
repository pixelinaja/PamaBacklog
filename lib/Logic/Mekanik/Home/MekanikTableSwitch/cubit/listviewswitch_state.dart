part of 'listviewswitch_cubit.dart';

abstract class MekanikTableSwitchState extends Equatable {
  const MekanikTableSwitchState();

  @override
  List<Object> get props => [];
}

/// Switch All State
class MekanikTableSwitchAll extends MekanikTableSwitchState {}

/// Switch Open only State
class MekanikTableSwitchOpen extends MekanikTableSwitchState {}
