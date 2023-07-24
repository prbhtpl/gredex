import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/commonDecoration.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../Utility/app_utility.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';
import '../../../../getXController/binaryTreeController/binaryTreeController.dart';
import '../../../../model/binaryTreeModel/binaryTreeLeftModel.dart';
import '../../../../model/binaryTreeModel/binaryTreeModel.dart';
import '../../../../model/binaryTreeModel/binaryTreeRightModel.dart';

class BinaryReport extends StatefulWidget {
  BinaryReport({Key? key}) : super(key: key);

  @override
  State<BinaryReport> createState() => _BinaryReportState();
}

class _BinaryReportState extends State<BinaryReport> {
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller
          ?.animateTo(
        _controller!.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      )
          .then((value) async {
        await Future.delayed(Duration(seconds: 2));
        _controller!.animateTo(
          _controller!.position.minScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.ease,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BinaryTreeController>(
        init: BinaryTreeController(),
        //  initState: BinaryTreeController().initData(),
        builder: (controller) {
          var data = controller.binaryTreeModel.value?.data;
          var leftSecond = controller.binaryTreeLeftSecondModel.value?.data;
          var rightSecond = controller.binaryTreeRightSecondModel.value?.data;

          return Scaffold(
            appBar: AppToolbar(
              actionIcon: IconButton(
                  onPressed: () {
                    controller.initData();
                    controller.clickedUser = [];
                  },
                  icon: Icon(
                    Icons.lock_reset,
                    color: AppColor().green,
                  )),
              onPressBackButton: () {
                Navigator.pop(context);
              },
              enableBackArrow: true,
              title: "Binary Report",
              appColor: Colors.transparent,
            ),
            backgroundColor: AppColor().secondPrimaryColor,
            body: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              enablePullToRefresh: true,
              onRefresh: () => controller.initData(),
              child: SingleChildScrollView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Container(
                      color: AppColor().secondPrimaryColor,
                      width: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            text: controller.headIDString.value,
                            fontSize: 12,
                          ),
                          Center(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: CommonDeco().primary,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                )),
                          ),
                          treeRow(
                              data: data,
                              divisibleWidth: 3,
                              controller: controller),
                          Row(
                            children: [
                              Expanded(
                                  child: secondLevelLeftRow(
                                      controller: controller,
                                      data: leftSecond,
                                      divisibleWidth: 4)),
                              Expanded(
                                  child: secondLevelRightRow(
                                      controller: controller,
                                      data: rightSecond,
                                      divisibleWidth: 4)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    EdgeInsets.only(bottom: 20, right: 60)),
                            onPressed: () {
                              if (controller.clickedUser.reversed.length > 1) {
                                /*for (var i = 0; i <controller.clickedUser.length; i++) {*/
                                controller.firstClick
                                    ? controller.clickedUser.removeLast()
                                    : null;
                                setState(() {
                                  controller.firstClick = false;
                                });
                                controller.getTreeData(
                                    id: controller.clickedUser[
                                        controller.clickedUser.length - 1]);
                                controller.clickedUser.removeLast();
                                print("${controller.clickedUser}");

                                /* }*/
                              } else {
                                controller.initData();
                              }
                            },
                            child: Text("Step back")),
                        Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: AppColor().secondPrimaryColor,
                          width: Get.width / 1.5,
                          child: AppInputContainer(
                            inputType: TextInputType.number,
                            prefixWidget: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: SizedBox(
                                width: 50,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: 35,
                                        height: 20,
                                        child: AppText(
                                          text: "GDX",
                                          fontSize: 15,
                                          textColor: Colors.white70,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            suffixWidget: TextButton(
                              onPressed: () {
                                if (controller.search.value.text.isNotEmpty) {
                                  controller.getTreeData(
                                      id: "GDX" + controller.search.value.text);
                                } else {
                                  AppUtility.showErrorSnackBar(
                                      "Search cannot be empty");
                                }
                              },
                              child: const Text("Search"),
                            ),
                            textBackgroundColor: Colors.white.withOpacity(0.3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            placeholder: "Search",
                            maxLines: 1,
                            textCapitalization: TextCapitalization.words,
                            controller: controller.search.value,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget treeRow(
      {required List<Datum>? data,
      required int divisibleWidth,
      BinaryTreeController? controller}) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data != null ? data.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return data!.length == 2
                    ? data[index].position == "L"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: data[index].name,
                                fontSize: 12,
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                    : data[index].position == "L"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: data[index].name,
                                fontSize: 12,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "No User",
                                fontSize: 12,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "",
                                fontSize: 12,
                              ),
                            ],
                          );
              }),
        ),
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data != null ? data.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return data!.length == 2
                    ? data[index].position == "R"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: data[index].name,
                                fontSize: 12,
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                    : data[index].position == "R"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: data[index].name,
                                fontSize: 12,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "No User",
                                fontSize: 12,
                              ),
                              AppText(
                                text: "",
                                fontSize: 12,
                              ),
                            ],
                          );
              }),
        )
      ],
    );
  }

  Widget secondLevelLeftRow(
      {required List<LeftTree>? data,
      required int divisibleWidth,
      BinaryTreeController? controller}) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data != null ? data.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return data!.length == 2
                    ? data[index].position == "L"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: "${data[index].name}",
                                fontSize: 12,
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                    : data[index].position == "L"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: "${data[index].name}",
                                fontSize: 12,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "No User",
                                fontSize: 12,
                              ),
                              AppText(
                                text: "",
                                fontSize: 12,
                              ),
                            ],
                          );
              }),
        ),
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data != null ? data.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return data!.length == 2
                    ? data[index].position == "R"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: "${data[index].name}",
                                fontSize: 12,
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                    : data[index].position == "R"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: data[index].name,
                                fontSize: 12,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "No User",
                                fontSize: 12,
                              ),
                              AppText(
                                text: "",
                                fontSize: 12,
                              ),
                            ],
                          );
              }),
        )
      ],
    );
  }

  Widget secondLevelRightRow(
      {required List<RightTree>? data,
      required int divisibleWidth,
      BinaryTreeController? controller}) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data != null ? data.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return data!.length == 2
                    ? data[index].position == "L"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: "${data[index].name}",
                                fontSize: 12,
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                    : data[index].position == "L"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: "${data[index].name}",
                                fontSize: 12,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width / divisibleWidth),
                                child: Image.asset("assets/leftTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "No User",
                                fontSize: 12,
                              ),
                              AppText(
                                text: "",
                                fontSize: 12,
                              ),
                            ],
                          );
              }),
        ),
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data != null ? data.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return data!.length == 2
                    ? data[index].position == "R"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: "${data[index].name}",
                                fontSize: 12,
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                    : data[index].position == "R"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  controller?.getTreeData(
                                      id: data[index].username);
                                  controller?.clickedUser
                                      .add(data[index].username);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: data[index].activMember == 0
                                                ? Colors.red
                                                : AppColor().highLightColor),
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: data[index].username,
                                fontSize: 12,
                              ),
                              AppText(
                                text: data[index].name,
                                fontSize: 12,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Get.width / divisibleWidth),
                                child: Image.asset("assets/rightTree.png"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "No User",
                                fontSize: 12,
                              ),
                              AppText(
                                text: "",
                                fontSize: 12,
                              ),
                            ],
                          );
              }),
        )
      ],
    );
  }
}

///don't touch

// Widget build(BuildContext context) {
//   return GetBuilder<BinaryTreeController>(
//       init: BinaryTreeController(),
//       builder: (controller) {
//         var data = controller.binaryTreeModel.value?.data;
//
//         return Scaffold(
//           appBar: AppToolbar(
//             onPressBackButton: () {
//               Navigator.pop(context);
//             },
//             enableBackArrow: true,
//             title: "Binary Report",
//             appColor: Colors.transparent,
//           ),
//           backgroundColor: AppColor().primaryColor,
//           body: AppPageLoader(
//             isLoading: controller.loaderStatus.value,
//             enablePullToRefresh: true,
//             onRefresh: () => controller.initData(),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   controller: _controller,
//                   scrollDirection: Axis.horizontal,
//                   child: Container(
//                     height: 400,
//                     width: 600,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         AppText(
//                           text: controller.homePageController
//                               .allUserProfileData.value?.data.username,
//                           fontSize: 12,
//                         ),
//                         Center(
//                           child: Container(
//                               height: 40,
//                               width: 40,
//                               decoration: CommonDeco().primary,
//                               child: Icon(
//                                 Icons.person,
//                                 color: Colors.blue,
//                               )),
//                         ),
//                         treeRow(data: data, divisibleWidth: 3),
//                         Row(
//                           children: [
//                             Expanded(
//                                 child: Column(
//                                   children: [
//                                     secondLevelRow(data: data, divisibleWidth: 4),
//                                     /*  Row(
//                                         children: [
//                                           Expanded(
//                                               child: treeRow(
//                                                   data: data, divisibleWidth: 15)),
//                                           Expanded(
//                                               child: treeRow(
//                                                   data: data, divisibleWidth: 15)),
//                                         ],
//                                       )*/
//                                   ],
//                                 )),
//                             Expanded(
//                                 child: Column(
//                                   children: [
//                                     secondLevelRow(data: data, divisibleWidth: 4),
//                                     /* Row(
//                                         children: [
//                                           Expanded(
//                                               child: treeRow(
//                                                   data: data, divisibleWidth: 15)),
//                                           Expanded(
//                                               child: treeRow(
//                                                   data: data, divisibleWidth: 15)),
//                                         ],
//                                       )*/
//                                   ],
//                                 )),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       });
// }
