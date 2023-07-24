// To parse this JSON data, do
//
//     final supportTicketListModel = supportTicketListModelFromJson(jsonString);

import 'dart:convert';

SupportTicketListModel supportTicketListModelFromJson(String str) => SupportTicketListModel.fromJson(json.decode(str));

String supportTicketListModelToJson(SupportTicketListModel data) => json.encode(data.toJson());

class SupportTicketListModel {
  List<SupportTokenList> data;
  String message;
  bool status;

  SupportTicketListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SupportTicketListModel.fromJson(Map<String, dynamic> json) => SupportTicketListModel(
    data: List<SupportTokenList>.from(json["data"].map((x) => SupportTokenList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class SupportTokenList {
  List<ListElement> list;
  int count;

  SupportTokenList({
    required this.list,
    required this.count,
  });

  factory SupportTokenList.fromJson(Map<String, dynamic> json) => SupportTokenList(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "count": count,
  };
}

class ListElement {
  String id;
  String userId;
  String subject;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  int v;

  ListElement({
    required this.id,
    required this.userId,
    required this.subject,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    userId: json["userId"],
    subject: json["subject"],
    description: json["description"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt:  json["updated_at"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "subject": subject,
    "description": description,
    "status": status,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "__v": v,
  };
}
