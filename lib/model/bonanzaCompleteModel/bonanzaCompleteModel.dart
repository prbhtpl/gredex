// To parse this JSON data, do
//
//     final bonanzaCompleteModel = bonanzaCompleteModelFromJson(jsonString);

import 'dart:convert';

BonanzaCompleteModel bonanzaCompleteModelFromJson(String str) => BonanzaCompleteModel.fromJson(json.decode(str));

String bonanzaCompleteModelToJson(BonanzaCompleteModel data) => json.encode(data.toJson());

class BonanzaCompleteModel {
  List<Datum> data;
  String message;
  bool status;

  BonanzaCompleteModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BonanzaCompleteModel.fromJson(Map<String, dynamic> json) => BonanzaCompleteModel(
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
  String userId;
  String name;
  int direct;
  int business;
  String offer;
  String from;
  String to;
  int status;

  Datum({
    required this.id,
    required this.userId,
    required this.name,
    required this.direct,
    required this.business,
    required this.offer,
    required this.from,
    required this.to,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    direct: json["direct"],
    business: json["business"],
    offer: json["offer"],
    from: json["from"],
    to: json["to"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "direct": direct,
    "business": business,
    "offer": offer,
    "from": from,
    "to": to,
    "status": status,
  };
}
