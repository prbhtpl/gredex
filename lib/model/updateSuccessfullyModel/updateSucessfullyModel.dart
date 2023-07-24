// To parse this JSON data, do
//
//     final updatedSuccessfullyModel = updatedSuccessfullyModelFromJson(jsonString);

import 'dart:convert';

UpdatedSuccessfullyModel updatedSuccessfullyModelFromJson(String str) => UpdatedSuccessfullyModel.fromJson(json.decode(str));

String updatedSuccessfullyModelToJson(UpdatedSuccessfullyModel data) => json.encode(data.toJson());

class UpdatedSuccessfullyModel {
  UpdatedSuccessfullyModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory UpdatedSuccessfullyModel.fromJson(Map<String, dynamic> json) => UpdatedSuccessfullyModel(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
