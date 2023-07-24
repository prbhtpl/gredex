// To parse this JSON data, do
//
//     final allLevelMemberModel = allLevelMemberModelFromJson(jsonString);

import 'dart:convert';

AllLevelMemberModel allLevelMemberModelFromJson(String str) => AllLevelMemberModel.fromJson(json.decode(str));

String allLevelMemberModelToJson(AllLevelMemberModel data) => json.encode(data.toJson());

class AllLevelMemberModel {
  AllLevelMemberModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory AllLevelMemberModel.fromJson(Map<String, dynamic> json) => AllLevelMemberModel(
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
    required this.levelData,
    required this.totalbusiness,
  });

  List<LevelDatum> levelData;
  String totalbusiness;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    levelData: List<LevelDatum>.from(json["levelData"].map((x) => LevelDatum.fromJson(x))),
    totalbusiness: json["totalbusiness"],
  );

  Map<String, dynamic> toJson() => {
    "levelData": List<dynamic>.from(levelData.map((x) => x.toJson())),
    "totalbusiness": totalbusiness,
  };
}

class LevelDatum {
  LevelDatum({
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

  factory LevelDatum.fromJson(Map<String, dynamic> json) => LevelDatum(
    id: json["_id"],
    name: json["name"],
    username: json["username"],
    status: json["status"],
    createdAt:  json["created_at"] ,
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
