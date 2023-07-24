import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_local_db.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';
import 'package:gredex/getXController/homePageController/homePageRepo/homePageRepo.dart';
import 'package:gredex/screens/auth/loginPage/login_page.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/bottom_navigation.dart';
import '../../model/3xAmountModel/threeXAmountModel.dart';
import '../../model/BeptokenbalCheckModel/beptokenbalCheckModel.dart';
import '../../model/GDXLiveRateModel/GDXLiveRateModel.dart';
import '../../model/bannerModel/bannerModel.dart';
import '../../model/dashboardDataModel/dashboardModel.dart';
import '../../model/profileModel/profileModel.dart';
import '../../model/qrCodeModel/qrCodeModel.dart';
import '../../model/rankModel/rankModel.dart';
import '../../model/userTimeModel/userTImeModel.dart';
import '../qrController/qrRepo/qrRepo.dart';

class HomePageController extends GetxController {
  RxBool loaderStatus = false.obs;

  get context => BuildContext;

  @override
  onReady() async {

    super.onReady();
  }

  final HomePageRepo _homePageRepo = Get.put(HomePageRepo());
  var qrModel = Rxn<QrModel>();
  var beptokenbalCheckModel = Rxn<BeptokenbalCheckModel>();

  //final DownLineController downLineController = Get.put(DownLineController());

  initData({bool showPopUp = false}) {
    //  _initPackageInfo();
    initCallBnb();
    GDXLiveRate();
    getBanner();
    getAllData(showPopUp);
    BEPTokenBalance();
    get3XModel();
    getUserTime();
    rank();
  }

/*  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    packageInfo = info;
  }*/

/*  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );*/
  Rx<double> dollarToBNB = 0.0.obs;
  var allUserProfileData = Rxn<ProfileModel>();
  var gdxLiveRateModel = Rxn<GdxLiveRateModel>();
  var allDashboardData = Rxn<DashboardDataModel>();

  var rankModel = Rxn<RankModel>();
  var threeXAmountModel = Rxn<ThreeXamountModel>();
  var bannerList = Rxn<BannerModel>();
  var userTimeModel = Rxn<UserTimeModel>();
  QRRepo qRRepo = Get.put(QRRepo());

  Future<void> getAllData(bool showPopUp) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      print("GetAllData");
      var response =
          await _homePageRepo.getUserProfile(payload: payload).then((value) {
        if (value != null) {
          if (value.message != "Invalid Token!") {
            allUserProfileData.value = value;
            update();
            getDashboardData();
            debugPrint(
                "getAllData: ${allUserProfileData.value?.data.toString()}");
            /*    if (allUserProfileData.value?.data.passwordStatus == 0) {*/
            if (allUserProfileData.value?.data.changeStatus == 0) {
              debugPrint(
                  "getAllData: ${allUserProfileData.value?.data.toString()}");

              showPopUp
                  ? ShowBox().warningMessage(
                      title:
                          "Congratulations\nYou are now part of Gridx Ecosystem",
                      onButtonClick: () {
                        /*PersistentNavBarNavigator.pushNewScreen(
                          Get.context!,
                          screen: ProfileReward(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );*/
                        Navigator.push(
                            Get.context!,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigation()));
                      },
                      userId: "Password Alert",
                      name:
                          """Please check your profile first, some people have not updated their profile and password due to which someone else has updated their profile and money is being withdrawn from their account, causing trouble to people.

Now the management has decided that all of you should first check your profile and update it again, because today and tomorrow the withdrawal will be closed for two days.

If you do not do this, then the company will not be responsible for it.""",
                      password:
                          "Note: The organization is not responsible for your any financial loss from your account!",
                      buttonText: "Update Profile",
                      context: Get.context!)
                  : null;
            } else {
              Future.delayed(const Duration(seconds: 1), () {
                Get.to(() => BottomNavigation());
              });
            }
            // Future.delayed(const Duration(seconds: 1), () {
            //   Get.to(() => BottomNavigation());
            // });
          } else {
            ShowBox().showBox(
                text: "Session Expired",
                onButtonClick: () {
                  AppPreference().logout();
                  Get.to(() => const LoginPage());
                },
                titleContent: "Please Login Again",
                buttonText: "Login");
          }
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("getAllData: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> getDashboardData() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await _homePageRepo.getDashboardData(payload: payload).then((value) {
        // AppUtility.showSuccessSnackBar(value.message.toString());
        if (value != null) {
          allDashboardData.value = value;
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("getDashboardData: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> rank() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await _homePageRepo.rank(payload: payload).then((value) {
        // AppUtility.showSuccessSnackBar(value.message.toString());
        if (value != null) {
          rankModel.value = value;
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("rankData: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> get3XModel() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await _homePageRepo.get3XAmountData(payload: payload).then((value) {
        if (value != null) {
          threeXAmountModel.value = value;
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("get3XModel: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> getBanner() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await _homePageRepo.getBannerList(payload: payload).then((value) {
        if (value != null) {
          bannerList.value = value;
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("getBanner: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> getUserTime() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await _homePageRepo.getUserTime(payload: payload).then((value) {
        if (value != null) {
          userTimeModel.value = value;
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("get3XModel: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> GDXLiveRate() async {
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await _homePageRepo.getLiveRateGdx(payload: payload).then((value) {
        if (value != null) {
          gdxLiveRateModel.value = value;
          // Future.delayed(Duration(seconds: 5), () async {
          //   await GDXLiveRate();
          // });
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("GDXLiveRate: ${e.toString()}");
    }

    update();
  }

  Future<void> initCallBnb() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "tokenToSpend": "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
      "tokenToReceive": "0x55d398326f99059fF775485246999027B3197955",
      "amountToSpend": 1
    };

    try {
      var response =
          await _homePageRepo.initBNB(payload: payload).then((value) {
        if (value != null) {
          dollarToBNB.value = value.data;
          // convertedAmountModel.value = value;
        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("initCallBnb $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> BEPTokenBalance() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await qRRepo.bepToken(payload: payload).then((value) {
        if (value != null) {
          beptokenbalCheckModel.value = value;
          getQR();
        } else {
          // directRewardList=[];
        }
      });
    } catch (e) {
      debugPrint("BEPTokenBalance $e");
      qrModel.value = null;
      //  AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getQR() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await qRRepo.getQRCode(payload: payload).then((value) {
        if (value != null) {
          qrModel.value = value;

        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getQR $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
