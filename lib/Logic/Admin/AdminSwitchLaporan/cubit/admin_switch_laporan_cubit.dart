import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_switch_laporan_state.dart';

class AdminSwitchLaporanCubit extends Cubit<AdminSwitchLaporanState> {
  AdminSwitchLaporanCubit() : super(AdminSwitchLaporanInitial());

  void adminSwitchAll() => emit(AdminSwitchLaporanAll());

  void adminSwitchOpen() => emit(AdminSwitchLaporanOpen());
}
