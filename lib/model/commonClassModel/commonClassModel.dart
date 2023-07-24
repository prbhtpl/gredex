// To parse this JSON data, do
//
//     final commonClassModel = commonClassModelFromJson(jsonString);

import 'dart:convert';

CommonClassModel commonClassModelFromJson(String str) => CommonClassModel.fromJson(json.decode(str));

String commonClassModelToJson(CommonClassModel data) => json.encode(data.toJson());

class CommonClassModel {
  CommonClassModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<dynamic> data;
  String message;
  bool status;

  factory CommonClassModel.fromJson(Map<String, dynamic> json) => CommonClassModel(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
    "status": status,
  };
}
