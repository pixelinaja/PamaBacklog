import 'dart:async';

import 'package:PamaBacklog/Model/NotificationMsgModel.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Service/FCMRepository.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';

part 'admin_submit_estimasi_event.dart';
part 'admin_submit_estimasi_state.dart';

class AdminSubmitEstimasiBloc
    extends Bloc<AdminSubmitEstimasiEvent, AdminSubmitEstimasiState> {
  final OrderRepository orderRepository;
  final FCMRepository fcmRepository;
  AdminSubmitEstimasiBloc({this.orderRepository, this.fcmRepository})
      : super(AdminSubmitEstimasiInitial());

  @override
  Stream<AdminSubmitEstimasiState> mapEventToState(
    AdminSubmitEstimasiEvent event,
  ) async* {
    if (event is AdminSubmitEstimasiStart) {
      yield AdminSubmitEstimasiLoading();

      /// Create a copy of order
      Order order = Order(
        approvalPengawas: 1,
        cnNumber: event.order.cnNumber,
        docId: event.order.docId,
        namaMekanik: event.order.namaMekanik,
        partNumber: event.order.partNumber,
        tanggal: event.order.tanggal,
        tanggalEksekusi: event.order.tanggalEksekusi,
        trouble: event.order.trouble,
      );

      /// Change each part number status action
      order.partNumber[event.tableOrder.number].statusPart =
          "EST ${event.tanggalEstimasi.parseDate(dateFormat: 'dd MMM yyyy')}";

      /// Perform Firestore call
      final updateOrder =
          orderRepository.glApproveOrder(order: order, oldOrder: event.order);
      final sendNotificationMekanik = fcmRepository.sendPushNotification(
        topic: "1",
        msg: NotificationMsgModel(
          body:
              "Order dengan CN Unit ${order.cnNumber} dan Part Number ${event.tableOrder.number} telah dipesan oleh admin",
          orderId: order.docId,
          orderStatus: "1",
          title: "Order telah Dipesan",
        ),
      );
      final sendNotificationAdmin = fcmRepository.sendPushNotification(
        topic: "2",
        msg: NotificationMsgModel(
          body:
              "Order dengan CN Unit ${order.cnNumber} dan Part Number ${event.tableOrder.number} telah dipesan oleh admin",
          orderId: order.docId,
          orderStatus: "1",
          title: "Order telah Dipesan",
        ),
      );

      try {
        /// Call all the futures
        await Future.wait(
            [updateOrder, sendNotificationMekanik, sendNotificationAdmin]);
        yield AdminSubmitEstimasiSuccess(
            msg:
                "Terima kasih atas konfirmasi yang dilakukan. Dan jangan lupa update status jika part telah tersedia.");
      } catch (e) {
        print(e.toString());
        yield AdminSubmitEstimasiFailed(e.toString());
      }
    }
  }
}
