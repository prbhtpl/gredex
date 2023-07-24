import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';

import '../../Utility/app_toolbar.dart';
import '../../commonWidget/appColors.dart';
import '../../commonWidget/appText.dart';
import '../../getXController/homePageController/homePageController.dart';
import '../../utils.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColor().primaryColor,
            appBar: AppToolbar(
              appColor: Colors.transparent,
              title: "Status (${controller.allUserProfileData.value?.data.username})",
            ),
            body: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              onRefresh: () => controller.initData(),
              enablePullToRefresh: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      incomeDetailWidget(),
                      teamDetails(),
                      businessDetail()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget businessDetail() {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          var data = controller.allUserProfileData.value?.data;
          var dashboardData = controller.allDashboardData.value?.data;

          return AppPageLoader(
              isLoading: controller.loaderStatus.value,
              onRefresh: () => controller.initData(),
              enablePullToRefresh: true,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor().secondPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(bottom: 8.0),
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              colors: [
                                AppColor().secondPrimaryColor,
                                AppColor().primaryColor,
                              ]),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AppText(
                            text: "Business Details",
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    height10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        businessDetails(
                            title: "Today Left Business",
                            income:
                                "\$ ${dashboardData?.todayleftBusiness ?? 0}",
                            bottomIcon: Icons.business),
                        businessDetails(
                            title: "Today Right Business",
                            income:
                                "\$ ${dashboardData?.todayrightBusiness ?? 0}",
                            bottomIcon: Icons.business),
                      ],
                    ),
                    Column(
                      children: [
                        businessDetails(
                            title: "Direct Business",
                            income:
                                "\$ ${data?.directBusiness.toStringAsFixed(2) ?? 0}",
                            bottomIcon: Icons.business),
                        businessDetails(
                            title: "Sponsor Business",
                            income:
                                "\$ ${dashboardData?.sponsorBusiness.toStringAsFixed(2) ?? 0}",
                            bottomIcon: Icons.business),
                      ],
                    ),
                    Column(
                      children: [
                        businessDetails(
                            title: "Left Business",
                            income: data != null
                                ? "\$  ${data.totalLeftPv.toStringAsFixed(2)}"
                                : "N/A",
                            bottomIcon: Icons.business),
                        businessDetails(
                            title: "Right Business",
                            income: data != null
                                ? "\$  ${data.totalRightPv.toStringAsFixed(2)}"
                                : "N/A",
                            bottomIcon: Icons.business),
                      ],
                    ),
                    Column(
                      children: [
                        businessDetails(
                            title: "My Business",
                            income:
                                "\$  ${dashboardData?.selfbusinessprice.toStringAsFixed(2) ?? 0}",
                            bottomIcon: Icons.business),
                        businessDetails(
                            title: "Total Business",
                            income: data != null
                                ? "\$ ${(data.totalLeftPv + data.totalRightPv).toStringAsFixed(2)}"
                                : "N/A",
                            bottomIcon: Icons.business),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }

  Widget teamDetails() {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          var data = controller.allUserProfileData.value?.data;
          var dashboardData = controller.allDashboardData.value?.data;

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          colors: [
                            AppColor().secondPrimaryColor,
                            AppColor().primaryColor,
                          ]),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AppText(
                        text: "Team Details",
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                height10,
                Row(
                  children: [
                    Expanded(
                        child: teamWidget(
                            title: "0",
                            income: "${data?.totalLeftPv.toStringAsFixed(2)}",
                            active:
                                "${dashboardData?.leftActivemember.toStringAsFixed(0)}",
                            deActive:
                                "${dashboardData?.allbusiness.uleftcount.toStringAsFixed(0)}",
                            teamName: "Left Team",
                            labelColor: AppColor().red,
                            imageString: "assets/left.png")),
                    Expanded(
                        child: teamWidget(
                            title: "0",
                            active:
                                "${dashboardData?.rightActivemember.toStringAsFixed(0)}",
                            deActive:
                                "${dashboardData?.allbusiness.urightcount.toStringAsFixed(0)}",
                            income: "${data?.totalRightPv.toStringAsFixed(2)}",
                            teamName: "Right Team",
                            labelColor: AppColor().green,
                            imageString: "assets/right.png")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: teamWidget(
                            title: "0",
                            income:"${data?.directBusiness.toStringAsFixed(2)}",
                            teamName: "Direct Team",
                            active:
                                "${dashboardData?.directactive.toStringAsFixed(0)}",
                            deActive:
                                "${dashboardData?.directtotal.toStringAsFixed(0)}",
                            labelColor: AppColor().textOrange,
                            imageString: "assets/direct.png")),
                    Expanded(
                        child: teamWidget(
                            title: "0",
                            income: data!.leftPv != null
                                ? (data.totalLeftPv + data.totalRightPv).toStringAsFixed(2)
                                : "0",
                            teamName: "Total Team",
                            active: "${dashboardData?.allActivemember.toInt()}",
                            deActive: dashboardData?.allbusiness != null
                                ? "${(dashboardData!.allbusiness.uleftcount + dashboardData.allbusiness.urightcount).toInt()}"
                                : "0",
                            labelColor: AppColor().blue,
                            imageString: "assets/other.png")),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget teamWidget({
    String title = '',
    String? imageString,
    String income = '',
    String teamName = '',
    String active = '',
    String deActive = '',
    Color? labelColor,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor().primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: labelColor ?? AppColor().oldThemeColors,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: AppText(
                  text: teamName,
                  fontSize: 15,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  height10,
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 15,
                        color: AppColor().red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      AppText(
                        text: deActive,
                        fontSize: 15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 15,
                        color: AppColor().green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      AppText(
                        text: active,
                        fontSize: 15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        size: 15,
                        color: AppColor().greyText,
                      ),

                      Expanded(
                        child: AppText(
                          text: "\$ $income",
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  height10
                ],
              ),
            )
          ],
        ));
  }

  Widget detailBox(
      {String title = '', String income = '', IconData? bottomIcon}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor().primaryColor,
        ),
        child: Column(

          children: [
            AppText(
              text: title,
              fontSize: 12,
              textColor: Colors.grey,
            ),SizedBox(height: 10,),
            AppText(
              text: "$income",
              fontSize: 13,
            )
          ],
        ));
  }
  Widget businessDetails(
      {String title = '', String income = '', IconData? bottomIcon}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor().primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: title,
              fontSize: 12,
              textColor: Colors.grey,
            ),
            AppText(
              text: "$income",
              fontSize: 13,
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

  Widget incomeDetailWidget() {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          var data = controller.allUserProfileData.value?.data;
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
                            AppColor().secondPrimaryColor,
                            AppColor().primaryColor,
                          ]),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Income Details",
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                height10,
                Row(
                  children: [
                    Expanded(
                        child: detailBox(
                            title: "Direct Reward",
                            income:
                                "\$ ${data?.directWallet.toStringAsFixed(2)}",
                            bottomIcon: Icons.wallet)),
                    Expanded(
                        child: detailBox(
                            title: "Matching Reward",
                            income:
                                "\$ ${data?.binaryWallet.toStringAsFixed(2)}",
                            bottomIcon: Icons.wallet)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: detailBox(
                            title: "USDT Trading",
                            income: "\$ ${data?.roiWallet.toStringAsFixed(2)}",
                            bottomIcon: Icons.wallet)),
                    Expanded(
                        child: detailBox(
                            title: "Gridx Trading",
                            income: "${data?.internalGdxWallet.toStringAsFixed(2)}",
                            bottomIcon: Icons.wallet)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: detailBox(
                            title: "Level Reward",
                            income: "\$ 0.0",
                            bottomIcon: Icons.wallet)),
                    Expanded(
                        child: detailBox(
                            title: "Royalty Reward",
                            income: "\$ 0.0",
                            bottomIcon: Icons.wallet)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
