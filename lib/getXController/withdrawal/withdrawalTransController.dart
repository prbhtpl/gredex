import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/getXController/withdrawal/withdrawalTransRepo/withdrawalTransRepo.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../Utility/app_utility.dart';
import '../../commonWidget/bottom_navigation.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/BeptokenbalCheckModel/beptokenbalCheckModel.dart';
import '../../model/GDXTransSucessfulModel/GDXTransSucessfulModel.dart';
import '../../model/qrCodeModel/qrCodeModel.dart';
import '../../model/updateSuccessfullyModel/updateSucessfullyModel.dart';
import '../../model/withdrawalVerify/withdrawalVerify.dart';
import '../qrController/qrController.dart';
import '../qrController/qrRepo/qrRepo.dart';
import '../totalbalanceHistoryController/totalBalanceController.dart';

class WithdrawalController extends GetxController {
  TotalBalanceController totalBalanceController =
      Get.put(TotalBalanceController());
  RxBool loaderStatus = false.obs;
  RxString stringAmount = "0.00".obs;
  WithdrawalTransRepo withdrawalTransRepo = Get.put(WithdrawalTransRepo());
  HomePageController homePageController = Get.put(HomePageController());

  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  var updatedSuccessfullyModel = Rxn<UpdatedSuccessfullyModel>();
  var gdxTransSuccessfulModel = Rxn<GdxTransSucessfulModel>();
  RxBool showOtpField = false.obs;
  Rx<String> otp = "".obs;
  var withdrawalVerify = Rxn<WithdrawalVerify>();
  QRRepo qRRepo = Get.put(QRRepo());
  var qrModel = Rxn<QrModel>();
  var beptokenbalCheckModel = Rxn<BeptokenbalCheckModel>();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {}

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
     // AppUtility.showErrorSnackBar(e.toString());
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

  Future<void> sendOtp() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "gdxamount": amount.value.text,
      "gdxaddress": address.value.text,
    };

    try {
      var response =
          await withdrawalTransRepo.sendOtp(payload: payload).then((value) {
        if (value != null) {
          AppUtility.showSuccessSnackBar(value.message.toString());
          updatedSuccessfullyModel.value = value;
          showOtpField.value = true;
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("sendOtp: ${e.toString()}");
    }

    loaderStatus.value = false;
    update();
  }

  clearAllValue() {
    amount.value.clear();
    otp.value = "";
    address.value.clear();
  }

  Future verifyWithdrawal() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      //   "gdxamount": selectedWalletId == "1"?dollarAmount.value: gdxAmount.value,

      "otp": otp.value,
      "gdxamount": amount.value.text,
      "gdxaddress": address.value.text,
    };

    try {
      var response = await withdrawalTransRepo
          .verifyWithdrawal(payload: payload)
          .then((value) {
        if (value != null) {
          if (value.message != "Incorrect OTP!") {
            AppUtility.showSuccessSnackBar(value.message);
            gdxTransSuccessfulModel.value = value;
            showOtpField.value = false;
            clearAllValue();
            stringAmount.value = "0.00";
            ShowBox().congratulationDialogueBoxActivation(
                imageWidget: Image.asset("assets/transferGDX.jpg"),
                title: "Congratulations\nYou are now part of Gridx Ecosystem",
                onButtonClick: () {
                  Get.back();
                },
                userId:
                    "${gdxTransSuccessfulModel.value?.data.address.substring(0, 5)}XXXXXX${gdxTransSuccessfulModel.value?.data.address.split('').reversed.join('').substring(0, 5)}",
                name:
                    "${int.parse(gdxTransSuccessfulModel.value!.data.amount).toStringAsFixed(2)} GDX",
                password: "",
                buttonText: "Done",
                context: Get.context!);



            /* ShowBox().showBox(
                text: "${value.message}",
                onButtonClick: () {
                  Get.back();
                },
                titleContent: "",
                buttonText: "Done");*/

            //BEPTokenBalance();


            // getAllWithdrawalHistory();
         homePageController.initData();
          } else {
            AppUtility.showSuccessSnackBar(value.message);
          }
        }
      });
      return true;
    } catch (e) {
      debugPrint("verifyWithdrawal $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
