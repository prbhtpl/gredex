// To parse this JSON data, do
//
//     final p2PRequestListModel = p2PRequestListModelFromJson(jsonString);

import 'dart:convert';

P2PRequestListModel p2PRequestListModelFromJson(String str) => P2PRequestListModel.fromJson(json.decode(str));

String p2PRequestListModelToJson(P2PRequestListModel data) => json.encode(data.toJson());

class P2PRequestListModel {
  List<Datum> data;
  String message;
  bool status;

  P2PRequestListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory P2PRequestListModel.fromJson(Map<String, dynamic> json) => P2PRequestListModel(
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
  String userId;
  dynamic totalamount;
  dynamic totalgdxamount;
  dynamic totalusdamount;
  dynamic balanceamount;
  dynamic balancegdxamount;
  dynamic balanceusdamount;
  dynamic userRate;
  String userRateType;
  dynamic status;
  String walletType;
  String createdAt;
  String updatedAt;
  int v;
  String userName;

  ListElement({
    required this.id,
    required this.userId,
    required this.totalamount,
    required this.totalgdxamount,
    required this.totalusdamount,
    required this.balanceamount,
    required this.balancegdxamount,
    required this.balanceusdamount,
    required this.userRate,
    required this.userRateType,
    required this.status,
    required this.walletType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.userName,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    userId: json["userId"],
    totalamount: json["totalamount"],
    totalgdxamount: json["totalgdxamount"],
    totalusdamount: json["totalusdamount"],
    balanceamount: json["balanceamount"],
    balancegdxamount: json["balancegdxamount"],
    balanceusdamount: json["balanceusdamount"],
    userRate: json["userRate"],
    userRateType: json["userRateType"],
    status: json["status"],
    walletType: json["walletType"],
    createdAt:json["created_at"],
    updatedAt: json["updated_at"],
    v: json["__v"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "totalamount": totalamount,
    "totalgdxamount": totalgdxamount,
    "totalusdamount": totalusdamount,
    "balanceamount": balanceamount,
    "balancegdxamount": balancegdxamount,
    "balanceusdamount": balanceusdamount,
    "userRate": userRate,
    "userRateType": userRateType,
    "status": status,
    "walletType": walletType,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
    "userName": userName,
  };
}
