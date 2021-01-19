import 'dart:async';

import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'MekanikUpdateLaporan_event.dart';
part 'MekanikUpdateLaporan_state.dart';

class MekanikUpdateLaporanBloc
    extends Bloc<MekanikUpdateLaporanEvent, MekanikUpdateLaporanState> {
  final OrderRepository _orderRepository = OrderService();
  MekanikUpdateLaporanBloc() : super(MekanikUpdateLaporanInitial());

  @override
  Stream<MekanikUpdateLaporanState> mapEventToState(
    MekanikUpdateLaporanEvent event,
  ) async* {
    if (event is MekanikUpdateLaporanMulai) {
      yield MekanikUpdateLaporanLoading();
      try {
        await _orderRepository.mekanikUpdateOrder(
            orderId: event.docId,
            status: event.status,
            partNumber: event.partNumber,
            orderDetail: event.orderDetail);
        var updatedOrder =
            event.orderDetail.copyWith(statusAction: event.status);

        yield MekanikUpdateLaporanCompleted(updatedOrder);
      } catch (e) {
        print(e.toString());
        yield MekanikUpdateLaporanFailed(
            "Gagal Meng-update data laporan, silahkan coba lagi");
      }
    }
  }
}
