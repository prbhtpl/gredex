// To parse this JSON data, do
//
//     final buyRequestListModel = buyRequestListModelFromJson(jsonString);

import 'dart:convert';

BuyRequestListModel buyRequestListModelFromJson(String str) => BuyRequestListModel.fromJson(json.decode(str));

String buyRequestListModelToJson(BuyRequestListModel data) => json.encode(data.toJson());

class BuyRequestListModel {
  List<Datum> data;
  String message;
  bool status;

  BuyRequestListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BuyRequestListModel.fromJson(Map<String, dynamic> json) => BuyRequestListModel(
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
  List<ListElement> list;
  int totalCount;

  Datum({
    required this.list,
    required this.totalCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class ListElement {
  String id;
  int amount;
  int status;
  String createdAt;
  int? otp;
  String? otpTime;
  String userName;
  String userId;
  dynamic transactionId;
  int? otpStatus;
  dynamic price;

  ListElement({
    required this.id,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.otp,
    this.otpTime,
    required this.userName,
    required this.userId,
    this.transactionId,
    this.otpStatus,
    this.price,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    amount: json["amount"],
    status: json["status"],
    createdAt:  json["created_at"],
    otp: json["otp"],
    otpTime: json["otp_time"] == null ? null : json["otp_time"],
    userName: json["userName"],
    userId: json["userId"],
    transactionId: json["transactionId"],
    otpStatus: json["otpStatus"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amount": amount,
    "status": status,
    "created_at": createdAt,
    "otp": otp,
    "otp_time": otpTime,
    "userName": userName,
    "userId": userId,
    "transactionId": transactionId,
    "otpStatus": otpStatus,
    "price": price,
  };
}
