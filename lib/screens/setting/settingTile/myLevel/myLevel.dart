import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/commonDecoration.dart';
import '../../../../getXController/myLevelController/myLevelController.dart';
import '../../../../model/allLevelMember/allLevelLeftMemberModel.dart';
import '../../../../model/allLevelMember/allLevelMemberModel.dart';
import '../../../../model/allLevelMember/allLevelRightMemberModel.dart';

class MyLevel extends StatefulWidget {
  const MyLevel({Key? key}) : super(key: key);

  @override
  State<MyLevel> createState() => _MyLevelState();
}

class _MyLevelState extends State<MyLevel> with SingleTickerProviderStateMixin {
  TabController? _controller;



  @override
  void initState() {

    super.initState();

    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppToolbar(
          onPressBackButton: () {
            Navigator.pop(context);
          },
          enableBackArrow: true,
          title: "My Level",
          appColor: Colors.transparent,
        ),
        backgroundColor: AppColor().primaryColor,
        body: GetBuilder<MyLevelController>(
            init: MyLevelController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    height10,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // Creates border
                          color: AppColor().secondPrimaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Total Business",
                            fontSize: 15,
                            textColor: Colors.grey,
                          ),
                          Obx(() => AppText(
                                text:
                                controller.allLevelMemberModel.value?.data.totalbusiness!=null?"\$ ${controller.allLevelMemberModel.value?.data.totalbusiness}":"",
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            AppText(
                              text: "Select Status",
                              fontSize: 15,
                              textColor: Colors.grey,
                            ),
                            height10,
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                items:
                                    ["All", "Active", "Inactive"].map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: Colors.grey.shade400),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Object? res) {
                                  setState(() {
                                    controller.myLevelDropDown.value =
                                        res.toString();
                                  });
                                  if (controller.myLevelDropDown.value ==
                                      "Active") {
                                    controller.selectDropDownValue.value = "1";
                                  } else if (controller.myLevelDropDown.value ==
                                      "Inactive") {
                                    controller.selectDropDownValue.value = "0";
                                  }

                                  controller.getAlMyLevel();
                                  // controller.getAllRightMyLevel();
                                  // controller.getAllMyLeftLevel();
                                  controller.update();
                                },
                                value: controller.myLevelDropDown.value,
                                hint: const Text(
                                  "Select",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  if (controller.pageAll.value != 1) {
                                    controller.getAlMyLevel(
                                        pageNumber:
                                            controller.pageAll.value - 1);
                                  } else {
                                    AppUtility.showErrorSnackBar(
                                        "Page no cannot be less than 1");
                                  }
                                },
                                child: Container(
                                  decoration: CommonDeco().primary,
                                  height: 40,
                                  width: 40,
                                  child: Icon(Icons.arrow_back_ios_new),
                                )),
                            Container(
                              height: 40,
                              width: 40,
                              child: Center(
                                  child: Text(
                                "${controller.pageAll.value}",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            InkWell(
                                onTap: () {
                                  controller.getAlMyLevel(
                                      pageNumber: controller.pageAll.value + 1);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: CommonDeco().primary,
                                  child: Icon(Icons.arrow_forward_ios),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            AppText(
                              text: "Select Level",
                              fontSize: 15,
                              textColor: Colors.grey,
                            ),
                            height10,
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                items: [
                                  "Select",
                                  for (var i = 1; i <= 99; i++) i
                                ].map((value) {
                                  return DropdownMenuItem(
                                    value: value.toString(),
                                    child: Text(
                                      value.toString(),
                                      style: TextStyle(
                                          color: Colors.grey.shade400),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Object? res) {
                                  if (res.toString() == "Select") {
                                    setState(() {
                                      controller.selectLevel.value = null;
                                    });
                                  } else {
                                    setState(() {
                                      controller.selectLevel.value =
                                          res.toString();
                                    });
                                  }

                                  controller.getAlMyLevel();
                                  controller.update();
                                },
                                value: controller.selectLevel.value,
                                hint: const Text(
                                  "Select",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: "Designation",
                          fontSize: 15,
                          textColor: Colors.grey,
                        ),
                        width10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            items: [
                              "Associate",
                              "Manager",
                              "Sr. Manager",
                              "Silver Manager",
                              "Gold Manager",
                              "Diamond Manager",
                              "Platinum Manager",
                              "Iridium Manager",
                              "Director",
                              "Chairman"
                            ].map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey.shade400),
                                ),
                              );
                            }).toList(),
                            onChanged: (Object? res) {
                              setState(() {
                                controller.myDesignationDropDown.value =
                                    res.toString();
                              });
                              /*   if (controller.myLevelDropDown.value ==
                                          "Active") {
                                        controller.selectDropDownValue.value = "1";
                                      } else if (controller.myLevelDropDown.value ==
                                          "Inactive") {
                                        controller.selectDropDownValue.value = "0";
                                      }

                                      controller.getAlMyLevel();
                                      controller.update();*/
                            },
                            value: controller.myDesignationDropDown.value,
                            hint: const Text(
                              "Select",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                        ),
                      ],
                    ),
                    height10,
                    filterWidget(),
                    height10,
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          AppPageLoader(
                            isLoading: controller.loaderStatus.value,
                            enablePullToRefresh: true,
                            onRefresh: () => controller.initData(),
                            child: controller.allLevelLeftMemberModel.value !=
                                    null
                                ? controller.allLevelLeftMemberModel.value !.data.levelData.isNotEmpty
                                    ? ListView.builder(
                                        itemCount:
                                        controller.allLevelLeftMemberModel.value !.data.levelData.length ?? 0,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {


                                          return Obx(() => teamWidget(
                                              controller.allLevelLeftMemberModel.value !.data.levelData[index]));
                                        },
                                      )
                                    : NoData()
                                : NoData(),
                          ),
                          AppPageLoader(
                              isLoading: controller.loaderStatus.value,
                              enablePullToRefresh: true,
                              onRefresh: () => controller.getAllMyLeftLevel(),
                              child: controller.allLevelLeftMemberModel.value !=
                                      null
                                  ?  controller.allLevelLeftMemberModel.value!.data.levelData.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: controller.allLevelLeftMemberModel.value!.data.levelData.length ??
                                              0,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {


                                            return Obx(() => teamLeftWidget(

                                                controller.allLevelLeftMemberModel.value!.data.levelData[index]));
                                          },
                                        )
                                      : NoData()
                                  : NoData()),
                          AppPageLoader(
                              onRefresh: () => controller.getAllRightMyLevel(),
                              isLoading: controller.loaderStatus.value,
                              enablePullToRefresh: true,
                              child:
                                  controller.allLevelRightMemberModel.value !=
                                          null
                                      ? controller.allLevelRightMemberModel
                                              .value!.data.levelData.isNotEmpty
                                          ? ListView.builder(
                                              itemCount: controller
                                                      .allLevelRightMemberModel
                                                      .value!
                                                      .data
                                                      .levelData
                                                      .length ??
                                                  0,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Obx(() =>
                                                    teamRightWidget(controller
                                                        .allLevelRightMemberModel
                                                        .value!
                                                        .data
                                                        .levelData[index]));
                                              },
                                            )
                                          : NoData()
                                      : NoData())
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Widget teamWidget(LeftLevelDatum levelData) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor().secondPrimaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        colors: [
                          AppColor().purple,
                          AppColor().themeColors,
                          AppColor().themeColors,
                        ]),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: levelData != null ? levelData.name : "N/A",
                      fontSize: 18,
                    ),
                    AppText(
                      text: levelData != null
                          ? "\$${levelData.business}"
                          : "N/A",
                      fontSize: 15,
                    ),
                  ],
                )),
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: "User Id",
                        fontSize: 15,
                      ),
                      height10,
                      const AppText(
                        text: "Id Status",
                        fontSize: 15,
                      ),
                      /*height10,
                      const AppText(
                        text: "Designation",
                        fontSize: 15,
                      ),*/
                      height10,
                      const AppText(
                        text: "Date Time",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        text: levelData != null
                            ? levelData.username
                            : "N/A",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: levelData != null
                            ? levelData.status == 1
                                ? "Active"
                                : "Inactive"
                            : "N/A",
                        fontSize: 15,
                        textColor: levelData != null
                            ? levelData.status == 1
                                ? AppColor().green
                                : AppColor().red
                            : null,
                      ),
                      /*height10,
                      AppText(
                        text: levelData != null
                            ? levelData[index].de
                            : "N/A",
                        fontSize: 15,
                      ),*/
                      height10,
                      AppText(
                        text: levelData != null
                            ? AppUtility.parseDate(levelData.createdAt)
                            : "N/A",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget teamLeftWidget(LeftLevelDatum levelData) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor().secondPrimaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        colors: [
                          AppColor().purple,
                          AppColor().themeColors,
                          AppColor().themeColors,
                        ]),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: levelData != null ? levelData.name : "N/A",
                      fontSize: 18,
                    ),
                    AppText(
                      text: "",
                      fontSize: 15,
                    ),
                  ],
                )),
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "User Id",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Tree Position",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Id Status",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Date Time",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        text: levelData != null
                            ? levelData.username
                            : "N/A",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Left",
                        fontSize: 15,
                        textColor: AppColor().red,
                      ),
                      height10,
                      AppText(
                        text: levelData != null
                            ? levelData.status == 1
                                ? "Active"
                                : "Inactive"
                            : "N/A",
                        fontSize: 15,
                        textColor: levelData != null
                            ?levelData.status == 1
                                ? AppColor().green
                                : AppColor().red
                            : null,
                      ),
                      height10,
                      AppText(
                        text: levelData != null
                            ? AppUtility.parseDate(levelData.createdAt)
                            : "N/A",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget teamRightWidget(RightLevelDatum levelData) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor().secondPrimaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        colors: [
                          AppColor().purple,
                          AppColor().themeColors,
                          AppColor().themeColors,
                        ]),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: levelData != null ? levelData.name : "N/A",
                      fontSize: 18,
                    ),
                    AppText(
                      text: "",
                      fontSize: 15,
                    ),
                  ],
                )),
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "User Id",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Tree Position",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Id Status",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Date Time",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        text: levelData != null ? levelData.username : "N/A",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Right",
                        fontSize: 15,
                        textColor: AppColor().red,
                      ),
                      height10,
                      AppText(
                        text: levelData != null
                            ? levelData.status == 1
                                ? "Active"
                                : "Inactive"
                            : "N/A",
                        fontSize: 15,
                        textColor: levelData != null
                            ? levelData.status == 1
                                ? AppColor().green
                                : AppColor().red
                            : null,
                      ),
                      height10,
                      AppText(
                        text: levelData != null
                            ? AppUtility.parseDate(levelData.createdAt)
                            : "N/A",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );

  filterWidget() {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: TabBar(
            controller: _controller,
            indicatorWeight: 0,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5), // Creates border
                color: AppColor().oldThemeColors),
            tabs: [
              Tab(
                icon: AppText(
                  text: "All",
                  fontSize: 15,
                ),
              ),
              Tab(
                  icon: AppText(
                text: "Left Position",
                fontSize: 12,
              )),
              Tab(
                  icon: AppText(
                text: "Right Position",
                fontSize: 12,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
