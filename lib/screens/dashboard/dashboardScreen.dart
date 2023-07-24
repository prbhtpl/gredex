import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_toolbar.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/appColors.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/commonDecoration.dart';
import 'package:gredex/commonWidget/drawerWidget.dart';
import 'package:gredex/model/GDXLiveRateModel/GDXLiveRateModel.dart';
import 'package:gredex/model/profileModel/profileModel.dart';
import 'package:gredex/model/qrCodeModel/qrCodeModel.dart';
import 'package:gredex/screens/dashboard/serviceListTile/serviceListTile.dart';
import 'package:gredex/screens/dashboard/share/shareScreen.dart';
import 'package:gredex/screens/dashboard/tokenGrowthTile/tokenGrowthTile.dart';
import 'package:gredex/screens/notificationScreen/notificationScreen.dart';
import 'package:gredex/screens/setting/settingScreen.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:marquee/marquee.dart';
import 'package:page_transition/page_transition.dart';

import '../../commonWidget/appText.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../getXController/homePageController/homePageController.dart';
import '../../utils.dart';
import '../no_internet/no_internet_mixin.dart';
import '../reward/gdxBalance/gdxBalance.dart';
import '../reward/totalBalance/totalBalance.dart';

import 'P2PTrading/p2pTradingScreen.dart';
import 'auditReport/auditReportScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with NoInternetMixin{
  int currentIndexPage = 0;
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<ConnectivityResult>? _subscription;
  Timer? _checkConnectionTimer;
  Timer? _autoCloseTimer;
  @override
  void initState() {

    checkAndSubscribeConnection(
      context: context,
      subscription: _subscription,
      checkConnectionTimer: _checkConnectionTimer,
      autoCLoseTimer: _autoCloseTimer,
    );
    checkForUpdate();
    super.initState();
  }

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
      print("when update available ${info.availableVersionCode}");
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        InAppUpdate.startFlexibleUpdate().then((value) {
          print("When update Success");
          InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
            AppUtility.showErrorSnackBar(e.toString());
          });
          //AppUtility.showSuccessSnackBar("App Update Successfully!");
        }).catchError((e) => AppUtility.showErrorSnackBar(e.toString()));
      }
    }).catchError((e) {
      AppUtility.showErrorSnackBar(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        // init: HomePageController(),
        builder: (controller) {
      // !_flexibleUpdateAvailable
      //     ? null
      //     : () {
      //         InAppUpdate.completeFlexibleUpdate().then((_) {
      //           showSnack("Success!");
      //         }).catchError((e) {
      //           showSnack(e.toString());
      //         });
      //       };
      return Scaffold(
        key: scaffoldKey,
        drawer: const DrawerWidget(),
        backgroundColor: Colors.white70,
        appBar: AppToolbar(
          appColor: AppColor().primaryColor,
          onPressWidget: () {
            scaffoldKey.currentState?.openDrawer();
          },
          leadingIcon: Image.asset(
            "assets/design/menu-cgG.png",
            scale: 2,
          ),
          actionIcon: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: const Duration(seconds: 1),
                      type: PageTransitionType.fade,
                      child: NotificationScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Image.asset(
                "assets/design/bell.png",
                scale: 3,
              ),
            ),
          ),
          title: "${controller.allUserProfileData.value?.data.username}",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Image.asset(
                'assets/design/background-DzQ.png',
                fit: BoxFit.contain,
              ),
            ),
            AppPageLoader(
              isLoading: controller.loaderStatus.value,
              enablePullToRefresh: true,
              onRefresh: () => controller.initData(),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => controller.bannerList.value != null
                              ? CarouselSlider(
                                  options: CarouselOptions(
                                    height: 140,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.99,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: controller.bannerList.value!.data
                                      .map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: double.infinity,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                i.image,
                                                fit: BoxFit.fitWidth,
                                              )),
                                        );
                                      },
                                    );
                                  }).toList(),
                                  /*  items: [
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/banner.jpg")),
                            ),
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/banner1.jpg")),
                            ),
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/gameBanner.jpeg")),
                            ),
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/banner2.jpg")),
                            ),
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/banner3.jpg")),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/banner4.jpg")),
                            ),
                          ],*/
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 40),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: AppColor().secondPrimaryColor,
                                  ))),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: const Duration(seconds: 1),
                                      type: PageTransitionType.fade,
                                      child: NotificationScreen()));
                            },
                            child: marqueeWidget()),
                        servicesWidget(controller),
                        amountWidget(),
                        itemWidget(),
                        Obx(() => tabBarSection(
                            controller.dollarToBNB.value,
                            controller.allUserProfileData.value,
                            controller.qrModel.value,
                            controller.gdxLiveRateModel.value))
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget marqueeWidget() {
    return Container(
      height: 18,
      color: Colors.white.withOpacity(0.2),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.volume_up,
            size: 15,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Marquee(
              text:
                  'Some sample text that takes some space.Some sample text that takes some space.',
              style: TextStyle(fontWeight: FontWeight.bold),
              scrollAxis: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 40.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 400),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ],
      ),
    );
  }

  Widget amountWidget() {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          var data = controller.allUserProfileData.value?.data;
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //color: AppColor().purple,

                gradient: LinearGradient(
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    colors: [AppColor().purple, AppColor().themeColors])),
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
                    //         child: TotalBalance()));
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
                        height: 10,
                      ),
                      AppText(
                        text: data != null
                            ? "\$ ${data.internalWallet != null ? data.internalWallet.toStringAsFixed(2) : 0.00}"
                            : "N?A",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 10,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5,
                              color: Colors.white70.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white70.withOpacity(0.1),

                          // border: Border.all(color:Colors.white70)
                        ),
                        child: AppText(
                          text: data != null
                              ? "\$ ${data.withdrawalAmount != null ? data.withdrawalAmount.toStringAsFixed(2) : 0.00}"
                              : "N?A",
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
                    //         child: GDXBalance()));
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
                        height: 10,
                      ),
                      AppText(
                        text:
                            "${data != null ? data.internalGdxWallet.toStringAsFixed(2) : "N?A"}",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5,
                              color: Colors.white70.withOpacity(0.2)),
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
                  ),
                )
              ],
            )),
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

  Widget itemWidget() {
    return Container(
      height: 73,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                _launchURL(link: "https://www.facebook.com/gridxecosystem");
              },
              child: Container(
                // addmoneyNfi (0:3484)
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                // height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2b2b44),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: CommonDeco().primary,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.facebook,
                            size: 35,
                            color: Color(0xff1877F2),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  _launchURL(
                      link: "https://chat.whatsapp.com/JJJvKP2TRpD8EBh6nbZU4B");
                },
                child: Container(
                  // addmoneyNfi (0:3484)
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                  // height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff2b2b44),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: CommonDeco().primary,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              FontAwesomeIcons.whatsapp,
                              size: 35,
                              color: Color(0xff00E676),
                            )),
                      ],
                    ),
                  ),
                )),
            InkWell(
                onTap: () {
                  _launchURL(link: "https://www.instagram.com/gridxecosystem/");
                },
                child: Container(
                  // addmoneyNfi (0:3484)
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                  // height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff2b2b44),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: CommonDeco().primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.asset(
                              "assets/instagram.png",
                              height: 25,
                              width: 35,
                            ))
                      ],
                    ),
                  ),
                )),
            InkWell(
                onTap: () {
                  _launchURL(link: "t.me/gridxfinance");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                  // height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff2b2b44),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: CommonDeco().primary,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.telegram,
                              size: 35,
                              color: Color(0xff30A4DA),
                            )),
                      ],
                    ),
                  ),
                )),
            InkWell(
                onTap: () {
                  _launchURL(link: "https://twitter.com/Gridxecosystem");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                  // height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff2b2b44),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: CommonDeco().primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: FaIcon(
                              FontAwesomeIcons.twitter,
                              size: 35,
                              color: Color(0xff30A4DA),
                            )),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget tabBarSection(double bnbToDollar, ProfileModel? value,
      QrModel? qrModel, GdxLiveRateModel? gdxRate) {
    return value != null && qrModel != null && gdxRate != null
        ? Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppText(
                            text: 'Crypto Trading',
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                          Navigator.push(context, PageTransition( type: PageTransitionType.fade, child: P2PTradingScreen()));

                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  // Creates border
                                  color: AppColor().oldThemeColors),
                              child: AppText(
                                text: "P2P Trading",
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: InkWell(
                        //     onTap: () {
                        //       // _launchUrl(
                        //       //     url:
                        //       //         "https://poocoin.app/tokens/${qrModel.data.publicAddress}");
                        //       _launchURL(
                        //           link:
                        //               "https://onmetabnb.web5.nexus/?walletAddress=${qrModel.data.publicAddress}");
                        //     },
                        //     child: Container(
                        //       padding: EdgeInsets.all(5),
                        //       margin: EdgeInsets.all(2),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(5),
                        //           // Creates border
                        //           color: AppColor().oldThemeColors),
                        //       child: AppText(
                        //         //  text: "DEX Trading",
                        //         text: "Buy / Sell",
                        //         fontSize: 15,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              TokenGrowthTile(
                bnbToDollar: bnbToDollar,
                profileValue: value,
                qrModel: qrModel,
                gdxLiveRateModel: gdxRate,
              )
            ],
          )
        : Center(
            child: CircularProgressIndicator(
            color: Colors.white,
          ));
  }

  Widget servicesWidget(HomePageController controller) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: BoxDecoration(
            color: AppColor().primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ServiceTile(
                onClick: () {
                  _launchURL(
                      link:
                          "https://bscscan.com/token/0x7ffb5a90cdbd2ae2a65d5bfe259ac936cc302be2");
                  //_launchURL(link: "https://bscscan.com/token/${controller.qrModel.value?.data.publicAddress}");
                },
                imageString: "assets/web.png",
                text: "Contract",
              )),
              Expanded(
                  child: ServiceTile(
                onClick: () {
                  _launchURL(link: "https://github.com/gridxeco");
                },
                imageString: "assets/code.png",
                text: "Open Source",
              )),
              Expanded(
                  child: ServiceTile(
                onClick: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: AuditReport(

                          )));

                },
                text: "Audit Report",
                imageString: "assets/noData.png",
              )),
              Expanded(
                  child: ServiceTile(
                onClick: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: ShareScreen(
                            userId: controller
                                .allUserProfileData.value?.data.username,
                          )));
                },
                text: "Share",
                imageString: "assets/share.png",
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget introWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: "Hi Alex Smith",
            fontSize: 18,
          ),
          AppText(
            text: "Good Morning",
            fontSize: 25,
          )
        ],
      ),
    );
  }
}
