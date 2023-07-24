import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/model/bonanzaCompleteModel/bonanzaCompleteModel.dart';
import 'package:gredex/model/bonanzaModel/bonanzaModel.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../getXController/bonazaController/bonanzaController.dart';
import '../../../../model/BonanzaNewModel/BonanzaNewModel.dart';

class Bonaza extends StatefulWidget {
  const Bonaza({Key? key}) : super(key: key);

  @override
  State<Bonaza> createState() => _BonazaState();
}

class _BonazaState extends State<Bonaza> with SingleTickerProviderStateMixin {


  @override
  void initState() {

    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  TabController? _controller;

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BonanzaController>(
      init: BonanzaController(),
      //  initState: BonanzaController().initData(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            enableBackArrow: true,
            onPressBackButton: () {
              Navigator.pop(context);
            },
            appColor: Colors.transparent,
            title: "Bonanza",
          ),
          body: AppPageLoader(
            isLoading: controller.loaderStatus.value,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                                text: "Running",
                                fontSize: 15,
                              ),
                            ),
                            Tab(
                              icon: AppText(
                                text: "May Bonanza",
                                fontSize: 15,
                              ),
                            ),
                            Tab(
                              icon: AppText(
                                text: "April Bonanza",
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
                          children: [
                       
                                running(controller.bonanzaNewModel.value != null
                                    ? controller.bonanzaNewModel.value
                                    : null),
                              
                            
                            Column(
                              children: [
                                pending(controller.bonanzaModel.value != null
                                    ? controller.bonanzaModel.value
                                    : null),
                                AppText(
                                  text: controller.homePageController
                                      .allUserProfileData.value?.data.name,
                                ),
                                controller.homePageController.allUserProfileData
                                            .value?.status ==
                                        0
                                    ? Image.asset(
                                        "assets/congrats.png",
                                        height: 300,
                                        width: 300,
                                      )
                                    : SizedBox()
                              ],
                            ),
                            controller.bonanzaCompleteModel.value != null
                                ? SingleChildScrollView(
                                    child: ListView.builder(
                                      itemCount: controller.bonanzaCompleteModel
                                              .value?.data.length ??
                                          0,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return completed(controller
                                            .bonanzaCompleteModel
                                            .value
                                            ?.data[index]);
                                      },
                                    ),
                                  )
                                : NoData()
                          ],
                        ),
                      ),
                    ])),
          ),
        );
      },
    );
  }

  Widget completed(Datum? data) {
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
                      text: data?.offer ?? "N/A",
                      fontSize: 15,
                    ),
                    AppText(
                      text: data != null
                          ? "${AppUtility.parseDate(data.from)} to ${AppUtility.parseDate(data.to)}"
                          : "N/A",
                      fontSize: 12,
                      textColor: Colors.white70,
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
                        text: "Name",
                        fontSize: 15,
                      ),
                      height10,
                      const AppText(
                        text: "Direct ",
                        fontSize: 15,
                      ),
                      height10,
                      const AppText(
                        text: "Business",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Offer",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Status",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      AppText(
                        text: data?.name ?? "N/A",
                        fontSize: 15,
                        textColor: AppColor().textOrange,
                      ),
                      height10,
                      AppText(
                        text: data?.direct.toString() ?? "N/A",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: data?.business.toString() ?? "N/A",
                        fontSize: 15,
                        textColor: AppColor().textOrange,
                      ),
                      height10,
                      AppText(
                        text: data?.offer ?? "N/A",
                        fontSize: 15,
                        textColor: AppColor().textOrange,
                      ),
                      height10,
                      AppText(
                        text: data?.status == 0 ? "Pending" : "Completed",
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

  Widget pending(BonanzaModel? bonanzaModel) {
    return Column(
      children: [
        Container(
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
                          text: "Thailand Tour",
                          fontSize: 15,
                        ),
                        AppText(
                          text: "1 May to 31 May 2023",
                          fontSize: 12,
                          textColor: Colors.white70,
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
                            text: "Direct Target",
                            fontSize: 15,
                          ),
                          height10,
                          const AppText(
                            text: "Direct Complete ",
                            fontSize: 15,
                          ),
                          height10,
                          const AppText(
                            text: "Business Target",
                            fontSize: 15,
                          ),
                          height10,
                          AppText(
                            text: "Achieved",
                            fontSize: 15,
                          ),
                          height10,
                          AppText(
                            text: "Status",
                            fontSize: 15,
                          ),
                          height10,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            text: bonanzaModel?.data.thiland.directTarget
                                    .toString() ??
                                "N/A",
                            fontSize: 15,
                          ),
                          height10,
                          AppText(
                            text: bonanzaModel?.data.thiland.directComplete
                                    .toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text: bonanzaModel?.data.thiland.businessTarget
                                    .toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text: bonanzaModel?.data.thiland.business
                                    .toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text: bonanzaModel?.data.thiland.status == 0
                                ? "Pending"
                                : "Completed",
                            fontSize: 15,
                          ),
                          height10,
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
        Container(
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
                          text: "Dubai Tour",
                          fontSize: 15,
                        ),
                        AppText(
                          text: "1 May to 31 May 2023",
                          fontSize: 12,
                          textColor: Colors.white70,
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
                            text: "Direct Target",
                            fontSize: 15,
                          ),
                          height10,
                          const AppText(
                            text: "Direct Complete ",
                            fontSize: 15,
                          ),
                          height10,
                          const AppText(
                            text: "Business Target",
                            fontSize: 15,
                          ),
                          height10,
                          AppText(
                            text: "Achieved",
                            fontSize: 15,
                          ),
                          height10,
                          AppText(
                            text: "Status",
                            fontSize: 15,
                          ),
                          height10,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            text: bonanzaModel?.data.dubai.directTarget
                                    .toString() ??
                                "N/A",
                            fontSize: 15,
                          ),
                          height10,
                          AppText(
                            text: bonanzaModel?.data.dubai.directComplete
                                    .toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text: bonanzaModel?.data.dubai.businessTarget
                                    .toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text:
                                bonanzaModel?.data.dubai.business.toString() ??
                                    "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text: bonanzaModel?.data.dubai.status == 0
                                ? "Pending"
                                : "Completed",
                            fontSize: 15,
                          ),
                          height10,
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }

  Widget running(BonanzaNewModel? bonanzaNewModel) {
    return ListView.builder(shrinkWrap: true,itemCount: bonanzaNewModel?.data.length,itemBuilder: (context, index) {
      var data=bonanzaNewModel?.data[index];

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
                        text: data?.rank,
                        fontSize: 15,
                      ),
                      AppText(
                        text: data!=null?AppUtility.parseDate(data.createdAt):"--",
                        fontSize: 12,
                        textColor: Colors.white70,
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
                          text: "Matching Business",
                          fontSize: 15,
                        ),
                        height10,
                        const AppText(
                          text: "Rewards(\$)",
                          fontSize: 15,
                        ),
                        height10,
                        const AppText(
                          text: "Days",
                          fontSize: 15,
                        ),
                        height10,
                        AppText(
                          text: "Status",
                          fontSize: 15,
                        ),
                        height10,
                        data?.completedStatus=="COMPLETED"? AppText(
                          text: "Completed",
                          fontSize: 15,
                        ):SizedBox(),
                        data?.completedStatus=="COMPLETED"?  height10:SizedBox(),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            text: data?.directBussiness
                                .toString() ??
                                "N/A",
                            fontSize: 15,
                          ),
                          height10,
                          AppText(
                            text: data?.offer
                                .toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text:data?.days
                                .toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),
                          height10,
                          AppText(
                            text:
                            data?.completedStatus.toString() ??
                                "N/A",
                            fontSize: 15,
                            textColor: AppColor().textOrange,
                          ),

                          height10,
                          data?.completedStatus=="COMPLETED"? AppText(
                            text: data!=null?data.completedDate!=null?AppUtility.parseDate(data.completedDate!):"--":"--",
                            fontSize: 12,
                            textColor: Colors.white70,
                          ):SizedBox(),
                          data?.completedStatus=="COMPLETED"?  height10:SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    },);
  }
}
