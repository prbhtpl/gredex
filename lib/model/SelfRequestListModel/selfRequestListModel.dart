// To parse this JSON data, do
//
//     final selfRequestListModel = selfRequestListModelFromJson(jsonString);

import 'dart:convert';

SelfRequestListModel selfRequestListModelFromJson(String str) => SelfRequestListModel.fromJson(json.decode(str));

String selfRequestListModelToJson(SelfRequestListModel data) => json.encode(data.toJson());

class SelfRequestListModel {
  List<Datum> data;
  String message;
  bool status;

  SelfRequestListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SelfRequestListModel.fromJson(Map<String, dynamic> json) => SelfRequestListModel(
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
  String userName;
  String userId;
  dynamic transactionId;
  int otpStatus;
  String upi;
  dynamic accountNo;
  dynamic accountHolderName;
  dynamic ifscCode;
  String type;
  String mobile;
  dynamic price;

  ListElement({
    required this.id,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.userName,
    required this.userId,
    this.transactionId,
    required this.otpStatus,
    required this.upi,
    this.accountNo,
    this.accountHolderName,
    this.ifscCode,
    required this.type,
    required this.mobile,
    required this.price,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    amount: json["amount"],
    status: json["status"],
    createdAt:  json["created_at"],
    userName: json["userName"],
    userId: json["userId"],
    transactionId: json["transactionId"],
    otpStatus: json["otpStatus"],
    upi: json["upi"],
    accountNo: json["accountNo"],
    accountHolderName: json["accountHolderName"],
    ifscCode: json["ifscCode"],
    type: json["type"],
    mobile: json["mobile"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amount": amount,
    "status": status,
    "created_at": createdAt,
    "userName": userName,
    "userId": userId,
    "transactionId": transactionId,
    "otpStatus": otpStatus,
    "upi": upi,
    "accountNo": accountNo,
    "accountHolderName": accountHolderName,
    "ifscCode": ifscCode,
    "type": type,
    "mobile": mobile,
    "price": price,
  };
}
