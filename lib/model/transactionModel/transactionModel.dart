// To parse this JSON data, do
//
//     final totalTransactionModel = totalTransactionModelFromJson(jsonString);

import 'dart:convert';

TotalTransactionModel totalTransactionModelFromJson(String str) => TotalTransactionModel.fromJson(json.decode(str));

String totalTransactionModelToJson(TotalTransactionModel data) => json.encode(data.toJson());

class TotalTransactionModel {
  List<TotalBalanceTransactionList> data;
  String message;
  bool status;

  TotalTransactionModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory TotalTransactionModel.fromJson(Map<String, dynamic> json) => TotalTransactionModel(
    data: List<TotalBalanceTransactionList>.from(json["data"].map((x) => TotalBalanceTransactionList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class TotalBalanceTransactionList {
  String id;
  String hash;
  int amount;
  String to;
  int status;
  String createdAt;

  TotalBalanceTransactionList({
    required this.id,
    required this.hash,
    required this.amount,
    required this.to,
    required this.status,
    required this.createdAt,
  });

  factory TotalBalanceTransactionList.fromJson(Map<String, dynamic> json) => TotalBalanceTransactionList(
    id: json["_id"],
    hash: json["hash"],
    amount: json["amount"],
    to: json["to"],
    status: json["status"],
    createdAt:  json["created_at"] ,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "hash": hash,
    "amount": amount,
    "to": to,
    "status": status,
    "created_at": createdAt ,
  };
}
