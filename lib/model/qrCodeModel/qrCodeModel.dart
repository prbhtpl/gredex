// To parse this JSON data, do
//
//     final qrModel = qrModelFromJson(jsonString);

import 'dart:convert';

QrModel qrModelFromJson(String str) => QrModel.fromJson(json.decode(str));

String qrModelToJson(QrModel data) => json.encode(data.toJson());

class QrModel {
  Data data;
  String message;
  bool status;

  QrModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory QrModel.fromJson(Map<String, dynamic> json) => QrModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}

class Data {
  String id;
  String userId;
  dynamic accounts;
  dynamic addressNo;
  String publicAddress;
  dynamic status;
  dynamic bnbToken;
  dynamic balance;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic v;

  Data({
    required this.id,
    required this.userId,
    required this.accounts,
    required this.addressNo,
    required this.publicAddress,
    required this.status,
    required this.bnbToken,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userId: json["userId"],
    accounts: json["accounts"],
    addressNo: json["addressNo"],
    publicAddress: json["publicAddress"],
    status: json["status"],
    bnbToken: json["BnbToken"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "accounts": accounts,
    "addressNo": addressNo,
    "publicAddress": publicAddress,
    "status": status,
    "BnbToken": bnbToken,
    "balance": balance,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
