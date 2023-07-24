import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/getXController/myTeamController/myTeamController.dart';
import 'package:gredex/model/teamMemberModel/teamMemberModel.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_page_loader.dart';
import '../../../../commonWidget/commonDecoration.dart';
import '../../../../commonWidget/noData.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({Key? key}) : super(key: key);

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> with SingleTickerProviderStateMixin {
  TabController? _controller;


  @override
  void initState() {

    super.initState();

    _controller = TabController(length: 3, vsync: this);
  }





  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTeamController>(
      init: MyTeamController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "My Team",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                height10,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), // Creates border
                      color: AppColor().secondPrimaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Total Balance",
                        fontSize: 15,
                        textColor: Colors.grey,
                      ),
                      AppText(
                        text:
                            "\$${controller.teamMemberModel.value?.totalBusiness}",
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: "Select Status",
                          fontSize: 15,
                          textColor: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            items: ["All", "Renewal", "Active", "Inactive"]
                                .map((value) {
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
                                controller.myTeamDropDown.value =
                                    res.toString();
                              });
                              if (controller.myTeamDropDown.value == "Active") {
                                controller.selectDropDownValue.value = "1";
                              } else if (controller.myTeamDropDown.value ==
                                  "Inactive") {
                                controller.selectDropDownValue.value = "0";
                              } else if (controller.myTeamDropDown.value ==
                                  "Renewal") {
                                controller.selectDropDownValue.value = "1";
                              }

                              controller.getTeamMember();
                              controller.update();
                            },
                            value: controller.myTeamDropDown.value,
                            hint: const Text(
                              "Select",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                            onTap: () {
                              if (controller.pageAll.value != 1) {
                                controller.getTeamMember(
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
                              controller.getTeamMember(
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
                        child: controller.teamMemberList.isNotEmpty
                            ? ListView.builder(

                                itemCount: controller.teamMemberList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return teamWidget(
                                      controller.teamMemberList[index]);
                                },
                              )
                            : const NoData(),
                      ),
                      AppPageLoader(
                        isLoading: controller.loaderStatus.value,
                        enablePullToRefresh: true,
                        onRefresh: () => controller.initData(),
                        child: controller.teamMemberList.isNotEmpty
                            ? ListView.builder(

                                itemCount: controller.teamMemberList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return controller
                                              .teamMemberList[index].position ==
                                          "L"
                                      ? teamWidgetLeft(
                                          controller.teamMemberList[index])
                                      : const SizedBox();
                                },
                              )
                            : const NoData(),
                      ),
                      AppPageLoader(
                        isLoading: controller.loaderStatus.value,
                        enablePullToRefresh: true,
                        onRefresh: () => controller.initData(),
                        child: controller.teamMemberList.isNotEmpty
                            ? ListView.builder(

                                itemCount: controller.teamMemberList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return controller
                                              .teamMemberList[index].position ==
                                          "R"
                                      ? teamWidgetRight(
                                          controller.teamMemberList[index])
                                      : const SizedBox();
                                },
                              )
                            : const NoData(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget teamWidget(TeamMemberList teamMemberList) {
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: teamMemberList.name,
                      fontSize: 18,
                    ),
                    AppText(
                      text: teamMemberList.amount.totalamount.toString(),
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
                        text: teamMemberList.username,
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: teamMemberList.position == "L" ? "Left" : "Right",
                        fontSize: 15,
                        textColor: AppColor().red,
                      ),
                      height10,
                      AppText(
                        text: teamMemberList.activMember == 0
                            ? "Inactive"
                            : "Active",
                        fontSize: 15,
                        textColor: teamMemberList.activMember == 0
                            ? AppColor().red
                            : AppColor().green,
                      ),
                      height10,
                      AppText(
                        text: AppUtility.parseDate(
                            teamMemberList.amount.createdAt),
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

  Widget teamWidgetLeft(TeamMemberList teamMemberList) {
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: teamMemberList.name,
                      fontSize: 18,
                    ),
                    AppText(
                      text: teamMemberList.amount.totalamount.toString(),
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
                        text: teamMemberList.username,
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: teamMemberList.position == "L" ? "Left" : "Right",
                        fontSize: 15,
                        textColor: AppColor().red,
                      ),
                      height10,
                      AppText(
                        text: teamMemberList.activMember == 0
                            ? "Inactive"
                            : "Active",
                        fontSize: 15,
                        textColor: teamMemberList.activMember == 0
                            ? AppColor().red
                            : AppColor().green,
                      ),
                      height10,
                      AppText(
                        text: AppUtility.parseDate(
                            teamMemberList.amount.createdAt),
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

  Widget teamWidgetRight(TeamMemberList teamMemberList) {
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: teamMemberList.name,
                      fontSize: 18,
                    ),
                    AppText(
                      text: teamMemberList.amount.totalamount.toString(),
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
                        text: teamMemberList.username,
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: teamMemberList.position == "L" ? "Left" : "Right",
                        fontSize: 15,
                        textColor: teamMemberList.position == "L"
                            ? AppColor().red
                            : AppColor().highLightColor,
                      ),
                      height10,
                      AppText(
                        text: teamMemberList.activMember == 0
                            ? "Inactive"
                            : "Active",
                        fontSize: 15,
                        textColor: teamMemberList.activMember == 0
                            ? AppColor().red
                            : AppColor().highLightColor,
                      ),
                      height10,
                      AppText(
                        text: AppUtility.parseDate(
                            teamMemberList.amount.createdAt),
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
