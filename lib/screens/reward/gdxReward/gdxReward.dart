import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/model/GDXTrading/GDXTradingModel.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../commonWidget/commonDecoration.dart';
import '../../../getXController/matchingRewardController/matchingRewardController.dart';

class GDXHistory extends StatefulWidget {
  GDXHistory({Key? key}) : super(key: key);

  @override
  State<GDXHistory> createState() => _GDXHistoryState();
}

class _GDXHistoryState extends State<GDXHistory> {
  HomePageController homePageController = Get.put(HomePageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchingRewardController>(
      init: MatchingRewardController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            appColor: Colors.transparent,
            enableBackArrow: true,
            title: "GDX History",
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          if (controller.pageAll.value != 1) {
                            controller.getMatchingReward(
                                pageNumber: controller.pageAll.value - 1);
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
                    SizedBox(
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
                          controller.getMatchingReward(
                              pageNumber: controller.pageAll.value + 1);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: CommonDeco().primary,
                          child: const Icon(Icons.arrow_forward_ios),
                        )),
                  ],
                ),
                height10,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // Creates border
                      color: AppColor().secondPrimaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: "Total Balance",
                        fontSize: 15,
                        textColor: Colors.grey,
                      ),
                      AppText(
                        text:
                            "${homePageController.allUserProfileData.value?.data.internalGdxWallet.toStringAsFixed(2)}"
                                .toString(),
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AppPageLoader(
                      isLoading: controller.loaderStatus.value,
                      enablePullToRefresh: true,
                      onRefresh: () => controller.initData(),
                      child: controller.gdxTradingList.isNotEmpty
                          ? itemWidget(controller.gdxTradingList)
                          : NoData()),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ListView itemWidget(List<GDXTradingList> gdxTradingList) {
    return ListView.builder(
      itemCount: gdxTradingList.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = gdxTradingList[index];
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
                color: AppColor().secondPrimaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            text: "GDX",
                            textColor: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          SizedBox(height: 10),
                          AppText(
                            text: "USDT",
                            textColor: AppColor().textOrange,
                            fontSize: 10,
                          ),
                          height10,
                          AppText(
                            text: "Status ",
                            textColor: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          height10,
                          AppText(
                            text: "Created At",
                            textColor: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ],
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: data.amount.toStringAsFixed(2),
                        textColor: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      height10,
                      AppText(
                        text: data.usdamount.toStringAsFixed(2),
                        textColor: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      height10,
                      AppText(
                        text: data.status == 0 ? "Lapse" : "Active",
                        textColor: data.status == 0
                            ? AppColor().red
                            : AppColor().green,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      height10,
                      AppText(
                        text: AppUtility.parseDate(data.createdAt),
                        textColor: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );
}
