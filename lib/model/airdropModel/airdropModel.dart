// To parse this JSON data, do
//
//     final airDropModel = airDropModelFromJson(jsonString);

import 'dart:convert';

AirDropModel airDropModelFromJson(String str) => AirDropModel.fromJson(json.decode(str));

String airDropModelToJson(AirDropModel data) => json.encode(data.toJson());

class AirDropModel {
  AirDropModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<Datum> data;
  String message;
  bool status;

  factory AirDropModel.fromJson(Map<String, dynamic> json) => AirDropModel(
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
    required this.debitorusername,
    required this.debitorName,
    required this.amount,
    required this.createdAt,
  });

  String id;
  String debitorusername;
  String debitorName;
  int amount;
  String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    debitorusername: json["debitorusername"],
    debitorName: json["debitorName"],
    amount: json["amount"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "debitorusername": debitorusername,
    "debitorName": debitorName,
    "amount": amount,
    "created_at": createdAt,
  };
}
