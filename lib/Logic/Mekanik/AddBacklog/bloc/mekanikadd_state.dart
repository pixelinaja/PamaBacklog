part of 'mekanikadd_bloc.dart';

abstract class MekanikAddState extends Equatable {
  const MekanikAddState();

  @override
  List<Object> get props => [];
}

class MekanikAddInitial extends MekanikAddState {}

class MekanikAddLoading extends MekanikAddState {}

class MekanikAddCompleted extends MekanikAddState {}

class MekanikAddFailed extends MekanikAddState {
  final String error;

  MekanikAddFailed({@required this.error});
}
