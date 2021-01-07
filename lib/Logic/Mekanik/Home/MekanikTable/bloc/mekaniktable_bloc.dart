import 'dart:async';

import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'mekaniktable_event.dart';
part 'mekaniktable_state.dart';

class MekanikTableBloc extends Bloc<MekanikTableEvent, MekanikTableState> {
  final OrderRepository _orderRepository;
  MekanikTableBloc(this._orderRepository) : super(MekanikTableInitial());

  @override
  Stream<MekanikTableState> mapEventToState(
    MekanikTableEvent event,
  ) async* {
    if (event is MekanikTableFetchData) {
      yield MekanikTableLoading();
      try {
        List<Order> orders = await _orderRepository.getOrderData();
        yield MekanikTableCompleted(orders: orders);
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
