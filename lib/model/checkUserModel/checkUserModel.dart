// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'dart:convert';

CheckUserModel checkUserModelFromJson(String str) => CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
  CheckUserModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
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
    required this.name,
    required this.username,
    required this.activationStatus,
  });

  String name;
  String username;
  int activationStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    username: json["username"],
    activationStatus: json["activationStatus"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "activationStatus": activationStatus,
  };
}
