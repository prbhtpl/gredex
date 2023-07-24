import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/allLevelMember/allLevelLeftMemberModel.dart';
import '../../model/allLevelMember/allLevelMemberModel.dart';
import '../../model/allLevelMember/allLevelRightMemberModel.dart';
import '../../screens/auth/loginPage/login_page.dart';
import 'myLevelRepo/myLevelRepo.dart';

class MyLevelController extends GetxController {
  RxBool loaderStatus = false.obs;
  var allLevelMemberModel = Rxn<AllLevelMemberModel>();
  var allLevelLeftMemberModel = Rxn<AllLevelLeftMemberModel>();
  var allLevelRightMemberModel = Rxn<AllLevelrightMemberModel>();

  Rxn<String> myLevelDropDown = Rxn("All");
  Rxn<String> myDesignationDropDown = Rxn("Associate");
  Rxn<String> selectLevel = Rxn();
  Rx<String> selectDropDownValue = "".obs;
  RxInt pageAll = 1.obs;
  RxInt pageLeft = 1.obs;
  RxInt pageRight = 1.obs;
  @override
  void onReady(){
    initData();
    super.onReady();
  }
  final MyLevelRepo _myLevelRepo = Get.put(MyLevelRepo());

  initData() {
    pageAll.value = 1;
    pageLeft.value = 1;
    pageRight.value = 1;
    myLevelDropDown.value="All";

    getAlMyLevel();
  }

  Future<void> getAlMyLevel({int pageNumber = 1}) async {
    loaderStatus.value = true;
    update();

    Map<String, dynamic> payload = {
      "page": pageNumber,
    };
    if (selectLevel.value != null) {
      payload["level"] = selectLevel.value;
    }
    if (myLevelDropDown.value != "All") {
      payload["status"] = selectDropDownValue.value;
    }

    try {
      var response =
          await _myLevelRepo.getAllLevelMember(payload: payload).then((value) {
        if (value != null) {

          print("Call Hua");
          debugPrint("allTransactionHistory: ${value.data.toString()}");
          allLevelMemberModel.value = value;
          pageAll.value=pageNumber;


          getAllMyLeftLevel();
        } else {
          allLevelMemberModel.value=null;
          pageAll.value=pageNumber;
          getAllMyLeftLevel();
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("getAlMyLevel: ${e.toString()}");
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getAllMyLeftLevel({int pageNumber = 1}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "position": "L",
      "page":  pageAll.value,
    };
    if (selectLevel.value != null) {
      payload["level"] = selectLevel.value;
    }
    if (myLevelDropDown.value != "All") {
      payload["status"] = selectDropDownValue.value;
    }
    try {
      var response = await _myLevelRepo
          .getAllLeftLevelMember(payload: payload)
          .then((value) {
        if (value != null) {
          allLevelLeftMemberModel.value = value;
          getAllRightMyLevel();
        } else {
          allLevelLeftMemberModel.value=null;

          getAllRightMyLevel();
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("getAllMyLeftLevel: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> getAllRightMyLevel({int pageNumber = 1}) async {
    //  loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "position": "R",
      "page":  pageAll.value,
    };
    if (selectLevel.value != null) {
      payload["level"] = selectLevel.value;
    }
    if (myLevelDropDown.value != "All") {
      payload["status"] = selectDropDownValue.value;
    }
    try {
      var response = await _myLevelRepo
          .getAllRightLevelMember(payload: payload)
          .then((value) {
        if (value != null) {
          allLevelRightMemberModel.value = value;
        //  rightLevelList = rightLevelList + value.data.levelData;
          update();
        } else {
          allLevelRightMemberModel.value=null;
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("getAllRightMyLevel: ${e.toString()}");
    }
    // loaderStatus.value = false;
    update();
  }
}
