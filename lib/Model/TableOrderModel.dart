import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TableOrderModel {
  String docId;
  Timestamp tanggal;
  String cnNumber;
  String trouble;
  String deskripsi;
  int qty;
  String statusAction;
  String statusPart;
  String number;
  String namaMekanik;
  int approvalPengawas;
  Timestamp tanggalEksekusi;
  String noWr;
  String hmUnit;
  String damageLevel;
  String rejectNote;
  bool isDeleted;

  TableOrderModel(
      {this.docId,
      this.tanggal,
      this.cnNumber,
      this.trouble,
      this.deskripsi,
      this.qty,
      this.statusAction,
      this.statusPart,
      this.number,
      this.namaMekanik,
      this.approvalPengawas,
      this.tanggalEksekusi,
      this.noWr,
      this.damageLevel,
      this.hmUnit,
      this.isDeleted,
      this.rejectNote});

  Map<String, dynamic> toMap() {
    return {
      'docId': docId ?? "",
      'tanggal': tanggal,
      'cnNumber': cnNumber,
      'trouble': trouble,
      'deskripsi': deskripsi,
      'qty': qty,
      'statusAction': statusAction,
      'statusPart': statusPart,
      'number': number,
      'namaMekanik': namaMekanik,
      'approvalPengawas': approvalPengawas,
      'tanggalEksekusi': tanggalEksekusi,
      'noWr': noWr,
      'damageLevel': damageLevel ?? "-",
      'hmUnit': hmUnit ?? "-",
      'isDeleted': isDeleted,
      'rejectNote': rejectNote
    };
  }

  factory TableOrderModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TableOrderModel(
        docId: map['docId'] ?? "",
        tanggal: map['tanggal'],
        cnNumber: map['cnNumber'],
        trouble: map['trouble'],
        deskripsi: map['deskripsi'],
        qty: map['qty'],
        statusAction: map['statusAction'],
        statusPart: map['statusPart'],
        number: map['number'],
        namaMekanik: map['namaMekanik'],
        approvalPengawas: map['approvalPengawas'],
        tanggalEksekusi: map['tanggalEksekusi'],
        noWr: map['noWr'],
        damageLevel: map['damageLevel'] ?? "-",
        hmUnit: map['hmUnit'] ?? "-",
        isDeleted: map['isDeleted'],
        rejectNote: map['rejectNote']);
  }

  String toJson() => json.encode(toMap());

  factory TableOrderModel.fromJson(String source) =>
      TableOrderModel.fromMap(json.decode(source));

  TableOrderModel copyWith({
    String docId,
    Timestamp tanggal,
    String cnNumber,
    String trouble,
    String deskripsi,
    int qty,
    String statusAction,
    String statusPart,
    String number,
    String namaMekanik,
    int approvalPengawas,
    Timestamp tanggalEksekusi,
    String noWr,
    String hmUnit,
    String damageLevel,
    String rejectNote,
    bool isDeleted,
  }) {
    return TableOrderModel(
        docId: docId ?? this.docId,
        tanggal: tanggal ?? this.tanggal,
        cnNumber: cnNumber ?? this.cnNumber,
        trouble: trouble ?? this.trouble,
        deskripsi: deskripsi ?? this.deskripsi,
        qty: qty ?? this.qty,
        statusAction: statusAction ?? this.statusAction,
        statusPart: statusPart ?? this.statusPart,
        number: number ?? this.number,
        namaMekanik: namaMekanik ?? this.namaMekanik,
        approvalPengawas: approvalPengawas ?? this.approvalPengawas,
        tanggalEksekusi: tanggalEksekusi ?? this.tanggalEksekusi,
        noWr: noWr ?? this.noWr,
        damageLevel: damageLevel ?? this.damageLevel,
        hmUnit: hmUnit ?? this.hmUnit,
        isDeleted: isDeleted ?? this.isDeleted ?? false,
        rejectNote: rejectNote ?? this.rejectNote);
  }
}
