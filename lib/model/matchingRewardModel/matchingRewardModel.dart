// To parse this JSON data, do
//
//     final matchingRewardModel = matchingRewardModelFromJson(jsonString);

import 'dart:convert';

MatchingRewardModel matchingRewardModelFromJson(String str) => MatchingRewardModel.fromJson(json.decode(str));

String matchingRewardModelToJson(MatchingRewardModel data) => json.encode(data.toJson());

class MatchingRewardModel {
  List<Datum> data;
  String message;
  bool status;

  MatchingRewardModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory MatchingRewardModel.fromJson(Map<String, dynamic> json) => MatchingRewardModel(
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
  double amount;
  int leftBusiness;
  int rightBusiness;
  int matching;
  String createdAt;

  Datum({
    required this.id,
    required this.amount,
    required this.leftBusiness,
    required this.rightBusiness,
    required this.matching,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    amount: json["amount"]?.toDouble(),
    leftBusiness: json["left_business"],
    rightBusiness: json["right_business"],
    matching: json["matching"],
    createdAt:  json["created_at"] ,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amount": amount,
    "left_business": leftBusiness,
    "right_business": rightBusiness,
    "matching": matching,
    "created_at": createdAt ,
  };
}
