// To parse this JSON data, do
//
//     final binaryTreeModel = binaryTreeModelFromJson(jsonString);

import 'dart:convert';

BinaryTreeModel binaryTreeModelFromJson(String str) => BinaryTreeModel.fromJson(json.decode(str));

String binaryTreeModelToJson(BinaryTreeModel data) => json.encode(data.toJson());

class BinaryTreeModel {
  List<Datum> data;
  String message;
  bool status;

  BinaryTreeModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BinaryTreeModel.fromJson(Map<String, dynamic> json) => BinaryTreeModel(
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
  String name;
  String username;
  String email;
  int activMember;
  String position;
  bool gdxAddressChangeStatus;

  Datum({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.activMember,
    required this.position,
    required this.gdxAddressChangeStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    activMember: json["activ_member"],
    position: json["position"],
    gdxAddressChangeStatus: json["gdxAddressChangeStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "username": username,
    "email": email,
    "activ_member": activMember,
    "position": position,
    "gdxAddressChangeStatus": gdxAddressChangeStatus,
  };
}
