import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/getXController/p2pTransactionController/p2pTransactionRepo/p2pTransactionRepo.dart';

import '../../Utility/app_utility.dart';
import '../../model/checkUserModel/checkUserModel.dart';
import '../../model/p2pTransactionSuccesModel/p2pTransactionSuccessModel.dart';
import '../../model/p2pTransactionhistoryModel/p2pTransactionHistoryModel.dart';
import '../../model/withdrawalVerify/withdrawalVerify.dart';

class P2PTransactionController extends GetxController {
  RxBool loaderStatus = false.obs;
  Rxn<String> selectedWallet = Rxn();
  RxBool showOtpField = false.obs;
  Rx<String> selectedWalletId = "0".obs;
  RxInt amountInt = 1.obs;
  Rx<TextEditingController> username = TextEditingController().obs;

  Rx<TextEditingController> amount = TextEditingController().obs;
  P2PTransactionRepo p2pTransactionRepo = Get.put(P2PTransactionRepo());
  HomePageController homePageController = Get.put(HomePageController());
  var p2PTransactionSuccessModel = Rxn<P2PTransactionSuccesModel>();
  var checkUserModel = Rxn<CheckUserModel>();
  var p2pTransactionHistoryModel = Rxn<P2PTransactionHistoryModel>();
  List<P2pTransactionHistoryList> p2pP2pTransactionHistoryList =
      List.empty(growable: true);
  Rx<String> otp = "".obs;
  var withdrawalVerify = Rxn<WithdrawalVerify>();
  @override
  void onReady(){
    initData();
    super.onReady();
  }
  clearAllValue() {
    selectedWalletId.value = "0";
    username.value.clear();
    amount.value.clear();
    checkUserModel.value = null;
    selectedWallet.value = null;
  }

  initData() {
    getP2pTransactionHistory();
    showOtpField.value = false;

    amountInt.value = 1;
  }

  Future<void> p2pTransaction() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "gdxamount": amountInt.value,
      "username": "GDX${username.value.text}",
      "wallettype": selectedWalletId == "1" ? "int" : "gdx"
    };

    try {
      if (amountInt.value > 24) {
        var response = await p2pTransactionRepo
            .p2pTransaction(payload: payload)
            .then((value) {
          if (value != null) {
            if (value.status != false) {
              AppUtility.showSuccessSnackBar(value.message);
              showOtpField.value = true;
              otp.value = "";
              // p2PTransactionSuccessModel.value = value;
              // ShowBox().showBox(
              //     text: "Transfer Successfully",
              //     onButtonClick: () {
              //       Get.back();
              //     },
              //     titleContent: "",
              //     buttonText: "Done");
              // clearAllValue();
              // homePageController.initData();
            } else {
              AppUtility.showSuccessSnackBar(value.message);
            }
          }
        });
      } else {
        AppUtility.showErrorSnackBar("Amount Should be greater than 25");
      }
    } catch (e) {
      debugPrint("p2pTransaction $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  var p2pFormKey = GlobalKey<FormState>();

  Future<void> verifyP2P() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "gdxamount": amountInt.value,
      "username": "GDX${username.value.text}",
      "wallettype": selectedWalletId == "1" ? "int" : "gdx",
      "otp": otp.value,
    };

    try {
      var response =
          await p2pTransactionRepo.verifyP2P(payload: payload).then((value) {
        if (value != null) {
          if (value.status != false) {
            if (value.message != "Incorrect OTP!") {
              AppUtility.showSuccessSnackBar(value.message);
              withdrawalVerify.value = value;
              showOtpField.value = false;
              clearAllValue();

              ShowBox().congratulationDialogueBoxActivation(
                  imageWidget: Image.asset("assets/p2pTransfer.jpg"),
                  title: "Congratulations\nYou are now part of Gridx Ecosystem",
                  onButtonClick: () {
                    Get.back();
                  },
                  userId: "User-Id: ${withdrawalVerify.value?.data.creditedId}",
                  name: "Amount: ${ withdrawalVerify.value?.data.amount.toStringAsFixed(2)}",
                  password: "Wallet Type: ${withdrawalVerify.value?.data.walletType=="int"?"Internal": "GDX"}",
                  buttonText: "Done",
                  context: Get.context!);
              amountInt.value=1;
             /* ShowBox().showBox(
                  text: "${value.message}",
                  onButtonClick: () {
                    Get.back();
                  },
                  titleContent: "",
                  buttonText: "Done");*/

              getP2pTransactionHistory();
              homePageController.initData();
            }
          } else {
            AppUtility.showSuccessSnackBar(value.message);
          }
        }
      });
    } catch (e) {
      debugPrint("verifyP2P $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> checkUser() async {
    loaderStatus.value = true;

    update();
    Map<String, dynamic> payload = {
      "username": "GDX${username.value.text}",
    };

    try {
      var response =
          await p2pTransactionRepo.checkUser(payload: payload).then((value) {
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

  Future<void> getP2pTransactionHistory() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await p2pTransactionRepo
          .getTransactionHistory(payload: payload)
          .then((value) {
        if (value != null) {
          p2pTransactionHistoryModel.value = value;
          p2pP2pTransactionHistoryList = p2pTransactionHistoryModel.value!.data;
        } else {
          p2pP2pTransactionHistoryList = [];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getP2pTransactionHistory $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
