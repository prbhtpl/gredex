// To parse this JSON data, do
//
//     final bonanzaNewModel = bonanzaNewModelFromJson(jsonString);

import 'dart:convert';

BonanzaNewModel bonanzaNewModelFromJson(String str) => BonanzaNewModel.fromJson(json.decode(str));

String bonanzaNewModelToJson(BonanzaNewModel data) => json.encode(data.toJson());

class BonanzaNewModel {
  List<BonanzaNewList> data;
  String message;
  bool status;

  BonanzaNewModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BonanzaNewModel.fromJson(Map<String, dynamic> json) => BonanzaNewModel(
    data: List<BonanzaNewList>.from(json["data"].map((x) => BonanzaNewList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class BonanzaNewList {
  String id;
  int position;
  int? memberCount;
  int? directBussiness;
  String offer;
  int days;
  int addedBy;
  int status;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  int v;
  String rank;
  String recordId;
  String? userId;
  int? memberLeft;
  int? memberRight;
  String? from;
  String? to;
  String? completedDate;
  String completedStatus;

  BonanzaNewList({
    required this.id,
    required this.position,
    this.memberCount,
    this.directBussiness,
    required this.offer,
    required this.days,
    required this.addedBy,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.rank,
    required this.recordId,
    this.userId,
    this.memberLeft,
    this.memberRight,
    this.from,
    this.to,
    this.completedDate,
    required this.completedStatus,
  });

  factory BonanzaNewList.fromJson(Map<String, dynamic> json) => BonanzaNewList(
    id: json["_id"],
    position: json["position"],
    memberCount: json["memberCount"],
    directBussiness: json["directBussiness"],
    offer: json["offer"],
    days: json["days"],
    addedBy: json["added_by"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    v: json["__v"],
    rank: json["rank"],
    recordId: json["recordId"],
    userId: json["userId"],
    memberLeft: json["memberLeft"],
    memberRight: json["memberRight"],
    from: json["from"] == null ? null : json["from"],
    to: json["to"] == null ? null : json["to"],
    completedDate: json["completedDate"] == null ? null :json["completedDate"],
    completedStatus: json["completedStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "position": position,
    "memberCount": memberCount,
    "directBusiness": directBussiness,
    "offer": offer,
    "days": days,
    "added_by": addedBy,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
    "rank": rank,
    "recordId": recordId,
    "userId": userId,
    "memberLeft": memberLeft,
    "memberRight": memberRight,
    "from": from,
    "to": to,
    "completedDate": completedDate,
    "completedStatus": completedStatus,
  };
}
