
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/3xAmountModel/threeXAmountModel.dart';
import '../../../model/GDXLiveRateModel/GDXLiveRateModel.dart';
import '../../../model/bannerModel/bannerModel.dart';
import '../../../model/convertedAmountModel/convertedAmountModel.dart';
import '../../../model/dashboardDataModel/dashboardModel.dart';

import '../../../model/profileModel/profileModel.dart';
import '../../../model/rankModel/rankModel.dart';
import '../../../model/transactionHistoryModel/trasactionHistoryModel.dart';
import '../../../model/userTimeModel/userTImeModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class HomePageRepo extends GetConnect {
  Future initBNB({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint =ApiUrl.swapAmount;
    debugPrint(
        "initBNBEndpoint: $endPoint ;initBNBPayload: $payload");
    var response = await post(endPoint, payload,
    ) .timeout(const Duration(seconds: 300));
    debugPrint("convertAmountData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);


    return ConvertedAmountModel.fromJson(json);

  }
  Future getUserProfile({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.getUserProfile;
    debugPrint(
        "getUserProfileEndpoint: $endPoint ; getUserProfilePayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"});
    debugPrint("getUserProfileResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return ProfileModel.fromJson(json);
    } catch (e) {
      print("getUserProfile catch me gya");
      if (response.body["message"] == "Invalid Token!") {
       // AppUtility.showErrorSnackBar(response.body["message"].toString());
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

  Future getDashboardData({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.dashboardapi;
    debugPrint(
        "getDashboardDataEndpoint: $endPoint ; getDashboardDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"});
    debugPrint("getDashboardData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);
  try {
      return DashboardDataModel.fromJson(json);
    } catch (e) {  print("getDashboardData catch me gya");
      if (response.body["message"] == "Invalid Token!") {
      //  AppUtility.showErrorSnackBar(response.body["message"].toString());
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
  Future rank({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.rank;
    debugPrint(
        "rankEndpoint: $endPoint ; rankPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"});
    debugPrint("rankData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);
  try {
      return RankModel.fromJson(json);
    } catch (e) {  print("rank catch me gya");
      if (response.body["message"] == "Invalid Token!") {
      //  AppUtility.showErrorSnackBar(response.body["message"].toString());
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
  Future getBannerList({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.banner;
    debugPrint(
        "getBannerListEndpoint: $endPoint ; getBannerListPayload: $payload");
    var response = await get(endPoint,
        headers: {"Authorization": "Bearer $token"});
    debugPrint("getBannerListData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

      return BannerModel.fromJson(json);






  }

  Future get3XAmountData({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.get3Xamount;
    debugPrint(
        "get3XAmountDataEndpoint: $endPoint ;get3XAmountDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) ;
    debugPrint("get3XAmountDataResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return ThreeXamountModel.fromJson(json);
    } catch (e) {
      print("get3XAmountData catch me gya");
      if (response.body["message"] == "Invalid Token!") {
       // AppUtility.showErrorSnackBar(response.body["message"].toString());
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
  Future getUserTime({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.userTime;
    debugPrint(
        "getUserTimeEndpoint: $endPoint ;getUserTimePayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) ;
    debugPrint("getUserTimeResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return UserTimeModel.fromJson(json);
    } catch (e) {
      print("getUserTime catch me gya");
      if (response.body["message"] == "Invalid Token!") {
       // AppUtility.showErrorSnackBar(response.body["message"].toString());
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

  Future getLiveRateGdx({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.gdxLiveRate;

    var response =
        await get(endPoint, headers: {"Authorization": "Bearer $token"});
debugPrint("getLiveRateGdx ${response.statusCode}");
debugPrint("getLiveRateGdxBody ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return GdxLiveRateModel.fromJson(json);
    } catch (e) {
      print("getLiveRateGdx catch me gya");
      if (response.body["message"] == "Invalid Token!") {
      //  AppUtility.showErrorSnackBar(response.body["message"].toString());
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


}
