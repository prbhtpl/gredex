// To parse this JSON data, do
//
//     final usdtTradingHistoryModel = usdtTradingHistoryModelFromJson(jsonString);

import 'dart:convert';

UsdtTradingHistoryModel usdtTradingHistoryModelFromJson(String str) => UsdtTradingHistoryModel.fromJson(json.decode(str));

String usdtTradingHistoryModelToJson(UsdtTradingHistoryModel data) => json.encode(data.toJson());

class UsdtTradingHistoryModel {
  UsdtTradingHistoryModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<USDTTradingList> data;
  String message;
  bool status;

  factory UsdtTradingHistoryModel.fromJson(Map<String, dynamic> json) => UsdtTradingHistoryModel(
    data: List<USDTTradingList>.from(json["data"].map((x) => USDTTradingList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class USDTTradingList {
  USDTTradingList({
    required this.id,
    required this.usdamount,
    required this.status,
    required this.createdAt,
  });

  String id;
  double usdamount;
  int status;
  String createdAt;

  factory USDTTradingList.fromJson(Map<String, dynamic> json) => USDTTradingList(
    id: json["_id"],
    usdamount: json["usdamount"]?.toDouble(),
    status: json["status"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "usdamount": usdamount,
    "status": status,
    "created_at": createdAt,
  };
}
