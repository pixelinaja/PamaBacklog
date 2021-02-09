part of 'cn_bloc.dart';

abstract class CNState extends Equatable {
  const CNState();

  @override
  List<Object> get props => [];
}

class CNInitial extends CNState {}

class CNLoading extends CNState {}

class CNCompleted extends CNState {
  final List<CNModel> cnData;
  final List<CNListModel> cnList;

  CNCompleted({@required this.cnData, @required this.cnList});

  @override
  List<Object> get props => [cnData, cnList];
}

class CNFailed extends CNState {
  final String error;

  CNFailed({@required this.error});

  @override
  List<Object> get props => [error];
}
