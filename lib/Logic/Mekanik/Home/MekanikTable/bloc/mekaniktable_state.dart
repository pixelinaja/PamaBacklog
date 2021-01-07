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

  MekanikTableCompleted({@required this.orders});

  @override
  List<Object> get props => [orders];
}

/// Fetch is failed
class MekanikTableFailed extends MekanikTableState {
  final String message;

  MekanikTableFailed(this.message);

  @override
  List<Object> get props => [message];
}
