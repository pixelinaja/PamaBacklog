import 'dart:async';

import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Service/FCMRepository.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'admin_submit_wr_event.dart';
part 'admin_submit_wr_state.dart';

class AdminSubmitWrBloc extends Bloc<AdminSubmitWrEvent, AdminSubmitWrState> {
  final OrderRepository orderRepository;
  final FCMRepository fcmRepository;
  AdminSubmitWrBloc(
      {@required this.orderRepository, @required this.fcmRepository})
      : super(AdminSubmitWrInitial());

  @override
  Stream<AdminSubmitWrState> mapEventToState(
    AdminSubmitWrEvent event,
  ) async* {
    if (event is AdminSubmitWrStart) {
      yield AdminSubmitWrLoading();

      /// Create a copy of order
      Order order = event.order.copyWith();

      /// Change part number status action
      order.partNumber[event.tableOrder.number].statusPart = "READY";
      order.partNumber[event.tableOrder.number].noWr = event.wrNumber;
      order.partNumber[event.tableOrder.number].statusAction = "READY";

      /// Perform Firestore call
      final updateOrder =
          orderRepository.updateOrder(order: order, oldOrder: event.order);

      try {
        /// Call all the futures
        await Future.wait([updateOrder]);
        yield AdminSubmitWrSuccess(
            msg: "Laporan Telah berhasil di update, dan barang telah Ready.");
      } catch (e) {
        print(e.toString());
        yield AdminSubmitWrFailed(error: e.toString());
      }
    }
  }
}
