import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/Utility/app_utility.dart';

import 'package:gredex/commonWidget/noData.dart';

import 'package:gredex/screens/myPlan/externalRequest/externalRequest.dart';
import 'package:gredex/screens/myPlan/totalDepositBalance/totalDepositBalance.dart';
import 'package:gredex/screens/setting/settingTile/withdrawl/withdrawlAmount.dart';
import 'package:page_transition/page_transition.dart';

import '../../Utility/app_toolbar.dart';
import '../../commonWidget/appColors.dart';
import '../../commonWidget/appText.dart';
import '../../commonWidget/app_page_loader.dart';
import '../../getXController/activationHistoryController/activationHistoryController.dart';
import '../../getXController/homePageController/homePageController.dart';
import 'activateAccount/activateAccount.dart';

class MyPlans extends StatefulWidget {
  const MyPlans({Key? key}) : super(key: key);

  @override
  State<MyPlans> createState() => _MyPlansState();
}

class _MyPlansState extends State<MyPlans> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
  }

  bool isSwitchOn = false;
  TabController? _controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColor().primaryColor,
            appBar: AppToolbar(
              appColor: Colors.transparent,
              title:
                  "My Plans (${controller.allUserProfileData.value?.data.username})",
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  idStatusWidget(),
                  SizedBox(
                    height: 30,
                    child: TabBar(
                      controller: _controller,
                      indicatorWeight: 0,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // Creates border
                          color: AppColor().oldThemeColors),
                      tabs: [
                        Tab(
                          icon: AppText(
                            text: "My Activation History",
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height10,
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [teamWidget()],
                    ),
                  ),
                  height10,
                ],
              ),
            ),
          );
        });
  }

  Widget teamWidget() {
    return GetBuilder<ActivationHistoryController>(
        init: ActivationHistoryController(),
        builder: (controller) {
          var data = controller.renewalModel.value?.data ?? [];
          return AppPageLoader(
            onRefresh: () => ActivationHistoryController().initData(),
            isLoading: controller.loaderStatus.value,
            enablePullToRefresh: true,
            child: data.isNotEmpty
                ? ListView.builder(
                    itemCount: data != null ? data.length : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var dataItem = data;
                      return data.isNotEmpty
                          ? Container(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: const FractionalOffset(
                                                  0.0, 0.0),
                                              end: const FractionalOffset(
                                                  1.0, 0.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const AppText(
                                            text: "Plan Amount",
                                            fontSize: 15,
                                          ),
                                          AppText(
                                            text: dataItem != null
                                                ? "\$${dataItem[index].amount}"
                                                : "N/A",
                                            fontSize: 15,
                                          ),
                                        ],
                                      )),
                                  height10,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            dataItem[index].status == 1
                                                ? AppText(
                                                    text: "GDX",
                                                    fontSize: 15,
                                                  )
                                                : SizedBox(),
                                            height10,
                                            const AppText(
                                              text: "Amount Type",
                                              fontSize: 15,
                                            ),
                                            height10,
                                            const AppText(
                                              text: "Activation Status",
                                              fontSize: 15,
                                            ),
                                            height10,
                                            const AppText(
                                              text: "Date Time",
                                              fontSize: 15,
                                            ),
                                            height10,
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            dataItem[index].status == 1
                                                ? AppText(
                                                    text: dataItem != null
                                                        ? dataItem[index].gdx
                                                        : "N/A",
                                                    fontSize: 15,
                                                  )
                                                : SizedBox(),
                                            height10,
                                            AppText(
                                              text: "External Wallet",
                                              fontSize: 15,
                                              textColor: AppColor().textOrange,
                                            ),
                                            height10,
                                            AppText(
                                              text: dataItem[index].status == 0
                                                  ? "Renewal"
                                                  : "Active",
                                              fontSize: 15,
                                              textColor:
                                                  dataItem[index].status == 0
                                                      ? AppColor()
                                                          .highLightColor
                                                      : AppColor().textOrange,
                                            ),
                                            height10,
                                            AppText(
                                              text: dataItem != null
                                                  ? AppUtility.parseDate(
                                                      dataItem[index].createdAt)
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
                              ))
                          : const NoData();
                    },
                  )
                : NoData(),
          );
        });
  }

  String? choose;

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );

  Widget idStatusWidget() {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          var data = controller.allUserProfileData.value;
          String textSting = "";
          Color borderColor;
          if (data?.data.activMember == 0) {
            textSting = "Inactive";
            borderColor = const Color(0xff000000);
          } else if (data?.data.activMember == 1) {
            textSting = "Active";
            borderColor = const Color(0xff008000);
          } else if (data?.data.activMember == 2) {
            textSting = "Renewal";
            borderColor = const Color(0xff00B9E8);
          } else {
            textSting = "Booster";
            borderColor = const Color(0xffffa500);
          }
          return Container(
            decoration: BoxDecoration(
                color: AppColor().secondPrimaryColor,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.only(bottom: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          colors: [
                            AppColor().primaryColor,
                            AppColor().secondPrimaryColor
                          ]),
                      // color: AppColor().primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AppText(
                        text: "ID Status",
                        fontSize: 18,
                      ),
                      controller.userTimeModel.value?.data.dataStatus == 0
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "( Booster Pending",
                                  fontSize: 12,
                                  textColor: AppColor().red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text:
                                      "${controller.userTimeModel.value?.data.day} Days )",
                                  fontSize: 12,
                                )
                              ],
                            )
                          : SizedBox(),
                      controller.userTimeModel.value?.data.dataStatus == 1
                          ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Booster Completed",
                            fontSize: 12,
                            textColor: AppColor().green,
                          ),

                        ],
                      )
                          : SizedBox(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white70.withOpacity(0.2)),
                            color: borderColor,
                            //const Color(0xff00C6D8),
                            borderRadius: BorderRadius.circular(25)),
                        child: AppText(
                          text: textSting,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                height10,
                Row(
                  children: [
                    Expanded(
                        child: detailBox(
                            title: "Fund Request",
                            onClick: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(seconds: 1),
                                      type: PageTransitionType.fade,
                                      child: ExternalRequest()));
                            })),
                    Expanded(
                        child: detailBox(
                            title: "Activate Account",
                            onClick: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(seconds: 1),
                                      type: PageTransitionType.fade,
                                      child: ActivateAccount()));
                            })),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: detailBox(
                            title: "Withdrawal",
                            onClick: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(seconds: 1),
                                      type: PageTransitionType.fade,
                                      child: WithdrawnAmount()));
                            })),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget detailBox({String title = '', GestureTapCallback? onClick}) {
    return InkWell(
      onTap: onClick,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor().primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText(
                  text: title,
                  fontSize: 13,
                ),
              ),
              Icon(
                CupertinoIcons.forward,
                color: Colors.white70,
              ),

              // Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     decoration: BoxDecoration(
              //         color: AppColor().oldThemeColors,
              //         borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(10),
              //           bottomRight: Radius.circular(10),
              //         )),
              //     child: Icon(bottomIcon!??Icons.wallet,size: 20,)
              // ),
            ],
          )),
    );
  }
}
