import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';

import '../../Utility/app_utility.dart';
import '../../model/BuyRequestListModel/BuyRequestListModel.dart';
import '../../model/CommanModel/CommanModel.dart';
import '../../model/P2PAllRequestModel/P2PAllRequestModel.dart';
import '../../model/SelfRequestListModel/selfRequestListModel.dart';

import 'p2pTransferRepo/p2pTransferRepo.dart';

class P2PTransferController extends GetxController {
  RxBool loaderStatus = false.obs;
  Rx<String> selectedWalletId = "0".obs;
  Rxn<String> selectedWallet = Rxn("All");
  var p2PAllRequestModel = Rxn<P2PAllRequestModel>();
  P2PTransferRepo p2pTransferRepo = Get.put(P2PTransferRepo());
  Rx<String> requestId = "".obs;
  HomePageController homePageController = Get.put(HomePageController());
  RxBool allRequestStream = false.obs;

  var buyRequestListModel = Rxn<BuyRequestListModel>();
  var selfRequestListModel = Rxn<SelfRequestListModel>();
  var commonModel = Rxn<CommonModel>();
  Rx<TextEditingController> transactionId = TextEditingController().obs;
  Rx<TextEditingController> otp = TextEditingController().obs;

  Rx<String> buyRequestId = "".obs;
  Rx<String> sellRequestId = "".obs;

  RxBool getYourStreamRequestList = false.obs;
  RxBool getSelfStreamRequestList = false.obs;

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  clearAllValue() {
    transactionId.value.clear();
    otp.value.clear();
  }

  initData() {
    allRequestStream.value = true;
    getSelfStreamRequestList.value = true;
    getYourStreamRequestList.value = true;
    getYourRequestList();
    getAllRequestList();
    getSelfRequestList();
  }

  Future<void> getAllRequestList() async {
    //loaderStatus.value = true;


    try {
      if (allRequestStream.value) {String selectedTeam = "";
        print("selectedWalletId ${selectedWalletId.value}");
      if (selectedWalletId.value == "1") {
        selectedTeam = "totalTeam";
      } else if (selectedWalletId.value == "2") {
        selectedTeam = "totalLeftTeam";
      } else if (selectedWalletId.value == "3") {
        selectedTeam = "totalRightTeam";
      }
      update();
      Map<String, dynamic> payload = {
        "teamFilter":selectedTeam
      };
        var response = await p2pTransferRepo
            .getAllAccount(payload: payload)
            .then((value) async {
          if (value != null) {
            p2PAllRequestModel.value = value;


            Future.delayed(Duration(seconds: 15), () {
              getAllRequestList();
            });
            if (value.status != false) {
              // AppUtility.showSuccessSnackBar(value.message);
            } else {
              print("yha aya h");
              p2PAllRequestModel.value!.data.list=[];
              // AppUtility.showErrorSnackBar(value.message);
            }
          } else {}
        });
        debugPrint(response.toString());
      }
    } catch (e) {  p2PAllRequestModel.value!=null? p2PAllRequestModel.value!.data.list=[]:null;
    Future.delayed(Duration(seconds: 15), () {
      getAllRequestList();
    });
      debugPrint("getAccountDetails $e");
     // AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getYourRequestList() async {
    //  loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      if (getYourStreamRequestList.value) {
        var response = await p2pTransferRepo
            .getYourRequest(payload: payload)
            .then((value) async {
          if (value != null) {
            buyRequestListModel.value = value;
            Future.delayed(Duration(seconds: 15), () {
              getYourRequestList();
            });
            if (value.status != false) {
              // AppUtility.showSuccessSnackBar(value.message);
            } else {
              print("yha aya h");
              // AppUtility.showErrorSnackBar(value.message);
            }
          } else {}
        });
        debugPrint(response);
      }
    } catch (e) {
      Future.delayed(Duration(seconds: 15), () {
        getYourRequestList();
      });
      debugPrint("getYourRequestList $e");
     // AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> sendOtpSelfRequest() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {"id": buyRequestId.value};

    try {
      if (getSelfStreamRequestList.value) {
        var response = await p2pTransferRepo
            .sendOtpSelfRequest(payload: payload)
            .then((value) async {
          if (value != null) {
            commonModel.value = value;
            if (value.status != false) {
              //AppUtility.showSuccessSnackBar(commonModel.value!.message);
            } else {
              print("yha aya h");
              // AppUtility.showErrorSnackBar(value.message);
            }
          } else {}
        });
        debugPrint(response);
      }
    } catch (e) {
      debugPrint("sendOtpSelfRequest $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> cancelSellRequest() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {"id": sellRequestId.value};

    try {
      var response = await p2pTransferRepo
          .cancelSellRequest(payload: payload)
          .then((value) async {
        if (value != null) {
          commonModel.value = value;
          if (value.status != false) {
            AppUtility.showSuccessSnackBar(commonModel.value!.message);
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
      debugPrint(response);
    } catch (e) {
      debugPrint("cancelSellRequest $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
  Future<void> cancelBuyRequest() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {"id": buyRequestId.value};

    try {
      var response = await p2pTransferRepo
          .cancelBuyRequest(payload: payload)
          .then((value) async {
        if (value != null) {
          commonModel.value = value;
          if (value.status != false) {
            AppUtility.showSuccessSnackBar(commonModel.value!.message);
          } else {
            print("yha aya h");
             AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
      debugPrint(response);
    } catch (e) {
      debugPrint("cancelSellRequest $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future verifySelfRequestOtp() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "id": buyRequestId.value,
      "otp": otp.value.text,
      "transactionId": transactionId.value.text
    };

    try {
      bool? status;
      var response = await p2pTransferRepo
          .verifyOtpSelfRequest(payload: payload)
          .then((value) {
        if (value != null) {
          commonModel.value = value;
          if (value.status != false) {
            clearAllValue();
            AppUtility.showSuccessSnackBar(value.message);
            status = true;
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
            status = false;
          }
        } else {}
      });
      return status;
    } catch (e) {
      debugPrint("verifySelfRequestOtp $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future approveOtp() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "id": sellRequestId.value,
    };

    try {
      var response =
      await p2pTransferRepo.approveRequest(payload: payload).then((value) {
        if (value != null) {
          commonModel.value = value;
          if (value.status != false) {
            getYourRequestList();
            getSelfRequestList();

            clearAllValue();
            AppUtility.showSuccessSnackBar(value.message);
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
    } catch (e) {
      debugPrint("verifySelfRequestOtp $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future deleteYourRequest({required String requestId}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "id": requestId,
    };

    try {
      var response =
      await p2pTransferRepo.deleteRequest(payload: payload).then((value) {
        if (value != null) {
          commonModel.value = value;
          if (value.status != false) {
            getAllRequestList();


            clearAllValue();
            AppUtility.showSuccessSnackBar(value.message);
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
    } catch (e) {
      debugPrint("verifySelfRequestOtp $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getSelfRequestList() async {
    //  loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
      await p2pTransferRepo.getSelfRequest(payload: payload).then((value) {
        if (value != null) {
          selfRequestListModel.value = value;
          Future.delayed(Duration(seconds: 15), () {
            getSelfRequestList();
          });
          if (value.status != false) {
            // AppUtility.showSuccessSnackBar(value.message);
          } else {
            print("yha aya h");
            // AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
      debugPrint(response);
    } catch (e) {  Future.delayed(Duration(seconds: 15), () {
      getSelfRequestList();
    });
      debugPrint("getSelfRequestList $e");
     // AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
