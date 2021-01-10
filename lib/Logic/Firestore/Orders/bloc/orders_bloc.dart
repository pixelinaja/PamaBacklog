import 'dart:async';
import 'dart:io';

import 'package:PamaBacklog/Model/OrderModel.dart';
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
        yield OrdersFetched(
            orders: orders, orderPerluPersetujuan: orderPerluPersetujuan);
      } on FirebaseException catch (e) {
        yield OrdersFailed(message: e.message);
      } on SocketException catch (e) {
        yield OrdersFailed(message: e.message);
      } on Exception catch (e) {
        yield OrdersFailed(message: e.toString());
      }
    }
  }
}
