import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gredex/screens/dashboard/dashboardScreen.dart';

import '../commonWidget/bottom_navigation.dart';
import '../screens/auth/loginPage/loginSuccessfulScreen.dart';
import '../screens/auth/loginPage/login_page.dart';
import '../screens/auth/register/register_page.dart';
import '../screens/splash/splash_page.dart';
import 'app_local_db.dart';

class AppRoutes{
  //splash
  static const splash = "/lib/screens/splash/splash_page.dart";
  static const loginPage = "/lib/screens/splash/splash_page.dart";
  static const registerPage = "/lib/screens/auth/register/register_page.dart";
  static const dashboardPage = "/lib/screens/dashboard/dashboardScreen.dart";


}
var appRoutes = <GetPage<dynamic>>[
  //splash
  GetPage(name: AppRoutes.splash, page: () =>AppPreference().token!=""? const LoginSuccessfulScreen():const LoginPage()),
  //GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
  GetPage(name: AppRoutes.loginPage, page: () => const LoginPage()),
  GetPage(name: AppRoutes.registerPage, page: () => const RegisterPage()),
  GetPage(name: AppRoutes.dashboardPage, page: () =>  DashboardScreen()),

];

