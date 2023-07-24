import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/model/airdropModel/airdropModel.dart';
import 'package:gredex/model/downLineModel/downLineModel.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../getXController/airdropController/airdropController.dart';

class ShibaReward extends StatefulWidget {
  const ShibaReward({Key? key}) : super(key: key);

  @override
  State<ShibaReward> createState() => _ShibaRewardState();
}

class _ShibaRewardState extends State<ShibaReward> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirdropController>(
      init: AirdropController(),
      //  initState: AirdropController().initData(airdropFilterString: "shibaWallet"),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            appColor: Colors.transparent,
            enableBackArrow: true,
            title: "Shiba History",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // Creates border
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
                              "\$${controller.homePageController.allUserProfileData.value?.data.shibawallet}"
                                  .toString(),
                          fontSize: 18,
                        ),
                      ],
                    ),
                  ),
                  controller.airDropModel.value != null
                      ? AppPageLoader(
                          isLoading: controller.loaderStatus.value,
                          child: itemWidget(controller.airDropModel.value))
                      : NoData(),
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

  Widget itemWidget(AirDropModel? value) {
    return ListView.builder(
      itemCount: value?.data.length ?? 0,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
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
                          Row(
                            children: [
                              AppText(
                                text: "${value?.data[index].debitorName}",
                                textColor: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ],
                          ),
                          height10,
                          AppText(
                            text:
                                "(${"${value?.data[index].debitorusername}"})",
                            textColor: AppColor().textOrange,
                            fontSize: 10,
                          ),
                          height10,
                          AppText(
                            text: AppUtility.parseDate(
                                value!.data[index].createdAt),
                            textColor: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ],
                      )),
                  AppText(
                    text: "+ ${value.data[index].amount}",
                    textColor: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )
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
