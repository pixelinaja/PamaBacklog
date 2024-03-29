import 'dart:async';
import 'dart:io';

import 'package:PamaBacklog/Model/CNListModel.dart';
import 'package:PamaBacklog/Model/CNModel.dart';
import 'package:PamaBacklog/Service/CNRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'cn_event.dart';
part 'cn_state.dart';

class CNBloc extends Bloc<CNEvent, CNState> {
  final CNRepository _cnRepository = CNService();
  CNBloc() : super(CNInitial());

  @override
  Stream<CNState> mapEventToState(
    CNEvent event,
  ) async* {
    if (event is CNFetch) {
      yield CNLoading();
      try {
        List<CNModel> cnData = await _cnRepository.getCNData();
        List<CNListModel> cnListModel = [];
        cnData.forEach((element) {
          element.cnNumbers.forEach((number) {
            cnListModel.add(CNListModel(
              cnName: element.cnName,
              cnNumber: number,
              createdAt: element.createdAt,
              updatedAt: element.updatedAt,
            ));
          });
        });
        yield CNCompleted(cnData: cnData, cnList: cnListModel);
      } on FirebaseException catch (e) {
        yield CNFailed(error: e.message);
      } on SocketException catch (e) {
        yield CNFailed(error: e.message);
      } on Exception catch (e) {
        yield CNFailed(error: e.toString());
      }
    }
  }
}
