import 'dart:async';

import 'package:PamaBacklog/Global/AppRelated/AppString.dart';
import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Global/FirestoreConstant/FirestoreCollectionsConstant.dart';
import 'package:PamaBacklog/Model/NotificationMsgModel.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Service/FCMRepository.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Model/MekanikAddPartNumber.dart';

part 'mekanikadd_event.dart';
part 'mekanikadd_state.dart';

class MekanikAddBloc extends Bloc<MekanikAddEvent, MekanikAddState> {
  final MekanikTableBloc mekanikTableBloc;
  final OrderRepository orderRepository;
  final FCMRepository fcmRepository;
  MekanikAddBloc({
    this.fcmRepository,
    this.orderRepository,
    this.mekanikTableBloc,
  }) : super(MekanikAddInitial());

  @override
  Stream<MekanikAddState> mapEventToState(
    MekanikAddEvent event,
  ) async* {
    if (event is MekanikAddStart) {
      /// Yield Loading
      yield MekanikAddLoading();

      /// Generate part number
      Map<String, PartNumber> partNumber = {};
      for (var item in event.partNumbers) {
        partNumber[item.partNumber] = PartNumber(
            deskripsi: item.description,
            number: item.partNumber,
            qty: item.qty,
            noWr: "-",
            statusAction: "APPROVAL",
            statusPart: "-");
      }

      final randomId = FirebaseFirestore.instance
          .collection(FirestoreCollectionConstant.Orders)
          .doc()
          .id;
      final order = Order(
        approvalPengawas: 0,
        cnNumber: event.cnUnit,
        docId: randomId,
        namaMekanik: event.namaMekanik,
        partNumber: partNumber,
        tanggal: Timestamp.fromDate(event.tanggalLaporan),
        tanggalEksekusi: null,
        trouble: event.trouble,
      );

      if (event.byPass == false) {
        /// Get Mekanik Table Order Data
        final mekanikTableState = mekanikTableBloc.state;
        if (mekanikTableState is MekanikTableCompleted) {
          /// Filter Order data, Hapus semua yang sudah close atau part kosong
          List<TableOrderModel> orderData = [];
          orderData.addAll(mekanikTableState.tableOrder);
          orderData.removeWhere((element) =>
              element.statusAction == AppString.Close ||
              element.statusAction == AppString.PartKosong);

          /// Loop, cari apakah ada yang duplicate, jika tidak iya, maka kembalikan state Failed.
          /// Jika tidak, maka jalankan firestore write.
          var duplicateFlag = false;
          for (var item in orderData) {
            if (item.cnNumber == event.cnUnit) {
              for (var partNumber in event.partNumbers) {
                if (item.number == partNumber.partNumber) {
                  yield MekanikAddFailed(
                      code: ErrorCode.ShouldShowDialog,
                      error:
                          "Part Number ${partNumber.partNumber} dengan CN Unit ${event.cnUnit} sudah pernah dipesan sebelumnya",
                      prevOrderData: order);
                  duplicateFlag = true;
                  break;
                }
              }
            }
          }

          if (duplicateFlag == false) {
            /// Perform Firestore Write
            final updateData = orderRepository.mekanikAddOrder(
                orderData: order, docId: order.docId);

            /// Topic 1 is to send the notification to GL
            final sendNotification = fcmRepository.sendPushNotification(
              topic: "1",
              msg: NotificationMsgModel(
                body:
                    "Order dengan CN Unit ${event.cnUnit} telah dibuat oleh ${event.namaMekanik}",
                orderId: randomId,
                orderStatus: "0",
                title: "Order Baru",
              ),
            );

            try {
              /// Call all the futures
              await Future.wait([updateData, sendNotification]);
              yield MekanikAddCompleted();
            } catch (e) {
              print(e.toString());
              yield MekanikAddFailed(
                  error: e.toString(),
                  code: ErrorCode.Severe,
                  prevOrderData: order);
            }
          }
        } else {
          yield MekanikAddFailed(
            code: ErrorCode.Severe,
            error: "Severe Error Happen, Please Restart the App",
            prevOrderData: order,
          );
        }
      }

      /// Perfrom firestore write
      else {
        final updateData = orderRepository.mekanikAddOrder(
            orderData: order, docId: order.docId);

        /// Topic 1 is to send the notification to GL
        final sendNotification = fcmRepository.sendPushNotification(
          topic: "1",
          msg: NotificationMsgModel(
            body:
                "Order dengan CN Unit ${event.cnUnit} telah dibuat oleh ${event.namaMekanik}",
            orderId: randomId,
            orderStatus: "0",
            title: "Order Baru",
          ),
        );

        try {
          /// Call all the futures
          await Future.wait([updateData, sendNotification]);
          yield MekanikAddCompleted();
        } catch (e) {
          print(e.toString());
          yield MekanikAddFailed(
              error: e.toString(),
              code: ErrorCode.Severe,
              prevOrderData: order);
        }
      }
    }
  }

  @override
  Future<void> close() {
    mekanikTableBloc.close();
    return super.close();
  }
}
