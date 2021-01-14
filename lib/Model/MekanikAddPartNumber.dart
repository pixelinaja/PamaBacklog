import 'dart:convert';

import 'package:equatable/equatable.dart';

class MekanikAddPartNumber extends Equatable {
  final String partNumber;
  final String description;
  final int qty;

  MekanikAddPartNumber(this.partNumber, this.description, this.qty);

  @override
  List<Object> get props => [partNumber, description, qty];

  Map<String, dynamic> toMap() {
    return {
      'partNumber': partNumber,
      'description': description,
      'qty': qty,
    };
  }

  factory MekanikAddPartNumber.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MekanikAddPartNumber(
      map['partNumber'],
      map['description'],
      map['qty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MekanikAddPartNumber.fromJson(String source) =>
      MekanikAddPartNumber.fromMap(json.decode(source));

  MekanikAddPartNumber copyWith({
    String partNumber,
    String description,
    int qty,
  }) {
    return MekanikAddPartNumber(
      partNumber ?? this.partNumber,
      description ?? this.description,
      qty ?? this.qty,
    );
  }
}
