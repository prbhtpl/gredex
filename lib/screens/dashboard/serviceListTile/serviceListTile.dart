import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commonWidget/appText.dart';
import '../../../commonWidget/commonDecoration.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({Key,this.imageString="",this.text='',this.onClick, key}) : super(key: key);
  final String imageString,text;
  final GestureTapCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onClick,
    child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(decoration: CommonDeco().primary,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Image.asset(imageString,height: 40,width: 40,color: Colors.blue,)
              ),
            ],
          ),
        ),
         SizedBox(height: 10,),
         AppText(text: text,fontSize: 11,textLine: 2,)
      ],
    ));
  }
}
