// To parse this JSON data, do
//
//     final addSupportTicketModel = addSupportTicketModelFromJson(jsonString);

import 'dart:convert';

AddSupportTicketModel addSupportTicketModelFromJson(String str) => AddSupportTicketModel.fromJson(json.decode(str));

String addSupportTicketModelToJson(AddSupportTicketModel data) => json.encode(data.toJson());

class AddSupportTicketModel {
  List<Datum> data;
  String message;
  bool status;

  AddSupportTicketModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory AddSupportTicketModel.fromJson(Map<String, dynamic> json) => AddSupportTicketModel(
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
  String userId;
  String subject;
  String optionalSubject;
  String description;
  int status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.userId,
    required this.subject,
    required this.optionalSubject,
    required this.description,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["userId"],
    subject: json["subject"],
    optionalSubject: json["optionalSubject"],
    description: json["description"],
    status: json["status"],
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "subject": subject,
    "optionalSubject": optionalSubject,
    "description": description,
    "status": status,
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
