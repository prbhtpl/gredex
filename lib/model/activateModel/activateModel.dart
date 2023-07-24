// To parse this JSON data, do
//
//     final activateAccountModel = activateAccountModelFromJson(jsonString);

import 'dart:convert';

ActivateAccountModel activateAccountModelFromJson(String str) => ActivateAccountModel.fromJson(json.decode(str));

String activateAccountModelToJson(ActivateAccountModel data) => json.encode(data.toJson());

class ActivateAccountModel {
  ActivateAccountModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory ActivateAccountModel.fromJson(Map<String, dynamic> json) => ActivateAccountModel(
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
  Data({
    required this.userId,
    required this.createdBy,
    required this.transactionId,
    required this.pintype,
    required this.gdxamount,
    required this.usdamount,
    required this.status,
    required this.tokenType,
    required this.id,
    required this.commDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String userId;
  String createdBy;
  String transactionId;
  int pintype;
  double gdxamount;
  int usdamount;
  int status;
  String tokenType;
  String id;
  DateTime commDate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    createdBy: json["createdBy"],
    transactionId: json["transactionId"],
    pintype: json["pintype"],
    gdxamount: json["gdxamount"]?.toDouble(),
    usdamount: json["usdamount"],
    status: json["status"],
    tokenType: json["tokenType"],
    id: json["_id"],
    commDate: DateTime.parse(json["commDate"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "createdBy": createdBy,
    "transactionId": transactionId,
    "pintype": pintype,
    "gdxamount": gdxamount,
    "usdamount": usdamount,
    "status": status,
    "tokenType": tokenType,
    "_id": id,
    "commDate": commDate.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
