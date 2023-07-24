// To parse this JSON data, do
//
//     final allLevelLeftMemberModel = allLevelLeftMemberModelFromJson(jsonString);

import 'dart:convert';

AllLevelLeftMemberModel allLevelLeftMemberModelFromJson(String str) => AllLevelLeftMemberModel.fromJson(json.decode(str));

String allLevelLeftMemberModelToJson(AllLevelLeftMemberModel data) => json.encode(data.toJson());

class AllLevelLeftMemberModel {
  AllLevelLeftMemberModel({
  required this.data,
  required this.message,
  required this.status,
  });

  Data data;
  String message;
  bool status;

  factory AllLevelLeftMemberModel.fromJson(Map<String, dynamic> json) => AllLevelLeftMemberModel(
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

  List<LeftLevelDatum> levelData;
  String totalbusiness;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    levelData: List<LeftLevelDatum>.from(json["levelData"].map((x) => LeftLevelDatum.fromJson(x))),
    totalbusiness: json["totalbusiness"],
  );

  Map<String, dynamic> toJson() => {
    "levelData": List<dynamic>.from(levelData.map((x) => x.toJson())),
    "totalbusiness": totalbusiness,
  };
}

class LeftLevelDatum {
  LeftLevelDatum({
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

  factory LeftLevelDatum.fromJson(Map<String, dynamic> json) => LeftLevelDatum(
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
