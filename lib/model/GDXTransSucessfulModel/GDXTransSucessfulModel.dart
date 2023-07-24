// To parse this JSON data, do
//
//     final gdxTransSucessfulModel = gdxTransSucessfulModelFromJson(jsonString);

import 'dart:convert';

GdxTransSucessfulModel gdxTransSucessfulModelFromJson(String str) => GdxTransSucessfulModel.fromJson(json.decode(str));

String gdxTransSucessfulModelToJson(GdxTransSucessfulModel data) => json.encode(data.toJson());

class GdxTransSucessfulModel {
  Data data;
  String message;
  bool status;

  GdxTransSucessfulModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GdxTransSucessfulModel.fromJson(Map<String, dynamic> json) => GdxTransSucessfulModel(
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
  String username;
  String address;
  String amount;
  String hash;

  Data({
    required this.username,
    required this.address,
    required this.amount,
    required this.hash,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"],
    address: json["address"],
    amount: json["amount"],
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "address": address,
    "amount": amount,
    "hash": hash,
  };
}
