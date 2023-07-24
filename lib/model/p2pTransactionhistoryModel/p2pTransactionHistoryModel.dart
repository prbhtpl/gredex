// To parse this JSON data, do
//
//     final p2PTransactionHistoryModel = p2PTransactionHistoryModelFromJson(jsonString);

import 'dart:convert';

P2PTransactionHistoryModel p2PTransactionHistoryModelFromJson(String str) => P2PTransactionHistoryModel.fromJson(json.decode(str));

String p2PTransactionHistoryModelToJson(P2PTransactionHistoryModel data) => json.encode(data.toJson());

class P2PTransactionHistoryModel {
  List<P2pTransactionHistoryList> data;
  String message;
  bool status;

  P2PTransactionHistoryModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory P2PTransactionHistoryModel.fromJson(Map<String, dynamic> json) => P2PTransactionHistoryModel(
    data: List<P2pTransactionHistoryList>.from(json["data"].map((x) => P2pTransactionHistoryList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class P2pTransactionHistoryList {
  String id;
  String debitorId;
  String debitorName;
  String creditorId;
  String creditorName;
  String walletType;
  String type;
  double usdamount;
  String createdAt;
  String transactionId;

  P2pTransactionHistoryList({
    required this.id,
    required this.debitorId,
    required this.debitorName,
    required this.creditorId,
    required this.creditorName,
    required this.walletType,
    required this.type,
    required this.usdamount,
    required this.createdAt,
    required this.transactionId,
  });

  factory P2pTransactionHistoryList.fromJson(Map<String, dynamic> json) => P2pTransactionHistoryList(
    id: json["_id"],
    debitorId: json["debitorId"],
    debitorName: json["debitorName"],
    creditorId: json["creditorId"],
    creditorName: json["creditorName"],
    walletType: json["walletType"],
    type: json["type"],
    usdamount: json["usdamount"]?.toDouble(),
    createdAt: json["created_at"],
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "debitorId": debitorId,
    "debitorName": debitorName,
    "creditorId": creditorId,
    "creditorName": creditorName,
    "walletType": walletType,
    "type": type,
    "usdamount": usdamount,
    "created_at": createdAt,
    "transactionId": transactionId,
  };
}
