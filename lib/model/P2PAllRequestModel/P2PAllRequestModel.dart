// To parse this JSON data, do
//
//     final p2PAllRequestModel = p2PAllRequestModelFromJson(jsonString);

import 'dart:convert';

P2PAllRequestModel p2PAllRequestModelFromJson(String str) => P2PAllRequestModel.fromJson(json.decode(str));

String p2PAllRequestModelToJson(P2PAllRequestModel data) => json.encode(data.toJson());

class P2PAllRequestModel {
  Data data;
  String message;
  bool status;

  P2PAllRequestModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory P2PAllRequestModel.fromJson(Map<String, dynamic> json) => P2PAllRequestModel(
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
  List<ListElement> list;
  int totalCount;

  Data({
    required this.list,
    required this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
  int totalamount;
  dynamic totalgdxamount;
  dynamic totalusdamount;
  dynamic balanceamount;
  dynamic balancegdxamount;
  dynamic balanceusdamount;
  dynamic userRate;
  String userRateType;
  int status;
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
