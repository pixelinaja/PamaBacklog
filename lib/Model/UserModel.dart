import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// User Model
class UserModel {
  Timestamp createdAt;
  Timestamp latestLogin;
  UserDeviceInfo deviceInfo;
  String name;
  String role;
  Timestamp updatedAt;

  UserModel({
    this.createdAt,
    this.latestLogin,
    this.deviceInfo,
    this.name,
    this.role,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'latest_Login': latestLogin,
      'device_info': deviceInfo.toMap(),
      'name': name,
      'role': role,
      'updated_at': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      createdAt: map['created_at'],
      latestLogin: map['latest_login'],
      deviceInfo: UserDeviceInfo.fromMap(map['device_info']),
      name: map['name'],
      role: map['role'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

/// User Device Info
class UserDeviceInfo {
  String deviceId;
  String deviceModel;

  UserDeviceInfo({
    this.deviceId,
    this.deviceModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'device_id': deviceId,
      'device_model': deviceModel,
    };
  }

  factory UserDeviceInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserDeviceInfo(
      deviceId: map['device_id'],
      deviceModel: map['device_model'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDeviceInfo.fromJson(String source) =>
      UserDeviceInfo.fromMap(json.decode(source));
}
