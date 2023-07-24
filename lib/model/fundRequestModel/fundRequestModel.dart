// To parse this JSON data, do
//
//     final fundRequestModel = fundRequestModelFromJson(jsonString);

import 'dart:convert';

FundRequestModel fundRequestModelFromJson(String str) => FundRequestModel.fromJson(json.decode(str));

String fundRequestModelToJson(FundRequestModel data) => json.encode(data.toJson());

class FundRequestModel {
  FundRequestModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory FundRequestModel.fromJson(Map<String, dynamic> json) => FundRequestModel(
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
    required this.hash,
    required this.gdxamount,
    required this.status,
    this.remarks,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String userId;
  String hash;
  int gdxamount;
  int status;
  dynamic remarks;
  String id;
  String createdAt;
  String updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    hash: json["hash"],
    gdxamount: json["gdxamount"],
    status: json["status"],
    remarks: json["remarks"],
    id: json["_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "hash": hash,
    "gdxamount": gdxamount,
    "status": status,
    "remarks": remarks,
    "_id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
  };
}
