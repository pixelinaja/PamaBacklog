part of 'mekaniktable_bloc.dart';

abstract class MekanikTableEvent extends Equatable {
  const MekanikTableEvent();

  @override
  List<Object> get props => [];
}

/// Fetch Order Data
class MekanikTableFetchData extends MekanikTableEvent {}
