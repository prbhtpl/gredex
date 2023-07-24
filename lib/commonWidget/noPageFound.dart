import 'package:flutter/material.dart';

import '../Utility/app_toolbar.dart';

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppToolbar(onPressBackButton: () {
      Navigator.pop(context);
    },
      enableBackArrow: true,
      title: "No Page Found",
      appColor: Colors.transparent,
    ),);
  }
}
