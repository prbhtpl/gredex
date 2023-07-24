// To parse this JSON data, do
//
//     final bonanzaModel = bonanzaModelFromJson(jsonString);

import 'dart:convert';

BonanzaModel bonanzaModelFromJson(String str) => BonanzaModel.fromJson(json.decode(str));

String bonanzaModelToJson(BonanzaModel data) => json.encode(data.toJson());

class BonanzaModel {
  Data data;
  String message;
  bool status;

  BonanzaModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BonanzaModel.fromJson(Map<String, dynamic> json) => BonanzaModel(
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
  Dubai thiland;
  Dubai dubai;

  Data({
    required this.thiland,
    required this.dubai,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    thiland: Dubai.fromJson(json["thiland"]),
    dubai: Dubai.fromJson(json["dubai"]),
  );

  Map<String, dynamic> toJson() => {
    "thiland": thiland.toJson(),
    "dubai": dubai.toJson(),
  };
}

class Dubai {
  int directTarget;
  int directComplete;
  int businessTarget;
  int business;
  int status;

  Dubai({
    required this.directTarget,
    required this.directComplete,
    required this.businessTarget,
    required this.business,
    required this.status,
  });

  factory Dubai.fromJson(Map<String, dynamic> json) => Dubai(
    directTarget: json["directTarget"],
    directComplete: json["directComplete"],
    businessTarget: json["businessTarget"],
    business: json["business"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "directTarget": directTarget,
    "directComplete": directComplete,
    "businessTarget": businessTarget,
    "business": business,
    "status": status,
  };
}
