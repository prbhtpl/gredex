import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/appText.dart';
import '../../commonWidget/commonDecoration.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/binaryTreeModel/binaryTreeLeftModel.dart';
import '../../model/binaryTreeModel/binaryTreeModel.dart';
import '../../model/binaryTreeModel/binaryTreeRightModel.dart';
import '../../screens/auth/loginPage/login_page.dart';
import 'binaryTreeRepo/binaryTreeRepo.dart';

class BinaryTreeController extends GetxController {
  RxBool loaderStatus = false.obs;
  Rx<String> headIDString = "".obs;
  Rx<TextEditingController> search = TextEditingController().obs;
  List clickedUser=List.empty(growable: true);
  bool firstClick=true;



  final BinaryTreeRepo _binaryTreeRepo = Get.put(BinaryTreeRepo());
  final HomePageController homePageController = Get.put(HomePageController());
  @override
  void onReady(){
    initData();
    super.onReady();
  }
  initData() {
    getTreeData(id: homePageController.allUserProfileData.value!.data.username);
  }

  var binaryTreeModel = Rxn<BinaryTreeModel>();
  var binaryTreeLeftSecondModel = Rxn<BinaryTreeLeftModel>();
  var binaryTreeRightSecondModel = Rxn<BinaryTreeRightModel>();

  int count = 0;

  Future<void> getTreeData({String id = ""}) async {
    loaderStatus.value = true;

    update();

    Map<String, dynamic> payload = {"username": id};
    try {
      var response = await _binaryTreeRepo
          .getBinaryData(payload: payload)
          .then((value) async {
        // AppUtility.showSuccessSnackBar(value.message.toString());

        if(value!=null){

        if (value.data.isNotEmpty) {
          if (value != null) {
            headIDString.value = id;
            // clickedUser.add(id);
            search.value.clear();
            print("clickedUser ${clickedUser.toString()}");
            binaryTreeModel.value = null;
            binaryTreeLeftSecondModel.value = null;
            binaryTreeRightSecondModel.value = null;
            binaryTreeModel.value = value;

            if (binaryTreeModel.value?.data[0].position == "L") {
              print("binary  tree 0 index L");
              Map<String, dynamic> payload1 = {
                "username": binaryTreeModel.value?.data[0].username
              };
              var response = await _binaryTreeRepo
                  .getLeftSecondBinaryData(payload: payload1)
                  .then((value) {
                if (value != null) {
                  binaryTreeLeftSecondModel.value = value;
                }
              });
            } else {
              print("binary  tree 0 index R");
              Map<String, dynamic> payload1 = {
                "username": binaryTreeModel.value?.data[0].username
              };
              var response = await _binaryTreeRepo
                  .getRightSecondBinaryData(payload: payload1)
                  .then((value) {
                if (value != null) {
                  binaryTreeRightSecondModel.value = value;
                }
              });
            }

            if (binaryTreeModel.value?.data.length == 2) {
              if (binaryTreeModel.value?.data[1].position == "R") {
                print("binary  tree 1 index R");
                Map<String, dynamic> payload1 = {
                  "username": binaryTreeModel.value?.data[1].username
                };
                var response = await _binaryTreeRepo
                    .getRightSecondBinaryData(payload: payload1)
                    .then((value) {
                  if (value != null) {
                    binaryTreeRightSecondModel.value = value;
                  }
                });
              } else {
                print("binary  tree 1 index L");
                Map<String, dynamic> payload1 = {
                  "username": binaryTreeModel.value?.data[1].username
                };
                var response = await _binaryTreeRepo
                    .getLeftSecondBinaryData(payload: payload1)
                    .then((value) {
                  if (value != null) {
                    binaryTreeLeftSecondModel.value = value;
                  }
                });
              }
            }
          } else {}
        } else {
          AppUtility.showSuccessSnackBar(value.message.toString());
        }
      }else{
          AppUtility.showSuccessSnackBar(value.message.toString());
        }});
    } catch (e) {
     // AppUtility.showErrorSnackBar(e.toString());
      debugPrint("getTreeData: ${e.toString()}");
    }
    loaderStatus.value = false;

    update();
  }
}
