part of 'MekanikUpdateLaporan_bloc.dart';

abstract class MekanikUpdateLaporanState extends Equatable {
  const MekanikUpdateLaporanState();

  @override
  List<Object> get props => [];
}

class MekanikUpdateLaporanInitial extends MekanikUpdateLaporanState {}

class MekanikUpdateLaporanLoading extends MekanikUpdateLaporanState {}

class MekanikUpdateLaporanCompleted extends MekanikUpdateLaporanState {
  final TableOrderModel orderDetail;

  MekanikUpdateLaporanCompleted(this.orderDetail);

  @override
  List<Object> get props => [orderDetail];
}

class MekanikUpdateLaporanFailed extends MekanikUpdateLaporanState {
  final String error;

  MekanikUpdateLaporanFailed(this.error);

  @override
  List<Object> get props => [error];
}
