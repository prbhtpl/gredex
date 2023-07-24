// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  Data data;
  String message;
  bool status;

  ProfileModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  double wallet;
  dynamic directWallet;
  var binaryWallet;
  dynamic withdrawalAmount;
  dynamic withdrawalGDXAmount;
  dynamic externalWallet;
  dynamic internalWallet;
  dynamic internalGdxWallet;
  dynamic externalGdxWallet;
  dynamic roiWallet;
  dynamic shibawallet;
  dynamic babydogewallet;
  dynamic gridxwallet;
  dynamic activMember;
  String position;
  String address;
  dynamic nameChangeStatus;
  dynamic sv;
  dynamic ev;
  dynamic changeStatus;
  dynamic leftPv;
  dynamic rightPv;
  dynamic totalLeftPv;
  dynamic totalRightPv;
  dynamic uleftcount;
  dynamic urightcount;
  dynamic totalLeftcount;
  String sponsorName;
  String sponsorUsername;
  dynamic selfBusiness;
  dynamic directBusiness;
  dynamic directActiveMember;
  dynamic activationAmount;
  bool gdxAddressChangeStatus;
  String activationDate;
  int passwordStatus;
  String designation;
  String gamePassword;

  Data({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.mobile,
    required this.wallet,
    required this.directWallet,
    required this.binaryWallet,
    required this.withdrawalAmount,
  required this.withdrawalGDXAmount,
    required this.externalWallet,
    required this.internalWallet,
    required this.internalGdxWallet,
    required this.externalGdxWallet,
    required this.roiWallet,
    required this.shibawallet,
    required this.babydogewallet,
    required this.gridxwallet,
    required this.activMember,
    required this.position,
    required this.address,
    required this.nameChangeStatus,
    required this.sv,
    required this.ev,
    required this.changeStatus,
    required this.leftPv,
    required this.rightPv,
    required this.totalLeftPv,
    required this.totalRightPv,
    required this.uleftcount,
    required this.urightcount,
    required this.totalLeftcount,
    required this.sponsorName,
    required this.sponsorUsername,
    required this.selfBusiness,
    required this.directBusiness,
    required this.directActiveMember,
    required this.activationAmount,
    required this.gdxAddressChangeStatus,
    required this.activationDate,
    required this.passwordStatus,
    required this.designation,
    required this.gamePassword,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    wallet: json["wallet"]?.toDouble(),
    directWallet: json["directWallet"],
    binaryWallet: json["binaryWallet"],
    withdrawalAmount: json["withdrawalAmount"],
    withdrawalGDXAmount: json["withdrawalGDXAmount"],
    externalWallet: json["externalWallet"],
    internalWallet: json["internalWallet"]?.toDouble(),
    internalGdxWallet: json["internalGDXWallet"],
    externalGdxWallet: json["externalGDXWallet"],
    roiWallet: json["roiWallet"],
    shibawallet: json["shibawallet"],
    babydogewallet: json["babydogewallet"],
    gridxwallet: json["gridxwallet"],
    activMember: json["activ_member"],
    position: json["position"],
    address: json["address"],
    nameChangeStatus: json["nameChangeStatus"],
    sv: json["sv"],
    ev: json["ev"],
    changeStatus: json["changeStatus"],
    leftPv: json["left_pv"],
    rightPv: json["right_pv"],
    totalLeftPv: json["total_left_pv"],
    totalRightPv: json["total_right_pv"],
    uleftcount: json["uleftcount"],
    urightcount: json["urightcount"],
    totalLeftcount: json["total_leftcount"],
    sponsorName: json["sponsor_name"],
    sponsorUsername: json["sponsor_username"],
    selfBusiness: json["selfBusiness"],
    directBusiness: json["directBusiness"],
    directActiveMember: json["directActiveMember"],
    activationAmount: json["activationAmount"],
    gdxAddressChangeStatus: json["gdxAddressChangeStatus"],
    activationDate: json["activationDate"],
    passwordStatus: json["passwordStatus"],
    designation: json["designation"],
    gamePassword: json["gamepassword"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "username": username,
    "email": email,
    "mobile": mobile,
    "wallet": wallet,
    "directWallet": directWallet,
    "binaryWallet": binaryWallet,
    "withdrawalAmount": withdrawalAmount,
    "withdrawalGDXAmount": withdrawalGDXAmount,
    "externalWallet": externalWallet,
    "internalWallet": internalWallet,
    "internalGDXWallet": internalGdxWallet,
    "externalGDXWallet": externalGdxWallet,
    "roiWallet": roiWallet,
    "shibawallet": shibawallet,
    "babydogewallet": babydogewallet,
    "gridxwallet": gridxwallet,
    "activ_member": activMember,
    "position": position,
    "address": address,
    "nameChangeStatus": nameChangeStatus,
    "sv": sv,
    "ev": ev,
    "changeStatus": changeStatus,
    "left_pv": leftPv,
    "right_pv": rightPv,
    "total_left_pv": totalLeftPv,
    "total_right_pv": totalRightPv,
    "uleftcount": uleftcount,
    "urightcount": urightcount,
    "total_leftcount": totalLeftcount,
    "sponsor_name": sponsorName,
    "sponsor_username": sponsorUsername,
    "selfBusiness": selfBusiness,
    "directBusiness": directBusiness,
    "directActiveMember": directActiveMember,
    "activationAmount": activationAmount,
    "gdxAddressChangeStatus": gdxAddressChangeStatus,
    "activationDate": activationDate,
    "passwordStatus": passwordStatus,
    "designation": designation,
    "gamePassword": gamePassword,
  };
}
