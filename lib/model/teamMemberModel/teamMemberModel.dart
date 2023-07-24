// To parse this JSON data, do
//
//     final teamMemberModel = teamMemberModelFromJson(jsonString);

import 'dart:convert';

TeamMemberModel teamMemberModelFromJson(String str) => TeamMemberModel.fromJson(json.decode(str));

String teamMemberModelToJson(TeamMemberModel data) => json.encode(data.toJson());

class TeamMemberModel {
  TeamMemberModel({
    required this.data,
    required this.message,
    required this.status,
    required this.totalBusiness,
  });

  List<TeamMemberList> data;
  String message;
  bool status;
  int totalBusiness;

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) => TeamMemberModel(
    data: List<TeamMemberList>.from(json["data"].map((x) => TeamMemberList.fromJson(x))),
    message: json["message"],
    status: json["status"],
    totalBusiness: json["totalBusiness"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
    "totalBusiness": totalBusiness,
  };
}

class TeamMemberList {
  TeamMemberList({
    required this.id,
    required this.name,
    required this.username,
    required this.position,
    required this.activMember,
    required this.amount,
  });

  String id;
  String name;
  String username;
  String position;
  int activMember;
  Amount amount;

  factory TeamMemberList.fromJson(Map<String, dynamic> json) => TeamMemberList(
    id: json["_id"],
    name: json["name"],
    username: json["username"],
    position: json["position"],
    activMember: json["activ_member"],
    amount: Amount.fromJson(json["amount"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "username": username,
    "position": position,
    "activ_member": activMember,
    "amount": amount.toJson(),
  };
}

class Amount {
  Amount({
    required this.totalamount,
    required this.createdAt,
  });

  int totalamount;
  String createdAt;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    totalamount: json["totalamount"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "totalamount": totalamount,
    "created_at": createdAt,
  };
}
