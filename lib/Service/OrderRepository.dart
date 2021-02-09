import 'package:PamaBacklog/Global/FirestoreConstant/FirestoreCollectionsConstant.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class OrderRepository {
  /// Get Order Data from Firestore
  Future<List<Order>> getOrderData();

  /// Add Order to Firestore
  Future<void> mekanikAddOrder(
      {@required Order orderData, @required String docId});

  /// Update order
  Future<void> mekanikUpdateOrder(
      {@required String orderId,
      @required String status,
      @required String partNumber,
      @required TableOrderModel orderDetail});

  /// GL Approve Order
  Future<void> glApproveOrder({@required Order order, Order oldOrder});

  /// Update Order
  Future<void> updateOrder({@required Order order, Order oldOrder});
}

class OrderService implements OrderRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<Order>> getOrderData() async {
    QuerySnapshot snapshot = await _db
        .collection(FirestoreCollectionConstant.Orders)
        .orderBy("tanggal", descending: true)
        .get();

    return snapshot.docs.map((e) {
      var order = Order.fromJson(e.data());
      order.docId = e.id;
      return order;
    }).toList();
  }

  @override
  Future<void> mekanikUpdateOrder(
      {String orderId,
      String status,
      String partNumber,
      TableOrderModel orderDetail}) async {
    /// Order detail map
    var order = orderDetail.toMap();
    order.addAll({'updated_at': Timestamp.now()});

    /// Buat history perubahan
    final createHistory = _db
        .collection(FirestoreCollectionConstant.Orders)
        .doc(orderId)
        .collection(FirestoreCollectionConstant.History)
        .add(order);

    /// Update data
    final updateDocument =
        _db.collection(FirestoreCollectionConstant.Orders).doc(orderId).set({
      'part_number': {
        partNumber: {'status_action': status.toUpperCase()}
      }
    }, SetOptions(merge: true));

    /// Jalankan perintah update dan buat history
    await Future.wait([createHistory, updateDocument]);
  }

  @override
  Future<void> mekanikAddOrder({Order orderData, String docId}) async {
    await _db
        .collection(FirestoreCollectionConstant.Orders)
        .doc(docId)
        .set(orderData.toJson());
  }

  @override
  Future<void> glApproveOrder({Order oldOrder, Order order}) async {
    final orderData = order.toJson();
    final oldOrderData = oldOrder.toJson();

    /// Buat history perubahan
    final createHistory = _db
        .collection(FirestoreCollectionConstant.Orders)
        .doc(order.docId)
        .collection(FirestoreCollectionConstant.History)
        .add(oldOrderData);

    /// Update data
    final updateDocument = _db
        .collection(FirestoreCollectionConstant.Orders)
        .doc(order.docId)
        .set(orderData, SetOptions(merge: true));

    /// Jalankan perintah update dan buat history
    await Future.wait([createHistory, updateDocument]);
  }

  @override
  Future<void> updateOrder({Order oldOrder, Order order}) async {
    final orderData = order.toJson();
    final oldOrderData = oldOrder.toJson();

    print(orderData);

    /// Buat history perubahan
    final createHistory = _db
        .collection(FirestoreCollectionConstant.Orders)
        .doc(order.docId)
        .collection(FirestoreCollectionConstant.History)
        .add(oldOrderData);

    /// Update data
    final updateDocument = _db
        .collection(FirestoreCollectionConstant.Orders)
        .doc(order.docId)
        .set(orderData, SetOptions(merge: true));

    /// Jalankan perintah update dan buat history
    await Future.wait([createHistory, updateDocument]);
  }
}
