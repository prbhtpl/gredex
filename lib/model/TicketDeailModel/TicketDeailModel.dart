// To parse this JSON data, do
//
//     final ticketDeailModel = ticketDeailModelFromJson(jsonString);

import 'dart:convert';

TicketDeailModel ticketDeailModelFromJson(String str) => TicketDeailModel.fromJson(json.decode(str));

String ticketDeailModelToJson(TicketDeailModel data) => json.encode(data.toJson());

class TicketDeailModel {
  List<Datum> data;
  String message;
  bool status;

  TicketDeailModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory TicketDeailModel.fromJson(Map<String, dynamic> json) => TicketDeailModel(
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
  String userId;
  String subject;
  String optionalSubject;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  int v;
  String ticketId;
  List<TicketReply> ticketReplies;

  Datum({
    required this.id,
    required this.userId,
    required this.subject,
    required this.optionalSubject,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.ticketId,
    required this.ticketReplies,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    subject: json["subject"],
    optionalSubject: json["optionalSubject"],
    description: json["description"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    v: json["__v"],
    ticketId: json["ticketId"],
    ticketReplies: List<TicketReply>.from(json["ticketReplies"].map((x) => TicketReply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "subject": subject,
    "optionalSubject": optionalSubject,
    "description": description,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
    "ticketId": ticketId,
    "ticketReplies": List<dynamic>.from(ticketReplies.map((x) => x.toJson())),
  };
}

class TicketReply {
  String id;
  String ticketId;
  String userId;
  String replyFrom;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  int v;

  TicketReply({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.replyFrom,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TicketReply.fromJson(Map<String, dynamic> json) => TicketReply(
    id: json["_id"],
    ticketId: json["ticketId"],
    userId: json["userId"],
    replyFrom: json["replyFrom"],
    description: json["description"],
    status: json["status"],
    createdAt:  json["created_at"] ,
    updatedAt:  json["updated_at"] ,
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "ticketId": ticketId,
    "userId": userId,
    "replyFrom": replyFrom,
    "description": description,
    "status": status,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "__v": v,
  };
}
