import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/commonWidget/appText.dart';
import 'package:gredex/commonWidget/commonTextStyle.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/model/3xAmountModel/threeXAmountModel.dart';
import 'package:gredex/model/profileModel/profileModel.dart';
import 'package:gredex/screens/myPlan/activateAccount/activateAccount.dart';
import 'package:gredex/screens/reward/accountLimit/accountLimitScreen.dart';
import 'package:gredex/screens/reward/directReward/directReward.dart';
import 'package:gredex/screens/reward/gdxBalance/gdxBalance.dart';
import 'package:gredex/screens/reward/gdxReward/gdxReward.dart';
import 'package:gredex/screens/reward/royalityReward/royalityReward.dart';
import 'package:gredex/screens/reward/shibaReward/shibaReward.dart';
import 'package:gredex/screens/reward/totalBalance/totalBalance.dart';
import 'package:gredex/screens/reward/tradingReward/totalReward.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:page_transition/page_transition.dart';
import '../../Utility/app_toolbar.dart';
import '../../commonWidget/appColors.dart';
import '../../commonWidget/commonDecoration.dart';
import '../../getXController/airdropController/airdropController.dart';
import '../dashboard/serviceListTile/serviceListTile.dart';
import 'BDGAirdrop/BGDAirdrop.dart';
import 'gdxAirDrop/gdxAirdropScreen.dart';
import 'levelReward/levelReward.dart';
import 'matchingReward/matchingReward.dart';

class MyReward extends StatefulWidget {
  const MyReward({Key? key}) : super(key: key);

  @override
  State<MyReward> createState() => _MyRewardState();
}

class _MyRewardState extends State<MyReward>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {}));
    //_animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            appColor: Colors.transparent,
            title:
                "My Rewards (${controller.allUserProfileData.value?.data.username})",
          ),
          body: GetBuilder<HomePageController>(
              init: HomePageController(),
              builder: (controller) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        idStatusWidget(controller.threeXAmountModel.value),
                        amountWidget(controller.allUserProfileData.value),
                        itemWidget(controller),
                        height10,
                        height10,
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget itemWidget(HomePageController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
              // addmoneyNfi (0:3484)
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

              // height: 40,
              decoration: BoxDecoration(
                color: Color(0xff2b2b44),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ServiceTile(
                onClick: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: GDXHistory()));
                },
                imageString: "assets/addMoney.png",
                text: "GDX Trading ",
              ),
            )),
            Expanded(
                child: Container(
              // addmoneyNfi (0:3484)
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

              // height: 40,
              decoration: BoxDecoration(
                color: Color(0xff2b2b44),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ServiceTile(
                onClick: () {
                  AirdropController airdropController =
                      Get.put(AirdropController());
                  airdropController.getAllAirDrop(
                      airdropFilterString: "shibaWallet");
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: ShibaReward()));
                },
                imageString: "assets/shiba.png",
                text: "Shiba Air Drop ",
              ),
            )),
            Expanded(
              child: Container(
                // addmoneyNfi (0:3484)
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                // height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2b2b44),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ServiceTile(
                  onClick: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.fade,
                            child: DirectReward()));
                  },
                  imageString: "assets/direct.png",
                  text: "Direct Reward",
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                // height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2b2b44),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ServiceTile(
                  onClick: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.fade,
                            child: MatchingHistory()));
                  },
                  imageString: "assets/matchingReward.png",
                  text: "Matching Reward",
                ),
              ),
            ),
            Expanded(
              child: Container(
                // addmoneyNfi (0:3484)
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                // height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2b2b44),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ServiceTile(
                  onClick: () {
                    AirdropController airdropController =
                        Get.put(AirdropController());
                    airdropController.getAllAirDrop(
                        airdropFilterString: "gridxWallet");
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.fade,
                            child: GDXAirdropScreen()));
                  },
                  imageString: "assets/trackingRewad.png",
                  text: "GDX Air drop",
                ),
              ),
            ),
            Expanded(
                child: Container(
              // addmoneyNfi (0:3484)
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

              // height: 40,
              decoration: BoxDecoration(
                color: Color(0xff2b2b44),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ServiceTile(
                onClick: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: LevelReward()));
                },
                imageString: "assets/levelReward.png",
                text: "Level Reward",
              ),
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                // addmoneyNfi (0:3484)
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                // height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2b2b44),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ServiceTile(
                  onClick: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.fade,
                            child: TradingReward()));
                  },
                  imageString: "assets/trackingRewad.png",
                  text: "USDT Trading",
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                // height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2b2b44),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ServiceTile(
                  onClick: () {
                    AirdropController airdropController =
                        Get.put(AirdropController());
                    airdropController.getAllAirDrop(
                        airdropFilterString: "babyDogeWallet");
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.fade,
                            child: BGDAirdrop()));
                  },
                  imageString: "assets/babyDodge.png",
                  text: "BGD Air Drop",
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                // height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2b2b44),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ServiceTile(
                  onClick: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.fade,
                            child: RoyalityReward()));
                  },
                  imageString: "assets/congrats.png",
                  text: "Royalty Reward",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget amountWidget(ProfileModel? value) {
    var data = value?.data;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor().secondPrimaryColor,
      ),
      child: IntrinsicHeight(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         duration: Duration(seconds: 1),
              //         type: PageTransitionType.fade,
              //         child: const TotalBalance()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  textColor: AppColor().textOrange,
                  text: "Internal balance",
                  fontSize: 15,
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text: data != null
                      ? "\$ ${data.internalWallet.toStringAsFixed(2)}"
                      : "N?A",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppText(
                  text: "Redeem",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 80,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.white70),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white70.withOpacity(0.1),

                    // border: Border.all(color:Colors.white70)
                  ),
                  child: AppText(
                    text:
                        "${data != null ? data.withdrawalAmount.toStringAsFixed(2) : "N?A"}",
                    textColor: Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(color: Colors.white70, width: 1),
          InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     PageTransition(
                //         duration: Duration(seconds: 1),
                //         type: PageTransitionType.fade,
                //         child: const GDXBalance()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    textColor: AppColor().textOrange,
                    text: "GDX balance",
                    fontSize: 15,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppText(
                    text:
                        "${data != null ? data.internalGdxWallet.toStringAsFixed(2) : "N?A"}",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppText(
                    text: "Redeem",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.white70),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white70.withOpacity(0.1),

                      // border: Border.all(color:Colors.white70)
                    ),
                    child: AppText(
                      text:
                          "${data != null ? data.withdrawalGDXAmount.toStringAsFixed(2) : "N?A"}",
                      textColor: Colors.greenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))
        ],
      )),
    );
  }

  Widget get width10 => const SizedBox(
        width: 10,
      );

  Widget idStatusWidget(ThreeXamountModel? value) {
//    print("perentage value ${_animationController.value}");

    // var value2=(value?.data.walletamount)!*(0.10/(value!.data.finalAmount));
    double percentage = 0.0;
    double value2 = 0.0;
    if (value?.data.walletamount != 0.0 && value?.data.finalAmount != 0) {
      var totalAmount =
          ((value?.data.walletamount)! * 100) / value!.data.finalAmount;

      value2 = totalAmount / 100;

      percentage = totalAmount;
    }

    return Container(
      decoration: BoxDecoration(
          color: AppColor().secondPrimaryColor,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.only(bottom: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: AppColor().oldThemeColors,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppText(
                  text: "Amount Limit",
                  fontSize: 18,
                ),
                percentage > 75.00
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(seconds: 1),
                                type: PageTransitionType.fade,
                                child: ActivateAccount()),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor().red),
                          child: const AppText(
                            text: "Renewal Pending",
                            fontSize: 15,
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          height10,
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: AccountLimitScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: LiquidCircularProgressIndicator(
                      value: value2,
                      // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(percentage < 75
                          ? percentage < 30
                              ? Colors.blue.shade100
                              : Colors.yellow.shade400
                          : Colors.green.shade400),
                      // Defaults to the current Theme's accentColor.
                      backgroundColor: Colors.white,
                      // Defaults to the current Theme's backgroundColor.
                      borderColor: Colors.grey.shade100,
                      borderWidth: 5.0,
                      direction: Axis.vertical,
                      // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                      center: Text("${percentage.toStringAsFixed(2)}%"),
                    ),
                  ),
                ),
                width10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailBox(
                        title: "Target",
                        amount: "\$ ${value?.data.finalAmount}"),
                    detailBox(
                        title: "Complete",
                        amount:
                            "\$ ${value?.data.walletamount.toStringAsFixed(2)}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailBox({String title = '', String amount = ''}) {
    return Container(
        width: 120,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor().primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: title,
              fontSize: 15,
            ),
            height10,
            AppText(
              text: amount,
              fontSize: 15,
            ),
          ],
        ));
  }
}
