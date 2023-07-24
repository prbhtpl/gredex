import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/getXController/activationHistoryController/activationHistoryRepo/activaionHistoryRepo.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/activateModel/activateModel.dart';
import '../../model/activationHistoryModel/activationHistoryModel.dart';
import '../../model/activationHistoryModel/activationHistoryModel.dart';
import '../../model/activationHistoryModel/activationHistoryModel.dart';
import '../../model/activationSucessful/activationSucessful.dart';
import '../../model/checkUserModel/checkUserModel.dart';
import '../../model/renewalModel/renewalModel.dart';

import '../../model/wihdrawalOtpSend/withdrawalOtpSend.dart';
import '../../model/withdrawalVerify/withdrawalVerify.dart';
import '../../screens/auth/loginPage/login_page.dart';
import '../p2pTransactionController/p2pTransactionController.dart';

class ActivationHistoryController extends GetxController {
  RxBool loaderStatus = false.obs;
  Rxn<String> selectedWallet = Rxn();

  Rx<String> selectedWalletId = "0".obs;

  RxInt amountInt = 1.obs;
  Rx<TextEditingController> username = TextEditingController().obs;
  Rx<TextEditingController> amount = TextEditingController().obs;
  RxBool showOtpField = false.obs;

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {
    showOtpField.value = false;

    getActivationHistory();
    getRenewalHistory();
    clearAllValue();
    checkUserModel.value = null;
  }

  var withdrawalVerify = Rxn<WithdrawalVerify>();
  var activationSucessfulModel = Rxn<ActivationSucessfulModel>();
  var checkUserModel = Rxn<CheckUserModel>();

  clearAllValue() {
    checkUserModel.value=null;
    selectedWalletId.value = "0";
    selectedWallet.value = null;
    username.value.clear();
    amountInt = 1.obs;
    amount.value.clear();
    otp.value = "";
  }

  var activationHistoryModel = Rxn<ACtivationHistoryModel>();
  var activateAccountModel = Rxn<WithdrawalModelOtpSend>();
  var renewalModel = Rxn<RenewalModel>();
  final ActivationHistoryRepo _activationHistoryRepo =
      Get.put(ActivationHistoryRepo());
  final HomePageController homePageController = Get.put(HomePageController());
  Rx<String> otp = "".obs;

  Future<void> checkUser() async {
    loaderStatus.value = true;

    update();
    Map<String, dynamic> payload = {
      "username": "GDX${username.value.text}".trim(),
    };

    try {
      var response = await _activationHistoryRepo
          .checkUser(payload: payload)
          .then((value) {
        if (value != null) {
          checkUserModel.value = value;
        }
      });
      print(response);
    } catch (e) {
      debugPrint("p2pTransaction $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> activateAccount() async {

    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "gdxamount": "${amountInt.value}".trim(),
      "username": "GDX${username.value.text}".trim(),
      "wallettype": selectedWalletId == "1"
          ? "ext".trim()
          : selectedWalletId == "2"
              ? "gdx".trim()
              : "autoActive".trim()
    };

    try {
      if (amountInt.value > 49) {
      var response = await _activationHistoryRepo
          .activateAccount(payload: payload)
          .then((value) {
        if (value != null) {
          if (value.status != false) {
            if (value.message != "Id is Already Activated!") {
              activateAccountModel.value = value;
              AppUtility.showSuccessSnackBar(value.message);

              showOtpField.value = true;
            } else {
              AppUtility.showSuccessSnackBar(value.message);
            }
          } else {
            AppUtility.showSuccessSnackBar(value.message);
          }
        }
      });
        } else {
        AppUtility.showErrorSnackBar("Amount Should be greater than 50");
      }
    } catch (e) {
      debugPrint("p2pTransaction $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> verifyActivation() async {

    loaderStatus.value = true;
    update();

    Map<String, dynamic> payload = {
      //   "gdxamount": selectedWalletId == "1"?dollarAmount.value: gdxAmount.value,
      "gdxamount": amountInt.value,
      "username": "GDX${username.value.text}",
      "wallettype": selectedWalletId == "1"
          ? "ext"
          : selectedWalletId == "2"
              ? "gdx"
              : "autoActive",

      "otp": otp.value,
    };

    try {
      var response = await _activationHistoryRepo
          .verifyActivation(payload: payload)
          .then((value) {
        if (value != null) {
          if (value.status != false) {
            if (value.message != "Incorrect OTP!") {
              AppUtility.showSuccessSnackBar(value.message);
              activationSucessfulModel.value = value;
              showOtpField.value = false;

              if (value.message != "Id is Already Activated!") {
                ShowBox().congratulationDialogueBoxActivation(
                    imageWidget: Image.asset("assets/activation.jpg"),
                    title: "Congratulations\nYou are now part of Gridx Ecosystem",
                    onButtonClick: () {
                      Get.back();
                    },
                    userId: "User-Id: ${value.data.activationId}",
                    name: "Usd: ${value.data.usdamount.toStringAsFixed(2)}",
                    password: "GDX: ${value.data.gdxamount.toStringAsFixed(2) }",
                    buttonText: "Done",
                    context: Get.context!);

                /*ShowBox().showBox(
                    text: "Submit Successfully",
                    onButtonClick: () {
                      Get.back();
                    },
                    titleContent: "",
                    buttonText: "Done");*/
                clearAllValue();
                homePageController.initData();
                getActivationHistory();
              }
            }
          } else {
            AppUtility.showSuccessSnackBar(value.message);
          }
        }
      });
    } catch (e) {
      debugPrint("verifyActivation $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getActivationHistory() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await _activationHistoryRepo
          .getActivationData(payload: payload)
          .then((value) {
        if (value != null) {
          activationHistoryModel.value = value;
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getActivationHistory $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getRenewalHistory() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await _activationHistoryRepo
          .getRenewalHistory(payload: payload)
          .then((value) {
        if (value != null) {
          renewalModel.value = value;
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getActivationHistory $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
