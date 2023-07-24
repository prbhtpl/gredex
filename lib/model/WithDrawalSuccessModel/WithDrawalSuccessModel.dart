// To parse this JSON data, do
//
//     final withdrawalSuccessModel = withdrawalSuccessModelFromJson(jsonString);

import 'dart:convert';

WithdrawalSuccessModel withdrawalSuccessModelFromJson(String str) => WithdrawalSuccessModel.fromJson(json.decode(str));

String withdrawalSuccessModelToJson(WithdrawalSuccessModel data) => json.encode(data.toJson());

class WithdrawalSuccessModel {
  Data data;
  String message;
  bool status;

  WithdrawalSuccessModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WithdrawalSuccessModel.fromJson(Map<String, dynamic> json) => WithdrawalSuccessModel(
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
  double amount;
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
    amount: json["amount"]?.toDouble(),
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "address": address,
    "amount": amount,
    "hash": hash,
  };
}
