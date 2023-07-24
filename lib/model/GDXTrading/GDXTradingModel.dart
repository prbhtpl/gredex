// To parse this JSON data, do
//
//     final gdxTradingModel = gdxTradingModelFromJson(jsonString);

import 'dart:convert';

GdxTradingModel gdxTradingModelFromJson(String str) => GdxTradingModel.fromJson(json.decode(str));

String gdxTradingModelToJson(GdxTradingModel data) => json.encode(data.toJson());

class GdxTradingModel {
  GdxTradingModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<GDXTradingList> data;
  String message;
  bool status;

  factory GdxTradingModel.fromJson(Map<String, dynamic> json) => GdxTradingModel(
    data: List<GDXTradingList>.from(json["data"].map((x) => GDXTradingList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GDXTradingList {
  GDXTradingList({
    required this.id,
    required this.amount,
    required this.usdamount,
    required this.status,
    required this.createdAt,
  });

  String id;
  double amount;
  double usdamount;
  int status;
  String createdAt;

  factory GDXTradingList.fromJson(Map<String, dynamic> json) => GDXTradingList(
    id: json["_id"],
    amount: json["amount"]?.toDouble(),
    usdamount: json["usdamount"]?.toDouble(),
    status: json["status"],
    createdAt:  json["created_at"] ,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amount": amount,
    "usdamount": usdamount,
    "status": status,
    "created_at": createdAt,
  };
}
