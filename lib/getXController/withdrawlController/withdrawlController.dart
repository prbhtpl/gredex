import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/withdrawlController/withdrawlRepo/withdrawlRepo.dart';

import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/WithDrawalSuccessModel/WithDrawalSuccessModel.dart';
import '../../model/wihdrawalOtpSend/withdrawalOtpSend.dart';
import '../../model/withdrawalReportModel/withdrawalReportModel.dart';
import '../../model/withdrawalVerify/withdrawalVerify.dart';
import '../homePageController/homePageController.dart';

class WithdrawalController extends GetxController {
  WithdrawalRepo withdrawalRepo = Get.put(WithdrawalRepo());
  RxBool loaderStatus = false.obs;
  Rx<String> selectedWalletId = "0".obs;
  Rxn<String> selectedWallet = Rxn();
  RxBool showOtpField = false.obs;
  HomePageController homePageController = Get.put(HomePageController());
  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> convertedAmount = TextEditingController().obs;
  RxInt amountInt = 1.obs;
  RxDouble gdxAmount = 1.0.obs;
  RxInt dollarAmount = 1.obs;

  Rx<String> otp = "".obs;

  var withdrawalReportModel = Rxn<WithdrawalReportModel>();
  var withdrawalModelOtpSend = Rxn<WithdrawalModelOtpSend>();
  var withdrawalSuccessModel = Rxn<WithdrawalSuccessModel>();
  var withdrawalVerify = Rxn<WithdrawalVerify>();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {
    getAllWithdrawalHistory(showPopUp: true);
    showOtpField.value = false;
    clearAllValue();
  }

  Future<void> getAllWithdrawalHistory({bool showPopUp=false}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await withdrawalRepo
          .getWithdrawalList(payload: payload)
          .then((value) {
        if (value != null) {
          withdrawalReportModel.value = value;
          showPopUp? ShowBox().withdrawalWarning(
              wholeData:
                  """All GDX addresses MUST begin with the letter "Ox* having 42 characters and make sure you DO NOT put any commas(,) into the form above
Use Only GDX Token (BEP 20) Address Here If Use Other Address then GDX Token (BEP 20) May Result in Permanent
Loss\n
Withdrawals are Restricted © Last Day OF Every Month.\n
Withdrawal Are Available 24/7\n
All Withdrawal will be process Next Day of withdrawal submission\n
Minimum Withdrawal is \$25.00\n
Admin charges applicable every time of your withdrawals\n
Admin Charges for the first time is minimum 5% and on 2nd, 3rd & 4th time charges will be 10% above of them of Withdrawal charges will be 15%
Whichever is Higher.\n
IMPORTANT: Please take your time and double check the details you entered before submit withdrawal request.\n
There is no way to reverse your transaction, So PLEASE make sure you enter the correct GDX Token (BEP 20 address and select the correct amount.""",
              onButtonClick: () {
                Get.back();
              },
              buttonText: "Done",
              context: Get.context!):null;
        } else {
          showPopUp? ShowBox().withdrawalWarning(
              wholeData:
                  """All GDX addresses MUST begin with the letter "Ox* having 42 characters and make sure you DO NOT put any commas(,) into the form above
Use Only GDX Token (BEP 20) Address Here If Use Other Address then GDX Token (BEP 20) May Result in Permanent
Loss
Withdrawals are Restricted © Last Day OF Every Month.
Withdrawal Are Available 24/7
All Withdrawal will be process Next Day of withdrawal submission
Minimum Withdrawal is \$25.00
Admin charges applicable every time of your withdrawals
Admin Charges for the first time is minimum 5% and on 2nd, 3rd & 4th time charges will be 10% above of them of Withdrawal charges will be 15%
Whichever is Higher.
IMPORTANT: Please take your time and double check the details you entered before submit withdrawal request.
There is no way to reverse your transaction, So PLEASE make sure you enter the correct GDX Token (BEP 20 address and select the correct amount""",
              onButtonClick: () {
                Get.back();
              },
              buttonText: "Done",
              context: Get.context!):null;
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
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

  Future<void> withdrawalAmount() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      // "gdxamount": selectedWalletId == "1"?dollarAmount.value: gdxAmount.value,
      "gdxamount": dollarAmount.value,
      "wallettype": selectedWalletId.value == "1" ? "int" : "gdx"
    };

    try {
     /* if (double.parse(amount.value.text) > 24) {*/
        var response = await withdrawalRepo
            .withdrawalOtpSend(payload: payload)
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

  Future<void> verifyWithdrawal() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      //   "gdxamount": selectedWalletId == "1"?dollarAmount.value: gdxAmount.value,
      "gdxamount": dollarAmount.value,
      "otp": otp.value,
      "type":"byApp",
      "wallettype": selectedWalletId == "1" ? "int" : "gdx"
    };

    try {
      var response =
          await withdrawalRepo.verifyWithdrawal(payload: payload).then((value) {
        if (value != null) {
          if (value.status != false) {
            if (value.message != "Incorrect OTP!") {
              AppUtility.showSuccessSnackBar(value.message);
              // withdrawalVerify.value = value;
              withdrawalSuccessModel.value = value;
              showOtpField.value = false;
              clearAllValue();
              ShowBox().congratulationDialogueBoxActivation(
                  imageWidget: Image.asset("assets/Withdrawal.jpg"),
                  title: "Congratulations\nYou are now part of Gridx Ecosystem",
                  onButtonClick: () {
                    Get.back();
                  },
                  userId: "${withdrawalSuccessModel.value?.data.address.substring(0,5)}XXXXXX${withdrawalSuccessModel.value?.data.address.split('').reversed.join('').substring(0,5)}",
                  name: "User-Id: ${value.data.username}",
                  password: "Amount: ${value.data.amount.toStringAsFixed(2)} GDX",
                  buttonText: "Done",
                  context: Get.context!);
              /*ShowBox().showBox(
                  text: "${value.message}",
                  onButtonClick: () {
                    Get.back();
                  },
                  titleContent: "",
                  buttonText: "Done");*/

              getAllWithdrawalHistory();
              homePageController.initData();
            }
          } else {
            AppUtility.showSuccessSnackBar(value.message);
          }
        }
      });
    } catch (e) {
      debugPrint("p2pTransaction $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
