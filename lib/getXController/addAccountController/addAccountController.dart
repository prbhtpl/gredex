import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Utility/app_utility.dart';

import '../../model/AccountDetailsModel/AccountDetailsModel.dart';
import '../../model/CommanModel/CommanModel.dart';
import 'addAccountRepo/addAccountRepo.dart';

class AddAccountController extends GetxController {
  AddAccountRepo addAccountRepo = Get.put(AddAccountRepo());
  RxBool loaderStatus = false.obs;
  var commonModel = Rxn<CommonModel>();
  var accountDetailsModel = Rxn<AccountDetailsModel>();
  Rx<TextEditingController> totalAccount = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> confirmAccountNumber = TextEditingController().obs;
  Rx<TextEditingController> accountHolderName = TextEditingController().obs;
  Rx<TextEditingController> ifscCode = TextEditingController().obs;
  Rx<String> selectedAccountId = "1".obs;
  Rxn<String> selectedAccountType = Rxn("upi");

  clearAlValue() {
    mobileNumber.value.clear();
    totalAccount.value.clear();

    confirmAccountNumber.value.clear();
    accountHolderName.value.clear();
    ifscCode.value.clear();
  }

  @override
  onReady() {
    super.onReady();
    initData();
  }

  initData() {
    getAccountDetails();
  }

  Future<void> addAccount() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "type": selectedAccountType.value,
      "accountno": totalAccount.value.text,
      "acHolderName": accountHolderName.value.text,
      "ifscCode": ifscCode.value.text,
      "mobile": mobileNumber.value.text
    };

    try {
      var response =
          await addAccountRepo.addAccount(payload: payload).then((value) {
        if (value != null) {
          commonModel.value = value;
          if (value.status != false) {
            clearAlValue();
            getAccountDetails();
            AppUtility.showSuccessSnackBar(value.message);
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
    } catch (e) {
      debugPrint("addAccount $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getAccountDetails() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await addAccountRepo.getAccount(payload: payload).then((value) {
        if (value != null) {
          accountDetailsModel.value = value;
          if (value.status != false) {
           // AppUtility.showSuccessSnackBar(value.message);
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
    } catch (e) {
      debugPrint("getAccountDetails $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
