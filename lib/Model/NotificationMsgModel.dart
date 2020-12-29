import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationMsgModel extends Equatable {
  /// Notification Title
  final String title;

  /// Notification Body (Text)
  final String body;

  /// Notification Data Order ID
  final String orderId;

  /// Notification Data Order Status
  final String orderStatus;

  NotificationMsgModel({
    this.title,
    this.body,
    this.orderId,
    this.orderStatus,
  });

  /// Equatable
  @override
  List<Object> get props => [title, body, orderId, orderStatus];

  /// Convert string to map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'orderId': orderId,
      'orderStatus': orderStatus,
    };
  }

  /// Convert map to Model
  factory NotificationMsgModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NotificationMsgModel(
      title: map['title'],
      body: map['body'],
      orderId: map['orderId'],
      orderStatus: map['orderStatus'],
    );
  }

  /// Convert Map to JSON
  String toJson() => json.encode(toMap());

  /// Convert Json to Model
  factory NotificationMsgModel.fromJson(String source) =>
      NotificationMsgModel.fromMap(json.decode(source));
}
