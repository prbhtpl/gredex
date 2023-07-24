// To parse this JSON data, do
//
//     final allLevelrightMemberModel = allLevelrightMemberModelFromJson(jsonString);

import 'dart:convert';

AllLevelrightMemberModel allLevelrightMemberModelFromJson(String str) => AllLevelrightMemberModel.fromJson(json.decode(str));

String allLevelrightMemberModelToJson(AllLevelrightMemberModel data) => json.encode(data.toJson());

class AllLevelrightMemberModel {
  AllLevelrightMemberModel({
   required this.data,
   required this.message,
   required this.status,
  });

  Data data;
  String message;
  bool status;

  factory AllLevelrightMemberModel.fromJson(Map<String, dynamic> json) => AllLevelrightMemberModel(
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
 required  this.levelData,
 required  this.totalbusiness,
  });

  List<RightLevelDatum> levelData;
  String totalbusiness;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    levelData: List<RightLevelDatum>.from(json["levelData"].map((x) => RightLevelDatum.fromJson(x))),
    totalbusiness: json["totalbusiness"],
  );

  Map<String, dynamic> toJson() => {
    "levelData": List<dynamic>.from(levelData.map((x) => x.toJson())),
    "totalbusiness": totalbusiness,
  };
}

class RightLevelDatum {
  RightLevelDatum({
  required this.id,
  required this.name,
  required this.username,
  required this.status,
  required this.createdAt,
  required this.business,
  });

  String id;
  String name;
  String username;
  int status;
  String createdAt;
  String business;

  factory RightLevelDatum.fromJson(Map<String, dynamic> json) => RightLevelDatum(
    id: json["_id"],
    name: json["name"],
    username: json["username"],
    status: json["status"],
    createdAt: json["created_at"],
    business: json["business"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "username": username,
    "status": status,
    "created_at": createdAt,
    "business": business,
  };
}
