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
import '../../../../getXController/downlineController/downlineController.dart';
import '../../../../model/downLineModel/downLineModel.dart';

class DownLineScreen extends StatefulWidget {
  const DownLineScreen({Key? key}) : super(key: key);

  @override
  State<DownLineScreen> createState() => _DownLineScreenState();
}

class _DownLineScreenState extends State<DownLineScreen>
    with SingleTickerProviderStateMixin {
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
          title: "DOWNLINE",
          appColor: Colors.transparent,
        ),
        backgroundColor: AppColor().primaryColor,
        body: GetBuilder<DownLineController>(
            init: DownLineController(),
            builder: (controller) {
              var data = controller.downLineModel.value?.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          const AppText(
                            text: "Total Balance",
                            fontSize: 15,
                            textColor: Colors.grey,
                          ),
                          AppText(
                            text:
                                "\$${controller.downLineModel.value?.data.totalBusiness ?? 0}"
                                    .toString(),
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
                                    controller.myDownLineDropDown.value =
                                        res.toString();
                                  });
                                  if (controller.myDownLineDropDown.value ==
                                      "Active") {
                                    controller.selectDropDownValue.value = "1";
                                  } else if (controller
                                          .myDownLineDropDown.value ==
                                      "Inactive") {
                                    controller.selectDropDownValue.value = "0";
                                  }

                                  controller.getAllDownLine();
                                },
                                value: controller.myDownLineDropDown.value,
                                hint: const Text(
                                  "Select",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  if (controller.pageAll.value != 1) {
                                    controller.getAllDownLine(
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
                                  controller.getAllDownLine(
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
                            onRefresh: () => controller.initData(),
                            enablePullToRefresh: true,
                            child: ListView.builder(
                              itemCount: controller.downLineModel.value?.data
                                      .mydownline.length ??
                                  0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                List<Mydownline>? data = controller
                                    .downLineModel.value?.data.mydownline;

                                return data!.isNotEmpty
                                    ? teamWidget(data: data, index: index)
                                    : NoData();
                              },
                            ),
                          ),
                          AppPageLoader(
                            isLoading: controller.loaderStatus.value,
                            onRefresh: () => controller.initData(),
                            enablePullToRefresh: true,
                            child: ListView.builder(
                              itemCount: controller.downLineModel.value?.data
                                      .mydownline.length ??
                                  0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                List<Mydownline>? data = controller
                                    .downLineModel.value?.data.mydownline;

                                return controller.downLineModel.value?.data
                                            .mydownline[index].position ==
                                        "L"
                                    ? teamWidget(data: data, index: index)
                                    : const SizedBox();
                              },
                            ),
                          ),
                          AppPageLoader(
                            isLoading: controller.loaderStatus.value,
                            onRefresh: () => controller.initData(),
                            enablePullToRefresh: true,
                            child: ListView.builder(
                              itemCount: controller.downLineModel.value?.data
                                      .mydownline.length ??
                                  0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                List<Mydownline>? data = controller
                                    .downLineModel.value?.data.mydownline;

                                return controller.downLineModel.value?.data
                                            .mydownline[index].position ==
                                        "R"
                                    ? teamWidget(data: data, index: index)
                                    : const SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget teamWidget({List<Mydownline>? data, int index = 0}) {
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
                    Row(
                      children: [
                        AppText(
                          text: data![index].name ?? "N/A",
                          fontSize: 18,
                        ),
                        data[index].verifiedStatus == 1
                            ? Icon(
                                Icons.verified,
                                color: AppColor().highLightColor,
                                size: 15,
                              )
                            : const SizedBox(),
                      ],
                    ),
                    AppText(
                      text: data[index].activationAmount.toString() ?? "N/A",
                      fontSize: 18,
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
                        text: "Activation Date",
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
                      AppText(
                        text: "Designation",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        text: data[index].username ?? "N/A",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: data[index].position == "L"
                            ? "Left"
                            : "Right" ?? "N/A",
                        fontSize: 15,
                        textColor: data[index].position == "L"
                            ? AppColor().green
                            : AppColor().red,
                      ),
                      height10,
                      AppText(
                        text: data[index].activationDate != ""
                            ? AppUtility.parseDate(data[index].activationDate)
                            : "N/A",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: data[index].status == 1
                            ? "Active"
                            : "Deactivate" ?? "N/A",
                        fontSize: 15,
                        textColor: data[index].status == 1
                            ? AppColor().green
                            : AppColor().red,
                      ),
                      height10,
                      AppText(
                        text: AppUtility.parseDate(
                            data[index].createdAt.toString()),
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: data[index].designation.toString() ?? "N/A",
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
