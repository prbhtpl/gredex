// To parse this JSON data, do
//
//     final dashboardDataModel = dashboardDataModelFromJson(jsonString);

import 'dart:convert';

DashboardDataModel dashboardDataModelFromJson(String str) => DashboardDataModel.fromJson(json.decode(str));

String dashboardDataModelToJson(DashboardDataModel data) => json.encode(data.toJson());

class DashboardDataModel {
  DashboardDataModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) => DashboardDataModel(
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
  Data({
    required this.direcmemberprice,
    required this.selfbusinessprice,
    required this.allbusiness,
    required this.directtotal,
    required this.directactive,
    required this.allActivemember,
    required this.leftActivemember,
    required this.rightActivemember,
    required this.todayleftBusiness,
    required this.todayrightBusiness,
    required this.sponsorBusiness,
  });

  int direcmemberprice;
  int selfbusinessprice;
  Allbusiness allbusiness;
  int directtotal;
  int directactive;
  int allActivemember;
  int leftActivemember;
  int rightActivemember;
  int todayleftBusiness;
  int todayrightBusiness;
  int sponsorBusiness;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    direcmemberprice: json["direcmemberprice"],
    selfbusinessprice: json["selfbusinessprice"],
    allbusiness: Allbusiness.fromJson(json["allbusiness"]),
    directtotal: json["directtotal"],
    directactive: json["directactive"],
    allActivemember: json["allActivemember"],
    leftActivemember: json["leftActivemember"],
    rightActivemember: json["rightActivemember"],
    todayleftBusiness: json["todayleftBusiness"],
    todayrightBusiness: json["todayrightBusiness"],
    sponsorBusiness: json["sponsorBusiness"],
  );

  Map<String, dynamic> toJson() => {
    "direcmemberprice": direcmemberprice,
    "selfbusinessprice": selfbusinessprice,
    "allbusiness": allbusiness.toJson(),
    "directtotal": directtotal,
    "directactive": directactive,
    "allActivemember": allActivemember,
    "leftActivemember": leftActivemember,
    "rightActivemember": rightActivemember,
    "todayleftBusiness": todayleftBusiness,
    "todayrightBusiness": todayrightBusiness,
    "sponsorBusiness": sponsorBusiness,
  };
}

class Allbusiness {
  Allbusiness({
    required this.id,
    required this.uid,
    required this.uleftcount,
    required this.urightcount,
    required this.totalLeftcount,
    required this.totalRightcount,
    required this.leftPv,
    required this.rightPv,
    required this.totalLeftPv,
    required this.totalRightPv,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String uid;
  int uleftcount;
  int urightcount;
  int totalLeftcount;
  int totalRightcount;
  int leftPv;
  int rightPv;
  int totalLeftPv;
  int totalRightPv;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Allbusiness.fromJson(Map<String, dynamic> json) => Allbusiness(
    id: json["_id"],
    uid: json["uid"],
    uleftcount: json["uleftcount"],
    urightcount: json["urightcount"],
    totalLeftcount: json["total_leftcount"],
    totalRightcount: json["total_rightcount"],
    leftPv: json["left_pv"],
    rightPv: json["right_pv"],
    totalLeftPv: json["total_left_pv"],
    totalRightPv: json["total_right_pv"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "uid": uid,
    "uleftcount": uleftcount,
    "urightcount": urightcount,
    "total_leftcount": totalLeftcount,
    "total_rightcount": totalRightcount,
    "left_pv": leftPv,
    "right_pv": rightPv,
    "total_left_pv": totalLeftPv,
    "total_right_pv": totalRightPv,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
