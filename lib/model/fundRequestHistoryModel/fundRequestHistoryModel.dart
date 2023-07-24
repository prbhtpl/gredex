// To parse this JSON data, do
//
//     final fundRequestHistoryModel = fundRequestHistoryModelFromJson(jsonString);

import 'dart:convert';

FundRequestHistoryModel fundRequestHistoryModelFromJson(String str) => FundRequestHistoryModel.fromJson(json.decode(str));

String fundRequestHistoryModelToJson(FundRequestHistoryModel data) => json.encode(data.toJson());

class FundRequestHistoryModel {
  List<FunHistoryList> data;
  String message;
  bool status;

  FundRequestHistoryModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory FundRequestHistoryModel.fromJson(Map<String, dynamic> json) => FundRequestHistoryModel(
    data: List<FunHistoryList>.from(json["data"].map((x) => FunHistoryList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class FunHistoryList {
  dynamic id;
  dynamic userId;
  dynamic hash;
  dynamic gdxamount;
  dynamic usdamount;
  dynamic wallettype;
  dynamic status;
  dynamic remarks;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  FunHistoryList({
    required this.id,
    required this.userId,
    required this.hash,
    required this.gdxamount,
    required this.usdamount,
    required this.wallettype,
    required this.status,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory FunHistoryList.fromJson(Map<String, dynamic> json) => FunHistoryList(
    id: json["_id"],
    userId: json["userId"],
    hash: json["hash"],
    gdxamount: json["gdxamount"],
    usdamount: json["usdamount"]?.toDouble(),
    wallettype: json["wallettype"],
    status: json["status"],
    remarks: json["remarks"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "hash": hash,
    "gdxamount": gdxamount,
    "usdamount": usdamount,
    "wallettype": wallettype,
    "status": status,
    "remarks": remarks,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
  };
}
