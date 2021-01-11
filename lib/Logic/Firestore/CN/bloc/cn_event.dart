part of 'cn_bloc.dart';

abstract class CNEvent extends Equatable {
  const CNEvent();

  @override
  List<Object> get props => [];
}

class CNFetch extends CNEvent {}
