import 'dart:async';

import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTableSwitch/cubit/mekaniktableswitch_cubit.dart';
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
              approvalPengawas: order.approvalPengawas,
              cnNumber: order.cnNumber,
              deskripsi: part.deskripsi,
              namaMekanik: order.namaMekanik,
              noWr: order.noWr,
              number: part.number,
              qty: part.qty,
              statusAction: part.statusAction,
              statusPart: part.statusPart,
              tanggal: order.tanggal,
              tanggalEksekusi: order.tanggalEksekusi,
              trouble: order.trouble,
            );

            /// Append to list
            tableOrder.add(temp);
          }
        }
        yield MekanikTableCompleted(orders: orders, tableOrder: tableOrder);
      } on FirebaseException catch (e) {
        yield MekanikTableFailed(e.message);
      } on Exception catch (e) {
        yield MekanikTableFailed(e.toString());
      } catch (e) {
        yield MekanikTableFailed(e.toString());
      }
    }
  }
}
