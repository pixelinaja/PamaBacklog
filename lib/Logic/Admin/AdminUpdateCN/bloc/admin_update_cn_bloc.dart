import 'dart:async';

import 'package:PamaBacklog/Model/CNModel.dart';
import 'package:PamaBacklog/Service/CNRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'admin_update_cn_event.dart';
part 'admin_update_cn_state.dart';

class AdminUpdateCnBloc extends Bloc<AdminUpdateCnEvent, AdminUpdateCnState> {
  final CNRepository cnRepository = CNService();
  AdminUpdateCnBloc() : super(AdminUpdateCnInitial());

  @override
  Stream<AdminUpdateCnState> mapEventToState(
    AdminUpdateCnEvent event,
  ) async* {
    if (event is AdminUpdateCNStart) {
      yield AdminUpdateCnLoading();
      var cnData = event.cnData.firstWhere((element) =>
          element.cnName.toLowerCase() == event.cnSection.toLowerCase());

      final oldCn = event.cnData.firstWhere((element) =>
          element.cnName.toLowerCase() == event.cnSection.toLowerCase());

      if (cnData != null) {
        if (cnData.cnNumbers.contains(event.cnNumber)) {
          yield AdminUpdateCnFailed(
              error:
                  "Data C/N Baru Telah Tersedia. Silahkan Masukkan data lain.");
        } else {
          cnData.cnNumbers.add(event.cnNumber);
          cnData.cnNumbers.sort(((a, b) {
            return a.toLowerCase().compareTo(b.toLowerCase());
          }));

          try {
            await cnRepository.updateCN(
              cnId: cnData.cnName.toLowerCase(),
              cnData: cnData,
              oldCNData: oldCn,
            );
            yield AdminUpdateCnCompleted(
                msg: "Data C/N Baru Telah Ditambahkan");
          } catch (e) {
            yield AdminUpdateCnFailed(error: e.toString());
          }
        }
      } else {
        cnData = CNModel(
          cnName: event.cnSection,
          cnNumbers: [event.cnNumber],
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
        );

        try {
          await cnRepository.updateCN(
            cnId: cnData.cnName.toLowerCase(),
            cnData: cnData,
            oldCNData: oldCn,
          );
          yield AdminUpdateCnCompleted(msg: "Data C/N Baru Telah Ditambahkan");
        } catch (e) {
          yield AdminUpdateCnFailed(error: e.toString());
        }
      }
    }
  }
}
