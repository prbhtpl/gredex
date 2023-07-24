// To parse this JSON data, do
//
//     final convertedAmountModel = convertedAmountModelFromJson(jsonString);

import 'dart:convert';

ConvertedAmountModel convertedAmountModelFromJson(String str) => ConvertedAmountModel.fromJson(json.decode(str));

String convertedAmountModelToJson(ConvertedAmountModel data) => json.encode(data.toJson());

class ConvertedAmountModel {
  double data;
  String message;
  bool status;

  ConvertedAmountModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ConvertedAmountModel.fromJson(Map<String, dynamic> json) => ConvertedAmountModel(
    data: json["data"]?.toDouble(),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "status": status,
  };
}
