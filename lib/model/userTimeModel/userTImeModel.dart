// To parse this JSON data, do
//
//     final userTimeModel = userTimeModelFromJson(jsonString);

import 'dart:convert';

UserTimeModel userTimeModelFromJson(String str) => UserTimeModel.fromJson(json.decode(str));

String userTimeModelToJson(UserTimeModel data) => json.encode(data.toJson());

class UserTimeModel {
  Data data;
  String message;
  bool status;

  UserTimeModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory UserTimeModel.fromJson(Map<String, dynamic> json) => UserTimeModel(
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
  dynamic day;
  int dataStatus;

  Data({
    required this.day,
    required this.dataStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    day: json["day"],
    dataStatus: json["dataStatus"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "dataStatus": dataStatus,
  };
}
