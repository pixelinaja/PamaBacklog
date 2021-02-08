import 'package:cloud_firestore/cloud_firestore.dart';

class CNListModel {
  String cnName;
  String cnNumber;
  Timestamp createdAt;
  Timestamp updatedAt;

  CNListModel({this.cnName, this.cnNumber, this.createdAt, this.updatedAt});

  CNListModel.fromJson(Map<String, dynamic> json) {
    cnName = json['cn_name'];
    cnNumber = json['cn_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cn_name'] = this.cnName;
    data['cn_number'] = this.cnNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
