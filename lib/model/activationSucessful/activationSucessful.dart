// To parse this JSON data, do
//
//     final activationSucessfulModel = activationSucessfulModelFromJson(jsonString);

import 'dart:convert';

ActivationSucessfulModel activationSucessfulModelFromJson(String str) => ActivationSucessfulModel.fromJson(json.decode(str));

String activationSucessfulModelToJson(ActivationSucessfulModel data) => json.encode(data.toJson());

class ActivationSucessfulModel {
  Data data;
  String message;
  bool status;

  ActivationSucessfulModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ActivationSucessfulModel.fromJson(Map<String, dynamic> json) => ActivationSucessfulModel(
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
  String activationId;
  String walletType;
  int usdamount;
  double gdxamount;

  Data({
    required this.activationId,
    required this.walletType,
    required this.usdamount,
    required this.gdxamount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    activationId: json["activationId"],
    walletType: json["walletType"],
    usdamount: json["usdamount"],
    gdxamount: json["gdxamount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "activationId": activationId,
    "walletType": walletType,
    "usdamount": usdamount,
    "gdxamount": gdxamount,
  };
}
