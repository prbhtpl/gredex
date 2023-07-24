import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gredex/commonWidget/appColors.dart';

import '../../../commonWidget/appText.dart';
import '../../../commonWidget/commonDecoration.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({Key,this.imageString='',this.text="",this.onClick, key}) : super(key: key);
final String imageString,text;
final GestureTapCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
       //   border: Border.all(color: Colors.grey.shade100),
       //    boxShadow: [
       //      BoxShadow(
       //          color: Colors.grey.withOpacity(0.2),
       //          blurRadius: 15,
       //          offset: Offset(0,3)
       //      ),
       //    ]
      ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:Image.asset(imageString,height: 25,width: 25,color: Colors.white,)
                ),
              ],
            ),
          ),
          SizedBox(width: 10,),
          AppText(text: text,fontSize: 12,),
          const Expanded(child: SizedBox()),
          const Icon(size:18,
            CupertinoIcons.forward,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
