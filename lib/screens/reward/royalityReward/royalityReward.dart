import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../getXController/homePageController/homePageController.dart';

class RoyalityReward extends StatelessWidget {
   RoyalityReward({Key? key}) : super(key: key);
  HomePageController homePageController=Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor().primaryColor,
      appBar: AppToolbar(
        onPressBackButton: () {
          Navigator.pop(context);
        },
        appColor: Colors.transparent,
        enableBackArrow: true,
        title: "Royalty Reward",
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
                    const AppText(
                      text: "Total Balance",
                      fontSize: 15,
                      textColor: Colors.grey,
                    ),
                    AppText(
                      text:
                      "\$0.00"
                          .toString(),
                      fontSize: 18,
                    ),
                  ],
                ),
              ),

              height10,
            ],
          ),
        ),
      ),
    );
  }
   Widget get height10 => const SizedBox(
     height: 10,
   );
}
