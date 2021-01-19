part of 'mekanikadd_bloc.dart';

abstract class MekanikAddEvent extends Equatable {
  const MekanikAddEvent();

  @override
  List<Object> get props => [];
}

class MekanikAddStart extends MekanikAddEvent {
  final DateTime tanggalLaporan;
  final String namaMekanik;
  final String cnUnit;
  final String trouble;
  final List<MekanikAddPartNumber> partNumbers;
  final bool byPass;

  MekanikAddStart({
    this.tanggalLaporan,
    this.namaMekanik,
    this.cnUnit,
    this.trouble,
    this.partNumbers,
    this.byPass,
  });
}
