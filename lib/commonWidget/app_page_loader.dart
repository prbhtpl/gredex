
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/commonWidget/appColors.dart';

import '../Utility/app_utility.dart';

class AppPageLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Function? onRefresh;
  final bool enablePullToRefresh;

  AppPageLoader({required this.isLoading, required this.child, this.onRefresh, this.enablePullToRefresh = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: enablePullToRefresh,
          child: RefreshIndicator(
              onRefresh: () {
                if (onRefresh != null) onRefresh!();
                return Future.value(true);
              },
              child: child),
          replacement: child,
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            width: Get.width,
            height: Get.height,
            color:Colors.white70.withOpacity(0.4),
            alignment: Alignment.center,
            child: AppUtility.loader(),
          ),
        )
      ],
    );
  }
}
