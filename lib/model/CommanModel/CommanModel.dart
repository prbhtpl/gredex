// To parse this JSON data, do
//
//     final commonModel = commonModelFromJson(jsonString);

import 'dart:convert';

CommonModel commonModelFromJson(String str) => CommonModel.fromJson(json.decode(str));

String commonModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  List<dynamic> data;
  String message;
  bool status;

  CommonModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
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
