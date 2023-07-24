import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';
import 'package:gredex/screens/dashboard/dashboardScreen.dart';
import 'package:gredex/screens/myPlan/myPlanScreen.dart';
import 'package:gredex/screens/reward/rewardScreen.dart';
import 'package:gredex/screens/status/statusScreen.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../screens/setting/settingScreen.dart';
import 'appColors.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Dashboard"),
        activeColorPrimary: AppColor().themeColors,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.doc_append),
        title: ("My Plans"),
        activeColorPrimary: AppColor().themeColors,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bolt),
        title: ("Reward"),
        activeColorPrimary: AppColor().themeColors,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.timer),
        title: ("Status"),
        activeColorPrimary: AppColor().themeColors,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: AppColor().themeColors,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  //PersistentTabController _controller;

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const DashboardScreen(),
      const MyPlans(),
      const MyReward(),
      const StatusScreen(),
      const SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await ShowBox().showBox(
            showCancelButton: true,
            text: "",
            onButtonClick: () {
              exit(0);
            },
            titleContent: "Are you sure want to exit app?",
            buttonText: "OK");
      },
      child: PersistentTabView(

        navBarHeight: 70,
        context,
        //margin:EdgeInsets.symmetric(horizontal: 10) ,
        controller: _controller,
        padding: const NavBarPadding.symmetric(vertical: 12),
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,

        backgroundColor: AppColor().secondPrimaryColor,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle
            .style13, // Choose the nav bar style with this property.
      ),
    );
  }
}
