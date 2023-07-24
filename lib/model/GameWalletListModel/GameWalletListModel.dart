// To parse this JSON data, do
//
//     final gameWalletListModel = gameWalletListModelFromJson(jsonString);

import 'dart:convert';

GameWalletListModel gameWalletListModelFromJson(String str) => GameWalletListModel.fromJson(json.decode(str));

String gameWalletListModelToJson(GameWalletListModel data) => json.encode(data.toJson());

class GameWalletListModel {
  List<Datum> data;
  String message;
  bool status;

  GameWalletListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GameWalletListModel.fromJson(Map<String, dynamic> json) => GameWalletListModel(
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
  double usdAmount;
  dynamic gdxAmount;
  String amountType;
  int status;
  String createdAt;

  Datum({
    required this.id,
    required this.usdAmount,
    required this.gdxAmount,
    required this.amountType,
    required this.status,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    usdAmount: json["usdAmount"]?.toDouble(),
    gdxAmount: json["gdxAmount"],
    amountType: json["amountType"],
    status: json["status"],
    createdAt:  json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "usdAmount": usdAmount,
    "gdxAmount": gdxAmount,
    "amountType": amountType,
    "status": status,
    "created_at": createdAt ,
  };
}
