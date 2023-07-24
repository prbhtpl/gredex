import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';


import 'Utility/app_local_db.dart';
import 'Utility/app_routes.dart';


void main()async {
  await init();
  try{
    var dbStatus = await GetStorage.init(AppPreference.STORAGE_NAME);
    debugPrint('dataBase status: $dbStatus');

  }catch(e){
    debugPrint('dataBase init we exception: ${e.toString()}');
  }
  runApp(const MyApp());
}

Future init()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: const [

        Locale("en"),

      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,

      ],
  /*    theme: ThemeData(
   //     primarySwatch: AppColors.blue,
        fontFamily: 'Alkatra',
      ),*/
      title: 'Gridx',
      defaultTransition: Transition.fade,
  //    onGenerateRoute: RouteServices.generateRoute,
      popGesture: Get.isPopGestureEnable,
      debugShowCheckedModeBanner: false,
 //  home: AppPreference().token!=""? LoginSuccessfulScreen():const LoginPage(),
      initialRoute: AppRoutes.splash,
      getPages: appRoutes,


   );
  }
}

