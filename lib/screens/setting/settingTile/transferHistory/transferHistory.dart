import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/commonDecoration.dart';
import 'package:gredex/model/transactionHistoryModel/trasactionHistoryModel.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../Utility/app_utility.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/noData.dart';
import '../../../../getXController/transactionHistoryController/transactionHistoryController.dart';

class TransferHistory extends StatefulWidget {
  const TransferHistory({Key? key}) : super(key: key);

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {


  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppToolbar(
          onPressBackButton: () {
            Navigator.pop(context);
          },
          enableBackArrow: true,
          title: "Transaction History",
          appColor: Colors.transparent,
        ),
        backgroundColor: AppColor().primaryColor,
        body: GetBuilder<TransactionHistoryController>(
            init: TransactionHistoryController(),
            builder: (controller) {
              return AppPageLoader(
                enablePullToRefresh: true,
                onRefresh: () => controller.initData(),
                isLoading: controller.loaderStatus.value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                if (controller.pageAll.value != 1) {
                                  controller.allTransactionHistory(
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
                                controller.allTransactionHistory(
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
                      Expanded(
                        child: Obx(() => teamWidget(
                            controller.transactionHistoryModel.value != null
                                ? controller.transactionHistoryModel.value!.data
                                : [])),
                      ),
                      height10,
                    ],
                  ),
                ),
              );
            }));
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget teamWidget(List<TransactionHistoryList> data) {
    print("data" + data.toString());
    return ListView.builder(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              text: "Amount",
                              fontSize: 15,
                            ),
                            AppText(
                              text: data != null
                                  ? "${data[index].amount.toStringAsFixed(2)}"
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
                              AppText(
                                text: "Description",
                                fontSize: 15,
                              ),
                              height10,
                              AppText(
                                text: "Status",
                                fontSize: 15,
                              ),
                              height10,
                              AppText(
                                text: "Category",
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
                              SizedBox(
                                width: 200,
                                child: AppText(
                                  text: data != null
                                      ? data[index].description.toString()
                                      : "N/A",
                                  fontSize: 15,
                                ),
                              ),
                              height10,
                              AppText(
                                text: data != null
                                    ? data[index].status == 0
                                        ? "Lapse"
                                        : "Active"
                                    : "N/A",
                                fontSize: 15,
                                textColor: data != null
                                    ? data[index].status == 0
                                        ? AppColor().red
                                        : AppColor().green
                                    : null,
                              ),
                              height10,
                              AppText(
                                text: data != null
                                    ? data[index].category.toString()
                                    : "N/A",
                                fontSize: 15,
                              ),
                              height10,
                              AppText(
                                text: dataItem != null
                                    ? AppUtility.parseDate(
                                        "${dataItem[index].createdAt}")
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
    );
  }

  textWidget({String text = '', Color? backgroundColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor ?? AppColor().secondPrimaryColor),
      child: AppText(
        text: text,
        fontSize: 12,
      ),
    );
  }
}
