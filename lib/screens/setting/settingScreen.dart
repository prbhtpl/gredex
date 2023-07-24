import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/screens/setting/settingTile/addAccount/addAccountScreen.dart';

import 'package:gredex/screens/setting/settingTile/binaryReport/binaryReport.dart';
import 'package:gredex/screens/setting/settingTile/bonaza/bonaza.dart';
import 'package:gredex/screens/setting/settingTile/changePassword/changePassword.dart';
import 'package:gredex/screens/setting/settingTile/downline/downLineScreen.dart';
import 'package:gredex/screens/setting/settingTile/gameWallet/gameWallet.dart';
import 'package:gredex/screens/setting/settingTile/myLevel/myLevel.dart';
import 'package:gredex/screens/setting/settingTile/myTeam/myTeam.dart';
import 'package:gredex/screens/setting/settingTile/p2pRequest/p2pRequestScreen.dart';
import 'package:gredex/screens/setting/settingTile/p2pTransfer/p2pTransfer.dart';
import 'package:gredex/screens/setting/settingTile/progileReward/profileRewardScreen.dart';
import 'package:gredex/screens/setting/settingTile/settingTile.dart';
import 'package:gredex/screens/setting/settingTile/supportTicket/supportTicket.dart';
import 'package:gredex/screens/setting/settingTile/transferHistory/transferHistory.dart';
import 'package:gredex/screens/setting/settingTile/withdrawl/withdrawlAmount.dart';
import 'package:page_transition/page_transition.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_toolbar.dart';
import '../../commonWidget/appColors.dart';
import '../../commonWidget/appText.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../getXController/homePageController/homePageController.dart';
import '../auth/loginPage/login_page.dart';

import '../auth/registerUnderApp/registerPageUnderApp.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          var data = controller.allUserProfileData.value?.data;

          return Scaffold(
            appBar: AppToolbar(
              title:
                  "Setting (${controller.allUserProfileData.value?.data.username})",
              appColor: Colors.transparent,
            ),
            backgroundColor: AppColor().primaryColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [profileWidget(), itemWidget(context, controller)],
                ),
              ),
            ),
          );
        });
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );

  Widget profileWidget() {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          var data = controller.allUserProfileData.value?.data;
          Color borderColor;
          if (data?.activMember == 0) {
            borderColor = const Color(0xff000000);
          } else if (data?.activMember == 1) {
            borderColor = const Color(0xff008000);
          } else if (data?.activMember == 2) {
            borderColor = const Color(0xff00B9E8);
          } else {
            borderColor = const Color(0xffffa500);
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xff2B2B44),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // imageZCC (0:12343)
                        margin:
                            const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/user.png',
                            repeat: ImageRepeat.repeat,
                            height: 45,
                            width: 45,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      data != null ? data.name : "N/A",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  width10,
                                  Obx(
                                    () =>
                                        controller.allUserProfileData.value
                                                        ?.data.ev ==
                                                    1 &&
                                                controller.allUserProfileData
                                                        .value?.data.sv ==
                                                    1 &&
                                                controller
                                                        .allUserProfileData
                                                        .value
                                                        ?.data
                                                        .gdxAddressChangeStatus ==
                                                    false &&
                                                controller
                                                        .allUserProfileData
                                                        .value
                                                        ?.data
                                                        .nameChangeStatus ==
                                                    1
                                            ? Icon(
                                                Icons.verified,
                                                color:
                                                    AppColor().highLightColor,
                                                size: 15,
                                              )
                                            : Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: AppColor().red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const AppText(
                                                  text: "Pending",
                                                  fontSize: 10,
                                                ),
                                              ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    textColor: AppColor().green,
                                    text: data != null ? data.username : "N/A",
                                    fontSize: 12,
                                  ),
                                  AppText(
                                    textColor: AppColor().greyText,
                                    text: data != null
                                        ? AppUtility.parseDate(
                                            data.activationDate)
                                        : "N/A",
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              AppText(
                                text: data != null
                                    ? "${data.mobile ?? "--"}"
                                    : "N/A",
                                fontSize: 12,
                                textColor: AppColor().greyText,
                              ),
                              AppText(
                                text: data != null ? data.email : "N/A",
                                fontSize: 12,
                                textColor: AppColor().greyText,
                              ),
                              AppText(
                                text: data != null ? data.designation : "N/A",
                                fontSize: 12,
                                textColor: AppColor().textOrange,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.forward,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _launchURL({required String link}) async {
    try {
      await launch(
        link,
        customTabsOption: CustomTabsOption(
          toolbarColor: Color(0xff2B2B44),
          enableDefaultShare: false,
          enableUrlBarHiding: false,
          showPageTitle: false,
          animation: CustomTabsSystemAnimation.fade(),
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Colors.blue,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  Widget itemWidget(BuildContext context, HomePageController controller) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: ProfileReward()));
            },
            imageString: "assets/profile.png",
            text: "Profile ",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: const MyLevel()));
            },
            imageString: "assets/ladderLevel.png",
            text: "My Level",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: const MyTeam()));
            },
            imageString: "assets/team.png",
            text: "My Team",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: DownLineScreen()));
            },
            imageString: "assets/downArrow.png",
            text: "Direct Downline",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: BinaryReport()));
            },
            imageString: "assets/binary.png",
            text: "Binary Report",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: WithdrawnAmount()));
            },
            imageString: "assets/withdrawn.png",
            text: "Withdrawal ",
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: P2PTransfer()));
            },
            imageString: "assets/p2p.png",
            text: "P2P Transfer",
          ),
        ),


        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: TransferHistory()));
            },
            imageString: "assets/addMoney.png",
            text: "Transaction History",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: Bonaza()));
            },
            imageString: "assets/mylevel.png",
            text: "Bonanza",
          ),
        ),
        Container(
          // addmoneyNfi (0:3484)
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: ChangePassword()));
            },
            imageString: "assets/changePassword.png",
            text: "Change Password",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterUnderApp(
                            referralCode: controller
                                .allUserProfileData.value!.data.username
                                .replaceAll("GDX", ""),
                          )));
            },
            imageString: "assets/webBrowser.png",
            text: "Add User",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: SupportTicket()));
            },
            imageString: "assets/ticket.png",
            text: "Support Ticket",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              _launchURL(
                  link:
                      "https://drive.google.com/drive/folders/1C79Gb5j7CmHWu6-EsCtTZz8TUgGtMPAi?usp=sharing");
            },
            imageString: "assets/download.png",
            text:
                "Download Game(Password: ${controller.allUserProfileData.value?.data.gamePassword})",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GameWalletScreen()));
            },
            imageString: "assets/game.png",
            text: "Game Wallet",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: AppColor().secondPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              ShowBox().showBox(
                  showCancelButton: true,
                  text: "",
                  onButtonClick: () {
                    AppPreference().logout();
                    Get.to(() => const LoginPage());
                  },
                  titleContent: "Are you sure want to log out?",
                  buttonText: "Yes");
            },
            imageString: "assets/logOut.png",
            text: "Log Out",
          ),
        ),

        /* Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

            // height: 40,
            decoration: BoxDecoration(
              color: AppColor().secondPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_android,
                  size: 25,
                  color: Colors.white,
                ),width10,
                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "${controller.packageInfo.appName} (${controller.packageInfo.version})",
                      fontSize: 12,
                    ),

                    AppText(
                      text:
                          'Install from playstore ${controller.packageInfo.installerStore ?? '-- not available'}',
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ],
                ))
              ],
            )

            ),*/
        height10,
        height10,
      ],
    );
  }
}
