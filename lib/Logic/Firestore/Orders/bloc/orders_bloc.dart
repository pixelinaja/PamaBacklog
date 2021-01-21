import 'dart:async';
import 'dart:io';

import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderRepository = OrderService();
  OrdersBloc() : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    /// If event is orders fetch, do this.
    if (event is OrdersFetch) {
      yield OrdersLoading();
      try {
        List<Order> orders = await _orderRepository.getOrderData();
        List<Order> orderPerluPersetujuan =
            orders.where((element) => element.approvalPengawas == 0).toList();
        List<Order> adminLaporan =
            orders.where((element) => element.approvalPengawas == 1).toList();
        List<TableOrderModel> tableOrder = _populateTableOrder(orders);
        List<TableOrderModel> tableOrderPerluPersetujuan =
            _populateTableOrder(orderPerluPersetujuan);
        List<TableOrderModel> tableOrderAdminLaporan =
            _populateTableOrder(adminLaporan);

        yield OrdersFetched(
          orders: orders,
          orderPerluPersetujuan: orderPerluPersetujuan,
          adminLaporan: adminLaporan,
          tableOrder: tableOrder,
          tableOrderAdminLaporan: tableOrderAdminLaporan,
          tableOrderPerluPersetujuan: tableOrderPerluPersetujuan,
        );
      } on FirebaseException catch (e) {
        yield OrdersFailed(message: e.message);
      } on SocketException catch (e) {
        yield OrdersFailed(message: e.message);
      } on Exception catch (e) {
        yield OrdersFailed(message: e.toString());
      }
    }
  }

  List<TableOrderModel> _populateTableOrder(List<Order> orders) {
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
    return tableOrder;
  }
}
