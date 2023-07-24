// To parse this JSON data, do
//
//     final beptokenbalCheckModel = beptokenbalCheckModelFromJson(jsonString);

import 'dart:convert';

BeptokenbalCheckModel beptokenbalCheckModelFromJson(String str) => BeptokenbalCheckModel.fromJson(json.decode(str));

String beptokenbalCheckModelToJson(BeptokenbalCheckModel data) => json.encode(data.toJson());

class BeptokenbalCheckModel {
  bool status;
  String message;
  Data data;

  BeptokenbalCheckModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BeptokenbalCheckModel.fromJson(Map<String, dynamic> json) => BeptokenbalCheckModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String address;
  String name;
  String symbol;
  dynamic decimals;
  dynamic balance;
  String bnbToken;

  Data({
    required this.address,
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.balance,
    required this.bnbToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    address: json["address"],
    name: json["name"],
    symbol: json["symbol"],
    decimals: json["decimals"],
    balance: json["balance"]?.toDouble(),
    bnbToken: json["BnbToken"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "name": name,
    "symbol": symbol,
    "decimals": decimals,
    "balance": balance,
    "BnbToken": bnbToken,
  };
}
