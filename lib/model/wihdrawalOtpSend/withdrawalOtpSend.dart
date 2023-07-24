// To parse this JSON data, do
//
//     final withdrawalModelOtpSend = withdrawalModelOtpSendFromJson(jsonString);

import 'dart:convert';

WithdrawalModelOtpSend withdrawalModelOtpSendFromJson(String str) => WithdrawalModelOtpSend.fromJson(json.decode(str));

String withdrawalModelOtpSendToJson(WithdrawalModelOtpSend data) => json.encode(data.toJson());

class WithdrawalModelOtpSend {
  Data data;
  String message;
  bool status;

  WithdrawalModelOtpSend({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WithdrawalModelOtpSend.fromJson(Map<String, dynamic> json) => WithdrawalModelOtpSend(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
