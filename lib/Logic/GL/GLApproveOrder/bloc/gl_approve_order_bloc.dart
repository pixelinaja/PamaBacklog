import 'dart:async';

import 'package:PamaBacklog/Global/AppRelated/AppString.dart';
import 'package:PamaBacklog/Model/NotificationMsgModel.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Service/FCMRepository.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';

part 'gl_approve_order_event.dart';
part 'gl_approve_order_state.dart';

class GLApproveOrderBloc
    extends Bloc<GLApproveOrderEvent, GLApproveOrderState> {
  final OrderRepository orderRepository;
  final FCMRepository fcmRepository;

  GLApproveOrderBloc({this.orderRepository, this.fcmRepository})
      : super(GLApproveOrderInitial());

  @override
  Stream<GLApproveOrderState> mapEventToState(
    GLApproveOrderEvent event,
  ) async* {
    if (event is GLApproveOrderApproved) {
      yield GLApproveOrderLoading();

      /// Create a copy of order
      Order order = Order(
        approvalPengawas: 1,
        cnNumber: event.order.cnNumber,
        docId: event.order.docId,
        namaMekanik: event.order.namaMekanik,
        partNumber: event.order.partNumber,
        tanggal: event.order.tanggal,
        tanggalEksekusi: Timestamp.fromDate(event.tanggalEksekusi),
        trouble: event.order.trouble,
      );

      /// Change each part number status action
      for (var i = 0; i < order.partNumber.keys.length; i++) {
        final key = order.partNumber.keys.toList()[i];
        order.partNumber[key].statusAction = "APPROVED";
      }

      /// Perform Firestore call
      final updateOrder = orderRepository.glApproveOrder(order: order);
      final sendNotificationMekanik = fcmRepository.sendPushNotification(
        topic: "2",
        msg: NotificationMsgModel(
          body:
              "Order dengan CN Unit ${order.cnNumber} telah disetujui oleh pengawas",
          orderId: order.docId,
          orderStatus: "1",
          title: "Order Disetujui",
        ),
      );
      final sendNotificationAdmin = fcmRepository.sendPushNotification(
        topic: "0",
        msg: NotificationMsgModel(
          body:
              "Order dengan CN Unit ${order.cnNumber} telah disetujui oleh pengawas",
          orderId: order.docId,
          orderStatus: "1",
          title: "Order Baru",
        ),
      );

      try {
        /// Call all the futures
        await Future.wait(
            [updateOrder, sendNotificationMekanik, sendNotificationAdmin]);
        yield GLApproveOrderSuccess(
            approvalPengawas: order.approvalPengawas,
            tanggal: order.tanggalEksekusi
                .toDate()
                .parseDate(dateFormat: "dd MMMM yyyy"));
      } catch (e) {
        print(e.toString());
        yield GLApproveOrderFailed(error: e.toString());
      }
    }

    /// If event is not approve
    else if (event is GLApproveOrderNotApproved) {
      yield GLApproveOrderLoading();

      /// Create a copy of order
      Order order = Order(
        approvalPengawas: 2,
        cnNumber: event.order.cnNumber,
        docId: event.order.docId,
        namaMekanik: event.order.namaMekanik,
        partNumber: event.order.partNumber,
        tanggal: event.order.tanggal,
        tanggalEksekusi: Timestamp.fromDate(event.tanggalEksekusi),
        trouble: event.order.trouble,
      );

      /// Change each part number status action
      for (var i = 0; i < order.partNumber.keys.length; i++) {
        final key = order.partNumber.keys.toList()[i];
        order.partNumber[key].statusAction = AppString.NotApprove;
      }

      /// Perform Firestore call
      final updateOrder = orderRepository.glApproveOrder(order: order);
      final sendNotificationMekanik = fcmRepository.sendPushNotification(
        topic: "2",
        msg: NotificationMsgModel(
          body:
              "Order dengan CN Unit ${order.cnNumber} tidak disetujui oleh pengawas, silahkan lakukan perbaikan secepatnya",
          orderId: order.docId,
          orderStatus: "2",
          title: "Order Tidak Disetujui",
        ),
      );

      try {
        /// Call all the futures
        await Future.wait([updateOrder, sendNotificationMekanik]);
        yield GLApproveOrderSuccess(
            approvalPengawas: order.approvalPengawas,
            tanggal:
                order.tanggal.toDate().parseDate(dateFormat: "dd MMMM yyyy"),
            cnNumber: order.cnNumber);
      } catch (e) {
        print(e.toString());
        yield GLApproveOrderFailed(error: e.toString());
      }
    }
  }
}
