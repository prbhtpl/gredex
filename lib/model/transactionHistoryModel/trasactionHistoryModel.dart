// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) => TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) => json.encode(data.toJson());

class TransactionHistoryModel {
  List<TransactionHistoryList> data;
  String message;
  bool status;

  TransactionHistoryModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => TransactionHistoryModel(
    data: List<TransactionHistoryList>.from(json["data"].map((x) => TransactionHistoryList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class TransactionHistoryList {
  String id;
  String userId;
  dynamic amount;
  String type;
  String category;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  int v;

  TransactionHistoryList({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TransactionHistoryList.fromJson(Map<String, dynamic> json) => TransactionHistoryList(
    id: json["_id"],
    userId: json["userId"],
    amount: json["amount"],
    type: json["type"],
    category: json["category"],
    description: json["description"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt:  json["updated_at"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "amount": amount,
    "type": type,
    "category": category,
    "description": description,
    "status": status,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "__v": v,
  };
}
