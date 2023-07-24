// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  List<Datum> data;
  String message;
  bool status;

  BannerModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
  String image;
  int status;
  String addedBy;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.image,
    required this.status,
    required this.addedBy,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    image: json["image"],
    status: json["status"],
    addedBy: json["addedBy"],
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "status": status,
    "addedBy": addedBy,
    "deleted_at": deletedAt?.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
