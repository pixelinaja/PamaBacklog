import 'dart:async';

import 'package:PamaBacklog/Model/CNModel.dart';
import 'package:PamaBacklog/Service/CNRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'admin_delete_cn_event.dart';
part 'admin_delete_cn_state.dart';

class AdminDeleteCnBloc extends Bloc<AdminDeleteCnEvent, AdminDeleteCnState> {
  final CNRepository cnRepository = CNService();
  AdminDeleteCnBloc() : super(AdminDeleteCnInitial());

  @override
  Stream<AdminDeleteCnState> mapEventToState(
    AdminDeleteCnEvent event,
  ) async* {
    if (event is AdminDeleteCnStart) {
      yield AdminDeleteCnLoading();

      var cnData = event.cnData.firstWhere((element) =>
          element.cnName.toLowerCase() == event.cnName.toLowerCase());
      var oldCnData = event.cnData.firstWhere((element) =>
          element.cnName.toLowerCase() == event.cnName.toLowerCase());
      cnData.cnNumbers.removeWhere(
          (element) => element.toLowerCase() == event.cnNumber.toLowerCase());
      cnData.updatedAt = Timestamp.now();

      try {
        await cnRepository.updateCN(
            cnId: event.cnName.toLowerCase(),
            cnData: cnData,
            oldCNData: oldCnData);
        yield AdminDeleteCnCompleted(msg: "Data C/N Telah Berhasil Dihapus.");
      } catch (e) {
        yield AdminDeleteCnFailed(error: e.toString());
      }
    }
  }
}
