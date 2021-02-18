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
    this.trouble,
    this.damageLevel,
    this.hmUnit,
    this.rejectNote,
    this.isDeleted,
  });

  String docId;
  Timestamp tanggal;
  String cnNumber;
  Map<String, PartNumber> partNumber;
  String namaMekanik;
  int approvalPengawas;
  Timestamp tanggalEksekusi;
  String trouble;
  String hmUnit;
  String damageLevel;
  String rejectNote;
  bool isDeleted;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        docId: json["docId"] ?? "",
        tanggal: json["tanggal"],
        cnNumber: json["cn_number"],
        partNumber: (json["part_number"] as Map)
            .map((key, value) => MapEntry(key, PartNumber.fromJson(value))),
        namaMekanik: json["nama_mekanik"],
        approvalPengawas: json["approval_pengawas"],
        tanggalEksekusi: json["tanggal_eksekusi"],
        trouble: json["trouble"],
        damageLevel: json["damageLevel"],
        hmUnit: json['hmUnit'],
        rejectNote: json['rejectNote'],
        isDeleted: json['isDeleted'],
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
        "trouble": trouble,
        "hmUnit": hmUnit,
        "damageLevel": damageLevel,
        "rejectNote": rejectNote,
        "isDeleted": isDeleted ?? false,
      };

  Order copyWith(
      {String docId,
      Timestamp tanggal,
      String cnNumber,
      Map<String, PartNumber> partNumber,
      String namaMekanik,
      int approvalPengawas,
      Timestamp tanggalEksekusi,
      String trouble,
      String hmUnit,
      String damageLevel,
      String rejectNote,
      String isDeleted}) {
    return Order(
        docId: docId ?? this.docId,
        tanggal: tanggal ?? this.tanggal,
        cnNumber: cnNumber ?? this.cnNumber,
        trouble: trouble ?? this.trouble,
        partNumber: partNumber ?? this.partNumber,
        namaMekanik: namaMekanik ?? this.namaMekanik,
        approvalPengawas: approvalPengawas ?? this.approvalPengawas,
        tanggalEksekusi: tanggalEksekusi ?? this.tanggalEksekusi,
        damageLevel: damageLevel ?? this.damageLevel,
        hmUnit: hmUnit ?? this.hmUnit,
        rejectNote: rejectNote ?? this.rejectNote,
        isDeleted: isDeleted ?? this.isDeleted);
  }
}

class PartNumber {
  PartNumber({
    this.deskripsi,
    this.qty,
    this.statusAction,
    this.statusPart,
    this.number,
    this.noWr,
  });

  String deskripsi;
  int qty;
  String statusAction;
  String statusPart;
  String number;
  String noWr;

  factory PartNumber.fromJson(Map<String, dynamic> json) => PartNumber(
        deskripsi: json["deskripsi"],
        qty: json["Qty"],
        statusAction: json["status_action"],
        statusPart: json["status_part"],
        number: json["number"],
        noWr: json["noWr"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "deskripsi": deskripsi,
        "Qty": qty,
        "status_action": statusAction,
        "status_part": statusPart,
        "number": number,
        "noWr": noWr,
      };
}
