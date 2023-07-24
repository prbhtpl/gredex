// To parse this JSON data, do
//
//     final forgetPasswordSuccesfullModel = forgetPasswordSuccesfullModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordSuccesfullModel forgetPasswordSuccesfullModelFromJson(String str) => ForgetPasswordSuccesfullModel.fromJson(json.decode(str));

String forgetPasswordSuccesfullModelToJson(ForgetPasswordSuccesfullModel data) => json.encode(data.toJson());

class ForgetPasswordSuccesfullModel {
  List<dynamic> data;
  String message;
  bool status;

  ForgetPasswordSuccesfullModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ForgetPasswordSuccesfullModel.fromJson(Map<String, dynamic> json) => ForgetPasswordSuccesfullModel(
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
