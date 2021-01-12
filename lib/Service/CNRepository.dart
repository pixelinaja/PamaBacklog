import 'package:PamaBacklog/Global/FirestoreConstant/FirestoreCollectionsConstant.dart';
import 'package:PamaBacklog/Model/CNModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class CNRepository {
  /// Get User Data from Firestore
  Future<List<CNModel>> getCNData();

  /// Update order
  Future<void> updateCN({@required String cnId, @required CNModel cnData});
}

class CNService implements CNRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<CNModel>> getCNData() async {
    QuerySnapshot snapshot =
        await _db.collection(FirestoreCollectionConstant.CN).get();

    return snapshot.docs.map((e) => CNModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> updateCN({String cnId, CNModel cnData}) async {}
}
