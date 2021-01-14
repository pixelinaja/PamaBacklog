import 'package:PamaBacklog/Model/MekanikAddPartNumber.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'MekanikSaveBacklog_state.dart';

class MekanikSaveBacklogCubit extends Cubit<MekanikSaveBacklogState> {
  MekanikSaveBacklogCubit() : super(MekanikSaveBacklogInitial());

  void savePart1(
          {DateTime tanggal,
          String namaMekanik,
          String cnUnit,
          String trouble}) =>
      emit(
        MekanikSavedBacklog(
                cnUnit: cnUnit,
                namaMekanik: namaMekanik,
                tanggal: tanggal,
                trouble: trouble)
            .copyWith(
                cnUnit: cnUnit,
                namaMekanik: namaMekanik,
                tanggal: tanggal,
                trouble: trouble),
      );
}
