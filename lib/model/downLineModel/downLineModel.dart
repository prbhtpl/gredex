// To parse this JSON data, do
//
//     final dwonLineModel = dwonLineModelFromJson(jsonString);

import 'dart:convert';

DwonLineModel dwonLineModelFromJson(String str) => DwonLineModel.fromJson(json.decode(str));

String dwonLineModelToJson(DwonLineModel data) => json.encode(data.toJson());

class DwonLineModel {
  Data data;
  String message;
  bool status;

  DwonLineModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory DwonLineModel.fromJson(Map<String, dynamic> json) => DwonLineModel(
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
  List<Mydownline> mydownline;
  int totalBusiness;

  Data({
    required this.mydownline,
    required this.totalBusiness,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mydownline: List<Mydownline>.from(json["mydownline"].map((x) => Mydownline.fromJson(x))),
    totalBusiness: json["totalBusiness"],
  );

  Map<String, dynamic> toJson() => {
    "mydownline": List<dynamic>.from(mydownline.map((x) => x.toJson())),
    "totalBusiness": totalBusiness,
  };
}

class Mydownline {
  dynamic id;
  dynamic username;
  dynamic name;
  dynamic position;
  dynamic createdAt;
  dynamic status;
  dynamic activationAmount;
  dynamic activationDate;
  dynamic verifiedStatus;
  dynamic designation;

  Mydownline({
    required this.id,
    required this.username,
    required this.name,
    required this.position,
    required this.createdAt,
    required this.status,
    required this.activationAmount,
    required this.activationDate,
    required this.verifiedStatus,
    required this.designation,
  });

  factory Mydownline.fromJson(Map<String, dynamic> json) => Mydownline(
    id: json["_id"],
    username: json["username"],
    name: json["name"],
    position: json["position"],
    createdAt: json["created_at"],
    status: json["status"],
    activationAmount: json["activationAmount"],
    activationDate: json["activationDate"],
    verifiedStatus: json["verifiedStatus"],
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "name": name,
    "position": position,
    "created_at": createdAt,
    "status": status,
    "activationAmount": activationAmount,
    "activationDate": activationDate,
    "verifiedStatus": verifiedStatus,
    "designation": designation,
  };
}
