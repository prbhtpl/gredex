// To parse this JSON data, do
//
//     final binaryTreeLeftModel = binaryTreeLeftModelFromJson(jsonString);

import 'dart:convert';

BinaryTreeLeftModel binaryTreeLeftModelFromJson(String str) => BinaryTreeLeftModel.fromJson(json.decode(str));

String binaryTreeLeftModelToJson(BinaryTreeLeftModel data) => json.encode(data.toJson());

class BinaryTreeLeftModel {
  List<LeftTree> data;
  String message;
  bool status;

  BinaryTreeLeftModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BinaryTreeLeftModel.fromJson(Map<String, dynamic> json) => BinaryTreeLeftModel(
    data: List<LeftTree>.from(json["data"].map((x) => LeftTree.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class LeftTree {
  String id;
  String name;
  String username;
  String email;
  int activMember;
  String position;
  bool gdxAddressChangeStatus;

  LeftTree({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.activMember,
    required this.position,
    required this.gdxAddressChangeStatus,
  });

  factory LeftTree.fromJson(Map<String, dynamic> json) => LeftTree(
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
