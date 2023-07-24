import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/model/matchingRewardModel/matchingRewardModel.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../commonWidget/commonDecoration.dart';
import '../../../getXController/matchingRewardController/matchingRewardController.dart';

class MatchingHistory extends StatefulWidget {
  const MatchingHistory({Key? key}) : super(key: key);

  @override
  State<MatchingHistory> createState() => _MatchingHistoryState();
}

class _MatchingHistoryState extends State<MatchingHistory>
    with SingleTickerProviderStateMixin {

  TabController? _controller;

  @override
  void initState() {

    super.initState();
    _controller = TabController(length: 1, vsync: this);
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
            title: "Matching History",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //filterWidget(),
               //   height10,
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
                              "\$${controller.homePageController.allUserProfileData.value?.data.binaryWallet.toStringAsFixed(2)}",
                          fontSize: 18,
                        ),
                      ],
                    ),
                  ),
                  height10,
                  AppPageLoader(
                      isLoading: controller.loaderStatus.value,
                      onRefresh: () => controller.initData(),
                      enablePullToRefresh: true,
                      child: Obx(() => controller.matchingRewardModel.value !=
                              null
                          ? controller
                                  .matchingRewardModel.value!.data.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.matchingRewardModel
                                          .value!.data.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return itemWidget(controller
                                        .matchingRewardModel
                                        .value!
                                        .data[index]);
                                  },
                                )
                              : NoData()
                          : NoData())), /*   SingleChildScrollView(
                      child: NoData(),
                    ),
*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemWidget(Datum data) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: "Amount",
                        textColor: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      height10,
                      AppText(
                        text: "Left Business",
                        textColor: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      height10,
                      AppText(
                        text: "Right Business",
                        textColor: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      height10,
                      AppText(
                        text: "Matching",
                        textColor: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      width10,
                      height10,
                      AppText(
                        text: "Date",
                        textColor: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ],
                  )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "\$${data.amount.toStringAsFixed(2)}",
                    textColor: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  height10,
                  AppText(
                    text: "\$${data.leftBusiness.toStringAsFixed(2)}",
                    textColor: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  height10,
                  AppText(
                    text: "\$${data.rightBusiness.toStringAsFixed(2)}",
                    textColor: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  height10,
                  AppText(
                    text: data.matching.toStringAsFixed(2),
                    textColor: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  width10,
                  height10,
                  AppText(
                    text: AppUtility.parseDate(data.createdAt),
                    textColor: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ],
              )),
            ],
          ),
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
                  text: "Matching History",
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
