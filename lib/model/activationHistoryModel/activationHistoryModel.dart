// To parse this JSON data, do
//
//     final aCtivationHistoryModel = aCtivationHistoryModelFromJson(jsonString);

import 'dart:convert';

ACtivationHistoryModel aCtivationHistoryModelFromJson(String str) => ACtivationHistoryModel.fromJson(json.decode(str));

String aCtivationHistoryModelToJson(ACtivationHistoryModel data) => json.encode(data.toJson());

class ACtivationHistoryModel {
  ACtivationHistoryModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<Datum> data;
  String message;
  bool status;

  factory ACtivationHistoryModel.fromJson(Map<String, dynamic> json) => ACtivationHistoryModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.transactionId,
    required this.gdxamount,
    required this.usdamount,
    required this.status,
    required this.name,
    required this.username,
    required this.createdAt,
  });

  String id;
  String transactionId;
  double gdxamount;
  int usdamount;
  int status;
  String name;
  String username;
  String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    transactionId: json["transactionId"],
    gdxamount: json["gdxamount"]?.toDouble(),
    usdamount: json["usdamount"],
    status: json["status"],
    name: json["name"],
    username: json["username"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "transactionId": transactionId,
    "gdxamount": gdxamount,
    "usdamount": usdamount,
    "status": status,
    "name": name,
    "username": username,
    "created_at": createdAt,
  };
}
