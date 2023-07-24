// To parse this JSON data, do
//
//     final withdrawalReportModel = withdrawalReportModelFromJson(jsonString);

import 'dart:convert';

WithdrawalReportModel withdrawalReportModelFromJson(String str) => WithdrawalReportModel.fromJson(json.decode(str));

String withdrawalReportModelToJson(WithdrawalReportModel data) => json.encode(data.toJson());

class WithdrawalReportModel {
  List<WithdrawalList> data;
  String message;
  bool status;

  WithdrawalReportModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WithdrawalReportModel.fromJson(Map<String, dynamic> json) => WithdrawalReportModel(
    data: List<WithdrawalList>.from(json["data"].map((x) => WithdrawalList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class WithdrawalList {
  String id;
  dynamic usdAmount;
  dynamic gdxAmount;
  dynamic amountType;
  dynamic withdrawalAmount;
  dynamic tnx;
  int status;
  dynamic createdAt;

  WithdrawalList({
    required this.id,
    required this.usdAmount,
    required this.gdxAmount,
    required this.amountType,
    required this.withdrawalAmount,
    required this.tnx,
    required this.status,
    required this.createdAt,
  });

  factory WithdrawalList.fromJson(Map<String, dynamic> json) => WithdrawalList(
    id: json["_id"],
    usdAmount: json["usdAmount"]?.toDouble(),
    gdxAmount: json["gdxAmount"]?.toDouble(),
    amountType: json["amountType"],
    withdrawalAmount: json["withdrawalAmount"],
    tnx: json["tnx"]?.toDouble(),
    status: json["status"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "usdAmount": usdAmount,
    "gdxAmount": gdxAmount,
    "amountType": amountType,
    "withdrawalAmount": withdrawalAmount,
    "tnx": tnx,
    "status": status,
    "created_at": createdAt,
  };
}
