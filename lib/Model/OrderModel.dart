import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.docId,
    this.tanggal,
    this.cnNumber,
    this.partNumber,
    this.namaMekanik,
    this.approvalPengawas,
    this.tanggalEksekusi,
    this.noWr,
    this.trouble,
  });

  String docId;
  Timestamp tanggal;
  String cnNumber;
  Map<String, PartNumber> partNumber;
  String namaMekanik;
  int approvalPengawas;
  Timestamp tanggalEksekusi;
  String noWr;
  String trouble;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        docId: json["docId"] ?? "",
        tanggal: json["tanggal"],
        cnNumber: json["cn_number"],
        partNumber: (json["part_number"] as Map)
            .map((key, value) => MapEntry(key, PartNumber.fromJson(value))),
        namaMekanik: json["nama_mekanik"],
        approvalPengawas: json["approval_pengawas"],
        tanggalEksekusi: json["tanggal_eksekusi"],
        noWr: json["no_wr"],
        trouble: json["trouble"],
      );

  Map<String, dynamic> toJson() => {
        "docId": docId ?? "",
        "tanggal": tanggal,
        "cn_number": cnNumber,
        "part_number":
            partNumber.map((key, value) => MapEntry(key, value.toJson())),
        "nama_mekanik": namaMekanik,
        "approval_pengawas": approvalPengawas,
        "tanggal_eksekusi": tanggalEksekusi,
        "no_wr": noWr,
        "trouble": trouble
      };
}

class PartNumber {
  PartNumber({
    this.deskripsi,
    this.qty,
    this.statusAction,
    this.statusPart,
    this.number,
  });

  String deskripsi;
  int qty;
  String statusAction;
  String statusPart;
  String number;

  factory PartNumber.fromJson(Map<String, dynamic> json) => PartNumber(
        deskripsi: json["deskripsi"],
        qty: json["Qty"],
        statusAction: json["status_action"],
        statusPart: json["status_part"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "deskripsi": deskripsi,
        "Qty": qty,
        "status_action": statusAction,
        "status_part": statusPart,
        "number": number,
      };
}
