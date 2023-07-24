// To parse this JSON data, do
//
//     final gdxLiveRateModel = gdxLiveRateModelFromJson(jsonString);

import 'dart:convert';

GdxLiveRateModel gdxLiveRateModelFromJson(String str) => GdxLiveRateModel.fromJson(json.decode(str));

String gdxLiveRateModelToJson(GdxLiveRateModel data) => json.encode(data.toJson());

class GdxLiveRateModel {
  GdxLiveRateModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory GdxLiveRateModel.fromJson(Map<String, dynamic> json) => GdxLiveRateModel(
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
  Data({
    required this.id,
    required this.rate,
  });

  String id;
  double rate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    rate: json["rate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rate": rate,
  };
}
