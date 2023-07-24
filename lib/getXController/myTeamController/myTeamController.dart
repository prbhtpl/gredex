import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/model/teamMemberModel/teamMemberModel.dart';

import '../../Utility/app_utility.dart';
import 'myTeamRepo/myTeamRepo.dart';

class MyTeamController extends GetxController {
  RxBool loaderStatus = false.obs;
  MyTeamRepo myTeamRepo = Get.put(MyTeamRepo());
  var teamMemberModel = Rxn<TeamMemberModel>();
  List<TeamMemberList> teamMemberList = List.empty(growable: true);
  @override
  void onReady(){
    initData();
    super.onReady();
  }

  initData() {
    getTeamMember();
    pageAll.value=1;
  }
  RxInt pageAll = 1.obs;
  Rxn<String> myTeamDropDown = Rxn("All");
  Rx<String> selectDropDownValue = "".obs;

  Future<void> getTeamMember({int pageNumber = 1}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "page": pageNumber,
    };
    if (myTeamDropDown.value != "All") {
      if(myTeamDropDown.value != "Renewal"){
        payload["status"] = selectDropDownValue.value;
      }else{
        payload["renewal"] = selectDropDownValue.value;
      }

    }

    try {
      var response =
          await myTeamRepo.getTeaMember(payload: payload).then((value) {
        if (value != null) {
          teamMemberModel.value = value;
          debugPrint("getTeamMember ${teamMemberModel.value?.totalBusiness}");
       teamMemberList = teamMemberModel.value!.data;
          pageAll.value = pageNumber;
        } else {
          teamMemberList = [];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getTeamMember $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
