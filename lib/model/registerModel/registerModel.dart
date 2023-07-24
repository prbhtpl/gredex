// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  bool status;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
    required this.name,
    required this.username,
    required this.email,
    required this.mobile,
    required this.parentId,
    required this.sponsor,
    required this.wallet,
    required this.externalWallet,
    required this.externalGdxWallet,
    required this.internalGdxWallet,
    required this.directWallet,
    required this.binaryWallet,
    required this.roiWallet,
    required this.shibaWallet,
    required this.babyDogeWallet,
    required this.gridxWallet,
    required this.withdrawalAmount,
    required this.position,
    required this.password,
    required this.tokens,
    required this.otp,
    required this.ev,
    required this.sv,
    required this.status,
    required this.renewalStatus,
    required this.activMember,
    required this.otpTime,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String name;
  String username;
  String email;
  dynamic mobile;
  String parentId;
  String sponsor;
  int wallet;
  int externalWallet;
  int externalGdxWallet;
  int internalGdxWallet;
  int directWallet;
  int binaryWallet;
  int roiWallet;
  int shibaWallet;
  int babyDogeWallet;
  int gridxWallet;
  int withdrawalAmount;
  String position;
  String password;
  List<String> tokens;
  String otp;
  int ev;
  int sv;
  int status;
  int renewalStatus;
  int activMember;
  DateTime otpTime;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    parentId: json["parentId"],
    sponsor: json["sponsor"],
    wallet: json["wallet"],
    externalWallet: json["externalWallet"],
    externalGdxWallet: json["externalGDXWallet"],
    internalGdxWallet: json["internalGDXWallet"],
    directWallet: json["directWallet"],
    binaryWallet: json["binaryWallet"],
    roiWallet: json["roiWallet"],
    shibaWallet: json["shibaWallet"],
    babyDogeWallet: json["babyDogeWallet"],
    gridxWallet: json["gridxWallet"],
    withdrawalAmount: json["withdrawalAmount"],
    position: json["position"],
    password: json["password"],
    tokens: List<String>.from(json["tokens"].map((x) => x)),
    otp: json["otp"],
    ev: json["ev"],
    sv: json["sv"],
    status: json["status"],
    renewalStatus: json["renewalStatus"],
    activMember: json["activ_member"],
    otpTime: DateTime.parse(json["otp_time"]),
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "email": email,
    "mobile": mobile,
    "parentId": parentId,
    "sponsor": sponsor,
    "wallet": wallet,
    "externalWallet": externalWallet,
    "externalGDXWallet": externalGdxWallet,
    "internalGDXWallet": internalGdxWallet,
    "directWallet": directWallet,
    "binaryWallet": binaryWallet,
    "roiWallet": roiWallet,
    "shibaWallet": shibaWallet,
    "babyDogeWallet": babyDogeWallet,
    "gridxWallet": gridxWallet,
    "withdrawalAmount": withdrawalAmount,
    "position": position,
    "password": password,
    "tokens": List<dynamic>.from(tokens.map((x) => x)),
    "otp": otp,
    "ev": ev,
    "sv": sv,
    "status": status,
    "renewalStatus": renewalStatus,
    "activ_member": activMember,
    "otp_time": otpTime.toIso8601String(),
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
