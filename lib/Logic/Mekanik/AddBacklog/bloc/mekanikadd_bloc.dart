import 'dart:async';

import 'package:PamaBacklog/Global/AppRelated/AppString.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Model/MekanikAddPartNumber.dart';

part 'mekanikadd_event.dart';
part 'mekanikadd_state.dart';

class MekanikAddBloc extends Bloc<MekanikAddEvent, MekanikAddState> {
  final MekanikTableBloc mekanikTableBloc;
  MekanikAddBloc({
    this.mekanikTableBloc,
  }) : super(MekanikAddInitial());

  @override
  Stream<MekanikAddState> mapEventToState(
    MekanikAddEvent event,
  ) async* {
    if (event is MekanikAddStart) {
      if (event.byPass == false) {
        /// Get Mekanik Table Order Data
        final mekanikTableState = mekanikTableBloc.state;
        if (mekanikTableState is MekanikTableCompleted) {
          /// Yield Loading
          yield MekanikAddLoading();

          /// Filter Order data, Hapus semua yang sudah close atau part kosong
          List<TableOrderModel> orderData = [];
          orderData.addAll(mekanikTableState.tableOrder);
          orderData.removeWhere((element) =>
              element.statusAction == AppString.Close ||
              element.statusAction == AppString.PartKosong);

          /// Loop, cari apakah ada yang duplicate, jika tidak iya, maka kembalikan state Failed.
          /// Jika tidak, maka jalankan firestore write.
          for (var item in orderData) {
            if (item.cnNumber == event.cnUnit) {
              for (var partNumber in event.partNumbers) {
                if (item.number == partNumber.partNumber) {
                  yield MekanikAddFailed(
                      error:
                          "Part Number ${partNumber.partNumber} dengan CN Unit ${event.cnUnit} sudah pernah dipesan sebelumnya");
                  break;
                }

                /// TODO: Perform firestore write
                else {}
              }
            }
          }
        }
      }

      /// TODO: Perfrom firestore write
      else {}
    }
  }

  @override
  Future<void> close() {
    mekanikTableBloc.close();
    return super.close();
  }
}
