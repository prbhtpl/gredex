import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/getXController/directControlller/directController.dart';
import 'package:gredex/model/USDTTradingModel/UsdtTradingModel.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../commonWidget/commonDecoration.dart';
import '../../../commonWidget/noData.dart';

class TradingReward extends StatefulWidget {
  const TradingReward({Key? key}) : super(key: key);

  @override
  State<TradingReward> createState() => _TradingRewardState();
}

class _TradingRewardState extends State<TradingReward>
    with SingleTickerProviderStateMixin {

  TabController? _controller;

  @override
  void initState() {

    super.initState();
    _controller = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirectRewardController>(
      init: DirectRewardController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            appColor: Colors.transparent,
            enableBackArrow: true,
            title: "Trading History",
          ),
          body: AppPageLoader(
            isLoading: controller.loaderStatus.value,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // filterWidget(),
                  // height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            if (controller.pageAll.value != 1) {
                              controller.getUSDTTrading(
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
                            controller.getUSDTTrading(
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
                              "\$${controller.homePageController.allUserProfileData.value?.data.roiWallet}"
                                  .toString(),
                          fontSize: 18,
                        ),
                      ],
                    ),
                  ),
                  height10,
                  Expanded(child: itemWidget(controller.usdtTradingList)),
                  height10,
                  height10,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemWidget(List<USDTTradingList> usdtTradingList) {
    return usdtTradingList.isNotEmpty
        ? ListView.builder(
            itemCount: usdtTradingList.length ?? 0,
            shrinkWrap: true,
          //  physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
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
                                  text: "Trading Reward",
                                  textColor: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                height10,
                                AppText(
                                  text: usdtTradingList[index].status==1 ? "Credited" : "Laps",
                                  textColor: usdtTradingList[index].status==1
                                      ? Colors.green
                                      : AppColor().red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                width10,
                                height10,
                                 AppText(
                                  text: AppUtility.parseDate(usdtTradingList[index].createdAt),
                                  textColor: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ],
                            )),
                        Expanded(
                            child: AppText(
                          text: "+ ${usdtTradingList[index].usdamount}",
                          textColor: usdtTradingList[index].status==1? Colors.green:Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                      ],
                    ),
                  ));
            },
          )
        : NoData();
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
                  text: "Trading History",
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
