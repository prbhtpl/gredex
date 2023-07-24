// To parse this JSON data, do
//
//     final binaryTreeRightModel = binaryTreeRightModelFromJson(jsonString);

import 'dart:convert';

BinaryTreeRightModel binaryTreeRightModelFromJson(String str) => BinaryTreeRightModel.fromJson(json.decode(str));

String binaryTreeRightModelToJson(BinaryTreeRightModel data) => json.encode(data.toJson());

class BinaryTreeRightModel {
  List<RightTree> data;
  String message;
  bool status;

  BinaryTreeRightModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BinaryTreeRightModel.fromJson(Map<String, dynamic> json) => BinaryTreeRightModel(
    data: List<RightTree>.from(json["data"].map((x) => RightTree.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class RightTree {
  String id;
  String name;
  String username;
  String email;
  int activMember;
  String position;
  bool gdxAddressChangeStatus;

  RightTree({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.activMember,
    required this.position,
    required this.gdxAddressChangeStatus,
  });

  factory RightTree.fromJson(Map<String, dynamic> json) => RightTree(
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
