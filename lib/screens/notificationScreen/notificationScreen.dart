import 'package:flutter/material.dart';
import 'package:gredex/commonWidget/noData.dart';

import '../../Utility/app_toolbar.dart';
import '../../commonWidget/appColors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().primaryColor,
      appBar: AppToolbar(
        onPressBackButton: () {
          Navigator.pop(context);
        },
        enableBackArrow: true,
        title: "Notifications",
        appColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [NoData()],
      ),
    );
  }
}
