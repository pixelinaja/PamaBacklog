import 'package:PamaBacklog/Global/FirestoreConstant/FirestoreCollectionsConstant.dart';
import 'package:PamaBacklog/Model/CNModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class CNRepository {
  /// Get User Data from Firestore
  Future<List<CNModel>> getCNData();

  /// Update order
  Future<void> updateCN(
      {@required String cnId,
      @required CNModel cnData,
      @required CNModel oldCNData});
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
  Future<void> updateCN(
      {String cnId, CNModel cnData, CNModel oldCNData}) async {
    final newCNData = cnData.toJson();
    final oldCN = oldCNData.toJson();

    /// Buat history perubahan
    final createHistory = _db
        .collection(FirestoreCollectionConstant.CN)
        .doc(oldCNData.cnName.toLowerCase())
        .collection(FirestoreCollectionConstant.History)
        .add(oldCN);

    /// Update data
    final updateDocument = _db
        .collection(FirestoreCollectionConstant.CN)
        .doc(cnData.cnName.toLowerCase())
        .set(newCNData, SetOptions(merge: true));

    /// Jalankan perintah update dan buat history
    await Future.wait([createHistory, updateDocument]);
  }
}
