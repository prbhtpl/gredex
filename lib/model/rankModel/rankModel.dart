// To parse this JSON data, do
//
//     final rankModel = rankModelFromJson(jsonString);

import 'dart:convert';

RankModel rankModelFromJson(String str) => RankModel.fromJson(json.decode(str));

String rankModelToJson(RankModel data) => json.encode(data.toJson());

class RankModel {
  List<Datum> data;
  String message;
  bool status;

  RankModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RankModel.fromJson(Map<String, dynamic> json) => RankModel(
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
  int position;
  int? memberCount;
  int directBussiness;
  String offer;
  int days;
  int addedBy;
  int status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String rank;
  String recordId;
  String? userId;
  int? memberLeft;
  int? memberRight;
  DateTime? from;
  DateTime? to;
  DateTime? completedDate;
  String completedStatus;

  Datum({
    required this.id,
    required this.position,
    this.memberCount,
    required this.directBussiness,
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    position: json["position"],
    memberCount: json["memberCount"],
    directBussiness: json["directBussiness"],
    offer: json["offer"],
    days: json["days"],
    addedBy: json["added_by"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
    rank: json["rank"],
    recordId: json["recordId"],
    userId: json["userId"],
    memberLeft: json["memberLeft"],
    memberRight: json["memberRight"],
    from: json["from"] == null ? null : DateTime.parse(json["from"]),
    to: json["to"] == null ? null : DateTime.parse(json["to"]),
    completedDate: json["completedDate"] == null ? null : DateTime.parse(json["completedDate"]),
    completedStatus: json["completedStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "position": position,
    "memberCount": memberCount,
    "directBussiness": directBussiness,
    "offer": offer,
    "days": days,
    "added_by": addedBy,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
    "rank": rank,
    "recordId": recordId,
    "userId": userId,
    "memberLeft": memberLeft,
    "memberRight": memberRight,
    "from": from?.toIso8601String(),
    "to": to?.toIso8601String(),
    "completedDate": completedDate?.toIso8601String(),
    "completedStatus": completedStatus,
  };
}
