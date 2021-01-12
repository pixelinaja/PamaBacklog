part of 'mekaniklaporanaction_cubit.dart';

abstract class MekanikLaporanActionState extends Equatable {
  const MekanikLaporanActionState();

  @override
  List<Object> get props => [];
}

class MekanikLaporanActionInitial extends MekanikLaporanActionState {}

class MekanikLaporanActionPartKosongConfirmed
    extends MekanikLaporanActionState {}

class MekanikLaporanActionCloseConfirmed extends MekanikLaporanActionState {}
