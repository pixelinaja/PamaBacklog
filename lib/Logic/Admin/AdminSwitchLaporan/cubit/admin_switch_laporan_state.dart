part of 'admin_switch_laporan_cubit.dart';

abstract class AdminSwitchLaporanState extends Equatable {
  const AdminSwitchLaporanState();

  @override
  List<Object> get props => [];
}

class AdminSwitchLaporanInitial extends AdminSwitchLaporanState {}

class AdminSwitchLaporanAll extends AdminSwitchLaporanState {}

class AdminSwitchLaporanOpen extends AdminSwitchLaporanState {}
