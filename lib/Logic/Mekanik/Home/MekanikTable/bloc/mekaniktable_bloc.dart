import 'dart:async';

import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'mekaniktable_event.dart';
part 'mekaniktable_state.dart';

class MekanikTableBloc extends Bloc<MekanikTableEvent, MekanikTableState> {
  final OrderRepository orderRepository;
  MekanikTableBloc({this.orderRepository}) : super(MekanikTableInitial());

  @override
  Stream<MekanikTableState> mapEventToState(
    MekanikTableEvent event,
  ) async* {
    if (event is MekanikTableFetchData) {
      yield MekanikTableLoading();
      try {
        List<Order> orders = await orderRepository.getOrderData();
        List<TableOrderModel> tableOrder = [];
        for (var order in orders) {
          for (var part in order.partNumber.values) {
            /// Populate and create a new table order model
            TableOrderModel temp = TableOrderModel(
                docId: order.docId,
                approvalPengawas: order.approvalPengawas,
                cnNumber: order.cnNumber,
                deskripsi: part.deskripsi,
                namaMekanik: order.namaMekanik,
                number: part.number,
                noWr: part.noWr,
                qty: part.qty,
                statusAction: part.statusAction,
                statusPart: part.statusPart,
                tanggal: order.tanggal,
                tanggalEksekusi: order.tanggalEksekusi,
                trouble: order.trouble,
                damageLevel: order.damageLevel ?? "-",
                hmUnit: order.hmUnit ?? "-",
                isDeleted: order.isDeleted ?? false,
                rejectNote: order.rejectNote);

            /// Append to list
            tableOrder.add(temp);
          }
        }
        yield MekanikTableCompleted(orders: orders, tableOrder: tableOrder)
            .copyWith(
          orders: orders,
          tableOrder: tableOrder,
        );
      } on FirebaseException catch (e) {
        yield MekanikTableFailed(e.message);
      } on Exception catch (e) {
        yield MekanikTableFailed(e.toString());
      } catch (e) {
        yield MekanikTableFailed(e.toString());
      }
    } else if (event is MekanikTableUpdateData) {
      if (state is MekanikTableCompleted) {
        var order = (state as MekanikTableCompleted).orders;
        var orderDetail = (state as MekanikTableCompleted).tableOrder;
        int indexDetail = orderDetail.indexWhere((element) =>
            element.cnNumber == event.orderDetail.cnNumber &&
            element.number == event.orderDetail.number);
        int indexOrder = order
            .indexWhere((element) => element.docId == event.orderDetail.docId);
        orderDetail[indexDetail] = event.orderDetail;
        order[indexOrder].partNumber[event.orderDetail.number].statusAction =
            event.orderDetail.statusAction;

        yield MekanikTableLoading();
        yield MekanikTableCompleted(orders: order, tableOrder: orderDetail)
            .copyWith(
          orders: order,
          tableOrder: orderDetail,
        );
      }
    }
  }
}
