// To parse this JSON data, do
//
//     final directRewardModel = directRewardModelFromJson(jsonString);

import 'dart:convert';

DirectRewardModel directRewardModelFromJson(String str) => DirectRewardModel.fromJson(json.decode(str));

String directRewardModelToJson(DirectRewardModel data) => json.encode(data.toJson());

class DirectRewardModel {
  DirectRewardModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<DirectRewardList> data;
  String message;
  bool status;

  factory DirectRewardModel.fromJson(Map<String, dynamic> json) => DirectRewardModel(
    data: List<DirectRewardList>.from(json["data"].map((x) => DirectRewardList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class DirectRewardList {
  DirectRewardList({
    required this.id,
    required this.debitorusername,
    required this.debitorName,
    required this.amount,
    required this.business,
    required this.createdAt,
  });

  String id;
  String debitorusername;
  String debitorName;
  double amount;
  int business;
  String createdAt;

  factory DirectRewardList.fromJson(Map<String, dynamic> json) => DirectRewardList(
    id: json["_id"],
    debitorusername: json["debitorusername"],
    debitorName: json["debitorName"],
    amount: json["amount"]?.toDouble(),
    business: json["business"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "debitorusername": debitorusername,
    "debitorName": debitorName,
    "amount": amount,
    "business": business,
    "created_at": createdAt,
  };
}
