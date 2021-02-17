import 'dart:async';

import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gl_delete_order_event.dart';
part 'gl_delete_order_state.dart';

class GlDeleteOrderBloc extends Bloc<GlDeleteOrderEvent, GlDeleteOrderState> {
  final OrderRepository orderRepository = OrderService();
  GlDeleteOrderBloc() : super(GlDeleteOrderInitial());

  @override
  Stream<GlDeleteOrderState> mapEventToState(
    GlDeleteOrderEvent event,
  ) async* {
    if (event is GlDeleteOrderStart) {
      yield GlDeleteOrderLoading();

      /// Create a copy of order
      Order order = event.order.copyWith();

      /// Mark Order as Deleted
      order.isDeleted = true;

      /// Perform Firestore call
      final updateOrder =
          orderRepository.updateOrder(order: order, oldOrder: event.order);

      try {
        /// Call all the futures
        await Future.wait([updateOrder]);
        yield GlDeleteOrderSuccess(msg: "Laporan Telah berhasil dihapus.");
      } catch (e) {
        print(e.toString());
        yield GlDeleteOrderFailed(error: e.toString());
      }
    }
  }
}
