import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/BuyRequestListModel/BuyRequestListModel.dart';
import '../../../model/CommanModel/CommanModel.dart';
import '../../../model/P2PAllRequestModel/P2PAllRequestModel.dart';
import '../../../model/SelfRequestListModel/selfRequestListModel.dart';
import '../../../model/convertedAmountModel/convertedAmountModel.dart';
import '../../../model/swapTransferSucessfulModel/TransferSucessfulModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class P2PTransferRepo extends GetConnect{

  Future getAllAccount({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.showP2PRequestList;
    debugPrint(
        "getAllAccountPoint: $endPoint ; getAllAccountPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
  //  debugPrint("getAllAccountResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    // try {
      return P2PAllRequestModel.fromJson(json);
    // } catch (e) {
    //   print("catch me gya getAllAccount");
    //   if (response.body["message"] == "Invalid Token!") {
    //     //   AppUtility.showErrorSnackBar(response.body["message"].toString());
    //     ShowBox().showBox(
    //         text: "Session Expired",
    //         onButtonClick: () {
    //           AppPreference().logout();
    //           Get.to(() => const LoginPage());
    //         },
    //         titleContent: "Please Login Again",
    //         buttonText: "Login");
    //   } else {
    //     AppUtility.showSuccessSnackBar(response.body["message"]);
    //   }
    // }
  }
  Future getYourRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.buyRequestList;
    debugPrint(
        "getYourRequestPoint: $endPoint ;getYourRequestPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
  //  debugPrint("getYourRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return BuyRequestListModel.fromJson(json);
    } catch (e) {
      print("catch me gya getYourRequest");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
  Future getSelfRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.buyRequestListSelf;
    debugPrint(
        "getSelfRequestPoint: $endPoint ;getSelfRequestPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
  //  debugPrint("getSelfRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return SelfRequestListModel.fromJson(json);
    } catch (e) {
      print("catch me gya getSelfRequest");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
  Future sendOtpSelfRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.resendOtpForP2p;
    debugPrint(
        "sendOtpSelfRequestPoint: $endPoint ;sendOtpSelfRequestPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("sendOtpSelfRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
    } catch (e) {
      print("catch me gya sendOtpSelfRequest");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }


  Future cancelSellRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.cancelBuyRequest;
    debugPrint(
        "cancelSellRequestRequestPoint: $endPoint ;cancelSellRequestRequestPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("cancelSellRequestRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
    } catch (e) {
      print("catch me gya cancelSellRequest");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
  Future cancelBuyRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.cancelBuyRequestSeller;
    debugPrint(
        "cancelSellRequestRequestPoint: $endPoint ;cancelSellRequestRequestPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("cancelSellRequestRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
    } catch (e) {
      print("catch me gya cancelSellRequest");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
  Future verifyOtpSelfRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.verifiedOtpForP2p;
    debugPrint(
        "verifyOtpSelfRequestPoint: $endPoint ;verifyOtpSelfRequestPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("verifyOtpSelfRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
    } catch (e) {
      print("catch me gya verifyOtpSelfRequest");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }

  Future approveRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.approveRequestAmount;
    debugPrint(
        "approveRequestPoint: $endPoint ; approveRequestPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("approveRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
    } catch (e) {
      print("catch me gya approveRequest");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }
  }
  Future deleteRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.myP2pSellCancel;
    debugPrint(
        "getAllRequestListSendPoint: $endPoint ;getAllRequestListPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("getAllRequestListSendResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
    } catch (e) {
      debugPrint("catch me gya: ${response.body}");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }
  }

}