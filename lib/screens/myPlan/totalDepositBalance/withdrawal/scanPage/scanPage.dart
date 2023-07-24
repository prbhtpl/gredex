import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:images_picker/images_picker.dart';
import 'package:scan/scan.dart';

import '../../../../../getXController/withdrawal/withdrawalTransController.dart';

class ScanPage extends StatefulWidget {
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  ScanController controller = ScanController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawalController>(init:WithdrawalController() ,builder: (withController) {
      return Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Stack(
            children: [
              ScanView(
                controller: controller,
                scanAreaScale: .7,
                scanLineColor: Colors.green,
                onCapture: (data) {

                  print("$data");

                  Get.back();setState(() {
                    withController.address.value.text=data;
                  });

                  controller.pause();
                  /*  Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('scan result'),
                      ),
                      body: Center(
                        child: Text(data),
                      ),
                    );
                  },
                )).then((value) {
                  controller.resume();
                });*/
                },
              ),
              Positioned(
                right: 0,left: 0,bottom: 150,
                child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      controller.toggleTorchMode();
                    }, icon: Icon(Icons.lightbulb,color: Colors.white,)),

                     IconButton(onPressed: ()async{
                       List<Media>? res = await ImagesPicker.pick();
                       print("resres ${res}");
                       if (res != null) {
                         String? str = await Scan.parse(res[0].path);
                         print("Strtrc ${str}");
                         if (str != null) {
                           Get.back();
                           setState(() {
                             withController.address.value.text=str;
                           });
                         }else{
                           Get.back();
                           AppUtility.showErrorSnackBar("No QR code Found!!");
                         }
                       }
                    }, icon: Icon(Icons.image,color: Colors.white,)),




                   /* ElevatedButton(
                      child: Text("toggleTorchMode"),
                      onPressed: () {
                        controller.toggleTorchMode();
                      },
                    ),*/
                  /*  ElevatedButton(
                      child: Text("pause"),
                      onPressed: () {
                        controller.pause();
                      },
                    ),
                    ElevatedButton(
                      child: Text("resume"),
                      onPressed: () {
                        controller.resume();
                      },
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}