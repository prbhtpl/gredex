// To parse this JSON data, do
//
//     final withdrawalVerify = withdrawalVerifyFromJson(jsonString);

import 'dart:convert';

WithdrawalVerify withdrawalVerifyFromJson(String str) => WithdrawalVerify.fromJson(json.decode(str));

String withdrawalVerifyToJson(WithdrawalVerify data) => json.encode(data.toJson());

class WithdrawalVerify {
  Data data;
  String message;
  bool status;

  WithdrawalVerify({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WithdrawalVerify.fromJson(Map<String, dynamic> json) => WithdrawalVerify(
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
  String creditedId;
  String debitedId;
  int amount;
  String walletType;

  Data({
    required this.creditedId,
    required this.debitedId,
    required this.amount,
    required this.walletType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    creditedId: json["creditedId"],
    debitedId: json["debitedId"],
    amount: json["amount"],
    walletType: json["walletType"],
  );

  Map<String, dynamic> toJson() => {
    "creditedId": creditedId,
    "debitedId": debitedId,
    "amount": amount,
    "walletType": walletType,
  };
}
