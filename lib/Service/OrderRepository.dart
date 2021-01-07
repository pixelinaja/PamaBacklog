import 'package:PamaBacklog/Global/FirestoreConstant/FirestoreCollectionsConstant.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class OrderRepository {
  /// Get User Data from Firestore
  Future<List<Order>> getOrderData();

  /// Update order
  Future<void> updateOrder(
      {@required String orderId, @required Order orderData});
}

class OrderService implements OrderRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<Order>> getOrderData() async {
    QuerySnapshot snapshot =
        await _db.collection(FirestoreCollectionConstant.Orders).get();

    return snapshot.docs.map((e) => Order.fromJson(e.data())).toList();
  }

  @override
  Future<void> updateOrder({String orderId, Order orderData}) async {}
}
