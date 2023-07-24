// To parse this JSON data, do
//
//     final binaryError = binaryErrorFromJson(jsonString);

import 'dart:convert';

BinaryError binaryErrorFromJson(String str) => BinaryError.fromJson(json.decode(str));

String binaryErrorToJson(BinaryError data) => json.encode(data.toJson());

class BinaryError {
  BinaryError({
    required this.data,
    required this.message,
    required this.status,
  });

  List<dynamic> data;
  String message;
  bool status;

  factory BinaryError.fromJson(Map<String, dynamic> json) => BinaryError(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
    "status": status,
  };
}
