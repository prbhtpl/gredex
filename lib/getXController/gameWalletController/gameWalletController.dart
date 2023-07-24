import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/GameWalletListModel/GameWalletListModel.dart';
import '../../model/WithDrawalSuccessModel/WithDrawalSuccessModel.dart';
import '../../model/wihdrawalOtpSend/withdrawalOtpSend.dart';
import '../../model/withdrawalReportModel/withdrawalReportModel.dart';
import '../homePageController/homePageController.dart';
import 'gameWalletRepo/gameWalletRepo.dart';

class GameWalletController extends GetxController {
  RxBool showOtpField = false.obs;
  Rx<String> selectedWalletId = "0".obs;
  Rxn<String> selectedWallet = Rxn();
  GameWalletRepo gameWalletRepo = Get.put(GameWalletRepo());
  RxBool loaderStatus = false.obs;
  Rx<String> otp = "".obs;
  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> convertedAmount = TextEditingController().obs;
  RxInt amountInt = 1.obs;
  RxDouble gdxAmount = 1.0.obs;
  RxInt dollarAmount = 1.obs;
  HomePageController homePageController = Get.put(HomePageController());
  var withdrawalModelOtpSend = Rxn<WithdrawalModelOtpSend>();
  var withdrawalSuccessModel = Rxn<WithdrawalSuccessModel>();
  var gameWalletListModel = Rxn<GameWalletListModel>();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  clearAllValue() {
    amount.value.clear();
    selectedWalletId.value = "0";
    selectedWallet = Rxn();
    amountInt.value = 1;
    otp.value = "";
    convertedAmount.value.clear();
    gdxAmount.value = 1.0;
    dollarAmount.value = 1;
  }

  initData() {
    clearAllValue();
    showOtpField.value = false;
    getGameWalletHistory();
  }

  Future<void> getGameWalletHistory() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await gameWalletRepo
          .getGameWalletList(payload: payload)
          .then((value) {
        if (value != null) {
          gameWalletListModel.value = value;
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> gameWalletAmount() async {
    String walletType = "";
    if (selectedWalletId == "1") {
      walletType = "int";
    } else if (selectedWalletId == "2") {
      walletType = "gdx";
    } else if (selectedWalletId == "3") {
      walletType = "exint";
    } else if (selectedWalletId == "4") {
      walletType = "exgdx";
    }
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      // "gdxamount": selectedWalletId == "1"?dollarAmount.value: gdxAmount.value,
      "gdxamount": dollarAmount.value,
      "wallettype": walletType
    };

    try {
      /* if (double.parse(amount.value.text) > 24) {*/
      var response = await gameWalletRepo
          .gameWalletOtpSend(payload: payload)
          .then((value) {
        if (value != null) {
          if (value.status != false) {
            AppUtility.showSuccessSnackBar(value.message);
            withdrawalModelOtpSend.value = value;
            showOtpField.value = true;
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        }
      });
      /*} else {
        AppUtility.showErrorSnackBar("Amount Should be greater than 25");
      }*/
    } catch (e) {
      debugPrint("p2pTransaction $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> verifyGameWallet() async {
    loaderStatus.value = true;
    String walletType = "";
    if (selectedWalletId == "1") {
      walletType = "int";
    } else if (selectedWalletId == "2") {
      walletType = "gdx";
    } else if (selectedWalletId == "3") {
      walletType = "exint";
    } else if (selectedWalletId == "4") {
      walletType = "exgdx";
    }
    update();
    Map<String, dynamic> payload = {
      //   "gdxamount": selectedWalletId == "1"?dollarAmount.value: gdxAmount.value,
      "gdxamount": dollarAmount.value,
      "otp": otp.value,
      "wallettype":walletType
    };

    try {
      var response =
          await gameWalletRepo.verifyGameWallet(payload: payload).then((value) {
        if (value != null) {
          if (value.status != false) {
            if (value.message != "Incorrect OTP!") {
              AppUtility.showSuccessSnackBar(value.message);
              // withdrawalVerify.value = value;
              withdrawalSuccessModel.value = value;
              showOtpField.value = false;
              clearAllValue();
              /* ShowBox().congratulationDialogueBoxActivation(
                  imageWidget: Image.asset("assets/Withdrawal.jpg"),
                  title: "Congratulations\nYou are now part of Gridx Ecosystem",
                  onButtonClick: () {
                    Get.back();
                  },
                  userId: "${withdrawalSuccessModel.value?.data.address.substring(0,5)}XXXXXX${withdrawalSuccessModel.value?.data.address.split('').reversed.join('').substring(0,5)}",
                  name: "User-Id: ${value.data.username}",
                  password: "Amount: ${value.data.amount.toStringAsFixed(2)} GDX",
                  buttonText: "Done",
                  context: Get.context!);*/
              /*ShowBox().showBox(
                  text: "${value.message}",
                  onButtonClick: () {
                    Get.back();
                  },
                  titleContent: "",
                  buttonText: "Done");*/

              getGameWalletHistory();
              homePageController.initData();
            }
          } else {
            AppUtility.showSuccessSnackBar(value.message);
          }
        }
      });
    } catch (e) {
      debugPrint("verifyWithdrawal $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
