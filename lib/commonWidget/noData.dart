import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(height: Get.height/2,
    
    width: Get.width,
      child: Center(
        child: Image.asset("assets/noData.png",scale: 1.5,color: Colors.white,),
      ),
    );
  }
}
