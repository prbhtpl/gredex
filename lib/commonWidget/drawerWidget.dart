import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';
import 'package:gredex/screens/auth/register/register_page.dart';
import 'package:page_transition/page_transition.dart';

import '../Utility/app_local_db.dart';
import '../Utility/app_utility.dart';
import '../getXController/homePageController/homePageController.dart';
import '../screens/auth/loginPage/login_page.dart';
import '../screens/auth/registerUnderApp/registerPageUnderApp.dart';
import '../screens/setting/settingTile/addAccount/addAccountScreen.dart';

import '../screens/setting/settingTile/binaryReport/binaryReport.dart';
import '../screens/setting/settingTile/bonaza/bonaza.dart';
import '../screens/setting/settingTile/changePassword/changePassword.dart';
import '../screens/setting/settingTile/downline/downLineScreen.dart';
import '../screens/setting/settingTile/gameWallet/gameWallet.dart';
import '../screens/setting/settingTile/myLevel/myLevel.dart';
import '../screens/setting/settingTile/myTeam/myTeam.dart';
import '../screens/setting/settingTile/p2pRequest/p2pRequestScreen.dart';
import '../screens/setting/settingTile/p2pTransfer/p2pTransfer.dart';
import '../screens/setting/settingTile/progileReward/profileRewardScreen.dart';
import '../screens/setting/settingTile/settingTile.dart';
import '../screens/setting/settingTile/supportTicket/supportTicket.dart';
import '../screens/setting/settingTile/transferHistory/transferHistory.dart';
import '../screens/setting/settingTile/withdrawl/withdrawlAmount.dart';
import 'appColors.dart';
import 'appText.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor().primaryColor,
      child: GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  height10,
                  height10,
                  height10,
                  profileWidget(controller),
                  itemWidget(context, controller),
                  height10,
                  height10,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );

  Widget profileWidget(HomePageController controller) {
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
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
                  margin: EdgeInsets.only(right: 5, top: 5, bottom: 5),
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
                    margin: EdgeInsets.symmetric(horizontal: 10),
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
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            width10,
                            Obx(
                              () => controller
                                              .allUserProfileData.value?.data.ev ==
                                          1 &&
                                      controller.allUserProfileData.value?.data
                                              .sv ==
                                          1 &&
                                      controller.allUserProfileData.value?.data
                                              .gdxAddressChangeStatus ==
                                          false &&
                                      controller.allUserProfileData.value?.data
                                              .nameChangeStatus ==
                                          1
                                  ? Icon(
                                      Icons.verified,
                                      color: AppColor().highLightColor,
                                      size: 15,
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: AppColor().red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const AppText(
                                        text: "Pending",
                                        fontSize: 10,
                                      ),
                                    ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              textColor: AppColor().green,
                              text: data != null ? data.username : "N/A",
                              fontSize: 12,
                            ),
                            Expanded(
                              child: AppText(
                                textColor: AppColor().greyText,
                                text: data != null
                                    ? data.activationDate.isNotEmpty?AppUtility.parseDate(data.activationDate):"--"
                                    : "N/A",
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        AppText(
                          text: data != null ? "${data.mobile ?? "--"}" : "N/A",
                          fontSize: 12,
                          textColor: AppColor().greyText,
                        ),
                        AppText(
                          text: data != null ? data.email : "N/A",
                          fontSize: 12,
                          textColor: AppColor().greyText,
                        ),
                        AppText(
                          text: data != null ? "${data.designation}" : "N/A",
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
            icon: Icon(
              CupertinoIcons.forward,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
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

  Widget itemWidget(
      BuildContext context, HomePageController homePageController) {
    return Column(
      children: [
        Container(
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: ProfileReward()));
            },
            imageString: "assets/profile.png",
            text: "Profile Reward",
          ),
        ),
        Container(
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: const MyLevel()));
            },
            imageString: "assets/mylevel.png",
            text: "My Level",
          ),
        ),
        Container(
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);

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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
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
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
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
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: WithdrawnAmount()));
            },
            imageString: "assets/withdrawn.png",
            text: "Withdrawn \$",
          ),
        ),
        Container(
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
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
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
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
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);

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
              Navigator.pop(context);
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: RegisterUnderApp(
                        referralCode: homePageController
                            .allUserProfileData.value!.data.username
                            .replaceAll("GDX", ""),
                      )));
            },
            imageString: "assets/webBrowser.png",
            text: "Add User",
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupportTicket()));
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
            text: "Download Game",
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
          // addmoneyNfi (0:3484)
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

          // height: 40,
          decoration: BoxDecoration(
            color: Color(0xff2b2b44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SettingTile(
            onClick: () {
              //  Get.back();

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
        /*  Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

            // height: 40,
            decoration: BoxDecoration(
              color: AppColor().secondPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.phone_android,
                  size: 25,
                  color: Colors.white,
                ),
                width10,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text:
                          "${homePageController.packageInfo.appName} (${homePageController.packageInfo.version})",
                      fontSize: 12,
                    ),
                    AppText(
                      text:
                          'Install from playstore ${homePageController.packageInfo.installerStore ?? '-- not available'}',
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ],
                ))
              ],
            )
            */ /*
          child:   ListTile(leading: Icon(Icons.phone_android,size: 25,color: Colors.white,),
            title: AppText(text:_packageInfo.appName+"(${_packageInfo.version})",fontSize: 12,),
            subtitle: Row(
              children: [
                AppText(text:
                'Install from store ${_packageInfo.installerStore ?? 'not available'}',fontSize: 12,),
              ],
            ),
          ) */ /* */ /* Column(
            children: <Widget>[
              _infoTile('App name', _packageInfo.appName),
              _infoTile('Package name', _packageInfo.packageName),
              _infoTile('App version', _packageInfo.version),
              _infoTile('Build number', _packageInfo.buildNumber),
              _infoTile('Build signature', _packageInfo.buildSignature),
              _infoTile(
                'Installer store',
                _packageInfo.installerStore ?? 'not available',
              ),
            ],
          ),*/ /*
            ),*/
      ],
    );
  }
}
