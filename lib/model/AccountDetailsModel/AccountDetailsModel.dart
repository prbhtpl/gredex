// To parse this JSON data, do
//
//     final accountDetailsModel = accountDetailsModelFromJson(jsonString);

import 'dart:convert';

AccountDetailsModel accountDetailsModelFromJson(String str) => AccountDetailsModel.fromJson(json.decode(str));

String accountDetailsModelToJson(AccountDetailsModel data) => json.encode(data.toJson());

class AccountDetailsModel {
  Data data;
  String message;
  bool status;

  AccountDetailsModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) => AccountDetailsModel(
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
  String id;
  String userId;
  String upi;
  dynamic accountNo;
  dynamic accountHolderName;
  dynamic ifscCode;
  String type;
  String mobile;
  int status;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  dynamic trc20;
  int v;

  Data({
    required this.id,
    required this.userId,
    required this.upi,
    this.accountNo,
    this.accountHolderName,
    this.ifscCode,
    required this.type,
    required this.mobile,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.trc20,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userId: json["userId"],
    upi: json["upi"],
    accountNo: json["accountNo"],
    accountHolderName: json["accountHolderName"],
    ifscCode: json["ifscCode"],
    type: json["type"],
    mobile: json["mobile"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt:  json["created_at"],
    updatedAt:  json["updated_at"],
    trc20:  json["trc20"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "upi": upi,
    "accountNo": accountNo,
    "accountHolderName": accountHolderName,
    "ifscCode": ifscCode,
    "type": type,
    "mobile": mobile,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "trc20": trc20,
    "__v": v,
  };
}
