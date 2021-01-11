import 'package:cloud_firestore/cloud_firestore.dart';

class CNModel {
  String cnName;
  List<String> cnNumbers;
  Timestamp createdAt;
  Timestamp updatedAt;

  CNModel({this.cnName, this.cnNumbers, this.createdAt, this.updatedAt});

  CNModel.fromJson(Map<String, dynamic> json) {
    cnName = json['cn_name'];
    cnNumbers = json['cn_numbers'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cn_name'] = this.cnName;
    data['cn_numbers'] = this.cnNumbers;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
