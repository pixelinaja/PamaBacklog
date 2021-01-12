import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mekaniklaporanaction_state.dart';

class MekanikLaporanActionCubit extends Cubit<MekanikLaporanActionState> {
  MekanikLaporanActionCubit() : super(MekanikLaporanActionInitial());

  void partKosongConfirmed({String docId, String partNumber}) {
    return emit(MekanikLaporanActionPartKosongConfirmed());
  }

  void closeConfirmed({String docId, String partNumber}) {
    return emit(MekanikLaporanActionCloseConfirmed());
  }
}
