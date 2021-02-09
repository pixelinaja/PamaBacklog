import 'dart:async';

import 'package:PamaBacklog/Model/CNModel.dart';
import 'package:PamaBacklog/Service/CNRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'admin_edit_cn_event.dart';
part 'admin_edit_cn_state.dart';

class AdminEditCnBloc extends Bloc<AdminEditCnEvent, AdminEditCnState> {
  final CNRepository cnRepository = CNService();
  AdminEditCnBloc() : super(AdminEditCnInitial());

  @override
  Stream<AdminEditCnState> mapEventToState(
    AdminEditCnEvent event,
  ) async* {
    if (event is AdminEditCnStart) {
      yield AdminEditCnLoading();

      var cnData = event.cnData;
      cnData.updatedAt = Timestamp.now();

      if (cnData.cnNumbers.contains(event.cnNumber)) {
        yield AdminEditCnFailed(
            error:
                "C/N Unit dengan kode ${event.cnNumber} sudah ada, mohon koreksi kembali.");
      } else if (cnData.cnNumbers.contains(event.oldCnNumber)) {
        /// Remove Old CN Number
        cnData.cnNumbers.removeWhere((element) => element == event.oldCnNumber);

        /// Add a new CN Number
        cnData.cnNumbers.add(event.cnNumber);

        /// Sort the array
        cnData.cnNumbers.sort(((a, b) {
          return a.toLowerCase().compareTo(b.toLowerCase());
        }));

        try {
          await cnRepository.updateCN(
              cnId: cnData.cnName.toLowerCase(),
              cnData: cnData,
              oldCNData: event.cnData);
          yield AdminEditCnCompleted(msg: "Data C/N Telah Berhasil Diubah");
        } catch (e) {
          yield AdminEditCnFailed(error: e.toString());
        }
      } else {
        yield AdminEditCnFailed(
            error: "Data C/N Tidak Ditemukan, Mohon Koreksi Kembali");
      }
    }
  }
}
