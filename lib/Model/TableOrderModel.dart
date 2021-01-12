import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TableOrderModel {
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

  TableOrderModel({
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
  });

  Map<String, dynamic> toMap() {
    return {
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
    };
  }

  factory TableOrderModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TableOrderModel(
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
    );
  }

  String toJson() => json.encode(toMap());

  factory TableOrderModel.fromJson(String source) =>
      TableOrderModel.fromMap(json.decode(source));

  TableOrderModel copyWith({
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
  }) {
    return TableOrderModel(
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
    );
  }
}
