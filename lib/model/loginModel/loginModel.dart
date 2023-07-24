// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  Data data;
  String message;
  bool status;

  LoginModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String id;
  String name;
  String username;
  String email;
  dynamic mobile;
  String parentId;
  String sponsor;
  dynamic wallet;
  dynamic externalWallet;
  dynamic externalGdxWallet;
  dynamic internalGdxWallet;
  dynamic internalWallet;
  dynamic directWallet;
  dynamic binaryWallet;
  dynamic roiWallet;
  dynamic shibaWallet;
  dynamic babyDogeWallet;
  dynamic gridxWallet;
  dynamic withdrawalAmount;
  String position;
  String password;
  List<String> tokens;
  String otp;
  dynamic ev;
  dynamic sv;
  dynamic status;
  dynamic renewalStatus;
  dynamic activMember;
  dynamic otpTime;
  String createdAt;
  String updatedAt;
  dynamic v;
  dynamic nameChangeStatus;

  Data({
    required this.id,
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
    required this.internalWallet,
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.nameChangeStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    parentId: json["parentId"],
    sponsor: json["sponsor"],
    wallet: json["wallet"]?.toDouble(),
    externalWallet: json["externalWallet"],
    externalGdxWallet: json["externalGDXWallet"]?.toDouble(),
    internalGdxWallet: json["internalGDXWallet"],
    internalWallet: json["internalWallet"]?.toDouble(),
    directWallet: json["directWallet"],
    binaryWallet: json["binaryWallet"]?.toDouble(),
    roiWallet: json["roiWallet"],
    shibaWallet: json["shibaWallet"],
    babyDogeWallet: json["babyDogeWallet"],
    gridxWallet: json["gridxWallet"],
    withdrawalAmount: json["withdrawalAmount"],
    position: json["position"],
    password: json["password"],
    tokens: List<String>.from(json["tokens"].map((x) => x)),
    otp: json["otp"]??"",
    ev: json["ev"],
    sv: json["sv"],
    status: json["status"],
    renewalStatus: json["renewalStatus"],
    activMember: json["activ_member"],
    otpTime: json["otp_time"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    v: json["__v"],
    nameChangeStatus: json["nameChangeStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
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
    "internalWallet": internalWallet,
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
    "otp_time": otpTime,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
    "nameChangeStatus": nameChangeStatus,
  };
}
