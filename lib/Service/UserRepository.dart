import 'package:PamaBacklog/Global/FirestoreConstant/FirestoreCollectionsConstant.dart';
import 'package:PamaBacklog/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';

abstract class UserRepository {
  /// Get User Data from Firestore
  Future<UserModel> getUserData({@required String userId});

  Future<void> updateUserData({@required String userId});
}

class UserService implements UserRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Future<UserModel> getUserData({String userId}) async {
    DocumentSnapshot snapshot = await db
        .collection(FirestoreCollectionConstant.Users)
        .doc(userId)
        .get();

    UserModel userData = UserModel.fromMap(snapshot.data());
    return userData;
  }

  @override
  Future<void> updateUserData({String userId}) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    await db.collection(FirestoreCollectionConstant.Users).doc(userId).update({
      "device_info": {
        "device_id": androidInfo.androidId,
        "device_model": androidInfo.model,
      },
      "latest_login": Timestamp.now(),
      "updated_at": Timestamp.now()
    });
  }
}
