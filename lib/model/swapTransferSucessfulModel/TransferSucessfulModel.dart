// To parse this JSON data, do
//
//     final swapTransferSuccessfulModel = swapTransferSuccessfulModelFromJson(jsonString);

import 'dart:convert';

SwapTransferSuccessfulModel swapTransferSuccessfulModelFromJson(String str) => SwapTransferSuccessfulModel.fromJson(json.decode(str));

String swapTransferSuccessfulModelToJson(SwapTransferSuccessfulModel data) => json.encode(data.toJson());

class SwapTransferSuccessfulModel {
  Data data;
  String message;
  bool status;

  SwapTransferSuccessfulModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SwapTransferSuccessfulModel.fromJson(Map<String, dynamic> json) => SwapTransferSuccessfulModel(
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
