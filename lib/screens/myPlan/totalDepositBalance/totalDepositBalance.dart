import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/screens/dashboard/tokenGrowthTile/tokenGrowthTile.dart';
import 'package:gredex/screens/myPlan/totalDepositBalance/withdrawal/withdrawal.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../getXController/totalbalanceHistoryController/totalBalanceController.dart';
import '../../../getXController/transactionHistoryController/transactionHistoryController.dart';
import 'deposit/depositScreen.dart';

class TotalDepositBalance extends StatelessWidget {
  TotalDepositBalance({Key, this.amount, this.name, this.showGDXString, key})
      : super(key: key);
  HomePageController homePageController = Get.put(HomePageController());
  final String? name;
  final String? amount;
  final String? showGDXString;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TotalBalanceController>(
      init: TotalBalanceController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: " ",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: AppPageLoader(
            isLoading: controller.loaderStatus.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    height10,
                    height10,
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: topWidget()),
                    height10,
                    height10,
                    height10,
                    height10,
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: filterWidget(context)),
                    height10,
                    Obx(()=>transferHistoryList(controller)),
                    height10,
                    height10,
                    height10,
                    height10,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  filterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: DepositScreen(
                            showGDXString: showGDXString,
                          )));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), // Creates border
                      color: AppColor().oldThemeColors),
                  child: AppText(
                    text: "Deposit",
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: Withdrawal(
                            showGDXString: showGDXString,
                          )));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), // Creates border
                      color: AppColor().oldThemeColors),
                  child: AppText(
                    text: "Withdrawal",
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        height10,
        height10,
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // Creates border
            gradient: LinearGradient(
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                colors: [
                  AppColor().purple,
                  AppColor().themeColors,
                  AppColor().themeColors,
                ]),
          ),
          child: AppText(
            text: "Transaction History",
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  topWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                const AppText(
                  text: "Total Balance",
                  fontSize: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.2)),
                  padding: EdgeInsets.all(5),
                  child: AppText(
                    text: "$name",
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.copy,
              color: Colors.grey,
            )
          ],
        ),
        height10,
        AppText(
          text: amount,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        height10,
        AppText(
          text: "~\$$amount",
          fontWeight: FontWeight.w700,
          fontSize: 15,
          textColor: AppColor().greyText,
        ),
      ],
    );
  }

  Widget get height10 => const SizedBox(
        height: 5,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );

  Widget transferHistoryList(TotalBalanceController controller) {
    var data = controller.totalTransactionModel.value?.data;
    return data != null
        ? data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor().secondPrimaryColor),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ListTile(
                      title: Text(
                        "Send",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Hash: ${data[index].hash}",
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${AppUtility.parseDate(data[index].createdAt)}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      trailing: AppText(
                        text: "-${data[index].amount}GDX",
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              )
            : NoData()
        : NoData();
  }
}
