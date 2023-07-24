import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../commonWidget/appColors.dart';
import '../commonWidget/appText.dart';

class AppToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height = 50;
  final double elevationAppBar;
  final bool enableBackArrow;
  final GestureTapCallback? onPressBackButton, onPressWidget;
  final Color? appColor;
  final Widget leadingIcon, actionIcon;

  AppToolbar(
      {this.elevationAppBar = 0,
      this.title = "",
      this.actionIcon = const SizedBox(),
      this.onPressWidget,
      this.leadingIcon = const SizedBox(),
      this.appColor,
      this.onPressBackButton,
      this.enableBackArrow = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [actionIcon],
      leading: enableBackArrow != false
          ? GestureDetector(
              onTap: onPressBackButton,
              child: Container(height: 10,width: 10,
                margin: const EdgeInsets.only(left: 10, top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white70.withOpacity(0.1)),
                padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
                child: const Center(
                    child: Icon(CupertinoIcons.back, color: Colors.white)),
              ),
            )
          : IconButton(onPressed: onPressWidget, icon: leadingIcon),
      elevation: elevationAppBar,
      automaticallyImplyLeading: false,
      backgroundColor: appColor ?? AppColor().primaryColor,
      title: AppText(
        text: title,
        fontSize: 18,
      ),
      centerTitle: true,
      toolbarHeight: height,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
