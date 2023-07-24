// To parse this JSON data, do
//
//     final renewalModel = renewalModelFromJson(jsonString);

import 'dart:convert';

RenewalModel renewalModelFromJson(String str) => RenewalModel.fromJson(json.decode(str));

String renewalModelToJson(RenewalModel data) => json.encode(data.toJson());

class RenewalModel {
  List<Datum> data;
  String message;
  bool status;

  RenewalModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RenewalModel.fromJson(Map<String, dynamic> json) => RenewalModel(
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
  String id;
  int amount;
  String gdx;
  int status;
  String tokenType;
  String createdAt;

  Datum({
    required this.id,
    required this.amount,
    required this.gdx,
    required this.status,
    required this.tokenType,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    amount: json["amount"],
    gdx: json["gdx"],
    status: json["status"],
    tokenType: json["tokenType"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amount": amount,
    "gdx": gdx,
    "status": status,
    "tokenType": tokenType,
    "created_at": createdAt,
  };
}
