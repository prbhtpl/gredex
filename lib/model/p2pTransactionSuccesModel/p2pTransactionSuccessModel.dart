// To parse this JSON data, do
//
//     final p2PTransactionSuccesModel = p2PTransactionSuccesModelFromJson(jsonString);

import 'dart:convert';

P2PTransactionSuccesModel p2PTransactionSuccesModelFromJson(String str) => P2PTransactionSuccesModel.fromJson(json.decode(str));

String p2PTransactionSuccesModelToJson(P2PTransactionSuccesModel data) => json.encode(data.toJson());

class P2PTransactionSuccesModel {
  P2PTransactionSuccesModel({
    required this.createdBy,
    required this.createdAt,
    required this.gdxamount,
    required this.status,
    required this.transactionId,
    required this.updatedAt,
    required this.usdamount,
    required this.userId,
    required this.walletType,
    required this.v,
    required this.id,
    required this.message,
  });

  String createdBy;
  DateTime createdAt;
  int gdxamount;
  bool status;
  String transactionId;
  DateTime updatedAt;
  int usdamount;
  String userId;
  String walletType;
  int v;
  String id;
  String message;

  factory P2PTransactionSuccesModel.fromJson(Map<String, dynamic> json) => P2PTransactionSuccesModel(
    createdBy: json["createdBy"],
    createdAt: DateTime.parse(json["created_at"]),
    gdxamount: json["gdxamount"],
    status: json["status"],
    transactionId: json["transactionId"],
    updatedAt: DateTime.parse(json["updated_at"]),
    usdamount: json["usdamount"],
    userId: json["userId"],
    walletType: json["walletType"],
    v: json["__v"],
    id: json["_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "created_at": createdAt.toIso8601String(),
    "gdxamount": gdxamount,
    "status": status,
    "transactionId": transactionId,
    "updated_at": updatedAt.toIso8601String(),
    "usdamount": usdamount,
    "userId": userId,
    "walletType": walletType,
    "__v": v,
    "_id": id,
    "message": message,
  };
}
