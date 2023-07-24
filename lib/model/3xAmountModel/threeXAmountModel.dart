// To parse this JSON data, do
//
//     final threeXamountModel = threeXamountModelFromJson(jsonString);

import 'dart:convert';

ThreeXamountModel threeXamountModelFromJson(String str) => ThreeXamountModel.fromJson(json.decode(str));

String threeXamountModelToJson(ThreeXamountModel data) => json.encode(data.toJson());

class ThreeXamountModel {
  Data data;
  String message;
  bool status;

  ThreeXamountModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ThreeXamountModel.fromJson(Map<String, dynamic> json) => ThreeXamountModel(
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
  double walletamount;
  int finalAmount;
  int activetedAmount;

  Data({
    required this.walletamount,
    required this.finalAmount,
    required this.activetedAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletamount: json["walletamount"]?.toDouble(),
    finalAmount: json["finalAmount"],
    activetedAmount: json["activetedAmount"],
  );

  Map<String, dynamic> toJson() => {
    "walletamount": walletamount,
    "finalAmount": finalAmount,
    "activetedAmount": activetedAmount,
  };
}
