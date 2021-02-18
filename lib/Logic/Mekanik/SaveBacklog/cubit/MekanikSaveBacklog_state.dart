part of 'MekanikSaveBacklog_cubit.dart';

abstract class MekanikSaveBacklogState extends Equatable {
  const MekanikSaveBacklogState();

  @override
  List<Object> get props => [];
}

class MekanikSaveBacklogInitial extends MekanikSaveBacklogState {}

class MekanikSavedBacklog extends MekanikSaveBacklogState {
  final DateTime tanggal;
  final String namaMekanik;
  final String cnUnit;
  final String trouble;
  final String hmUnit;
  final String damageLevel;
  final List<MekanikAddPartNumber> partNumbers;

  MekanikSavedBacklog(
      {this.tanggal,
      this.namaMekanik,
      this.cnUnit,
      this.trouble,
      this.partNumbers,
      this.damageLevel,
      this.hmUnit});

  @override
  List<Object> get props =>
      [tanggal, namaMekanik, cnUnit, trouble, partNumbers, hmUnit, damageLevel];

  MekanikSavedBacklog copyWith({
    DateTime tanggal,
    String namaMekanik,
    String cnUnit,
    String trouble,
    String hmUnit,
    String damageLevel,
    List<MekanikAddPartNumber> partNumbers,
  }) {
    return MekanikSavedBacklog(
        cnUnit: cnUnit ?? this.cnUnit,
        namaMekanik: namaMekanik ?? this.namaMekanik,
        partNumbers: partNumbers ?? this.partNumbers,
        tanggal: tanggal ?? this.tanggal,
        trouble: trouble ?? this.trouble,
        damageLevel: damageLevel ?? this.damageLevel,
        hmUnit: hmUnit ?? this.hmUnit);
  }
}
