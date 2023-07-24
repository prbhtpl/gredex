import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/downLineModel/downLineModel.dart';
import '../../screens/auth/loginPage/login_page.dart';
import 'downlineRepo/dwonlineRepo.dart';

class DownLineController extends GetxController {
  RxBool loaderStatus = false.obs;

  RxInt pageAll = 1.obs;
  @override
  void onReady(){
    initData();
    super.onReady();
  }
  initData() {
    getAllDownLine();
    pageAll.value = 1;
  }
  Rxn<String> myDownLineDropDown = Rxn("All");
  final DownLineRepo _downLineRepo = Get.put(DownLineRepo());
  var downLineModel = Rxn<DwonLineModel>();
  Rx<String> selectDropDownValue = "".obs;
  Future<void> getAllDownLine({int pageNumber = 1}) async {
    print("gya");
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "page": pageNumber,
    };
    if (myDownLineDropDown.value != "All") {
      payload["status"] = selectDropDownValue.value;
    }
    try {
      var response =
          await _downLineRepo.getAllDownline(payload: payload).then((value) {

        if (value!=null) {

          downLineModel.value = value; pageAll.value = pageNumber;
        }else{
          downLineModel.value=null;
        }
      });
    } catch (e) {
      debugPrint("getAllDownLine $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
