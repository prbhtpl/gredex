import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/commonWidget/appColors.dart';
import 'package:gredex/commonWidget/appText.dart';
import 'package:gredex/commonWidget/bottom_navigation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../Utility/app_utility.dart';
import '../../../getXController/homePageController/homePageController.dart';

class LoginSuccessfulScreen extends StatefulWidget {
  const LoginSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<LoginSuccessfulScreen> createState() => _LoginSuccessfulScreenState();
}

class _LoginSuccessfulScreenState extends State<LoginSuccessfulScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  final HomePageController _homePageController = Get.put(HomePageController());



  @override
  void initState() {
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );

 _checkBiometrics();
//  _homePageController.initData(showPopUp: true);


    super.initState();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Verify your Identity',
        options: const AuthenticationOptions(
            stickyAuth: true, sensitiveTransaction: true),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print("isme Ayay");
      _homePageController.initData(showPopUp: true);
     /* print("PlatformExceptionCheckBioMetrick $e");*/
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');


  if (_authorized == 'Authorized') {
    AppUtility.showSuccessSnackBar(_authorized.toString());
    _homePageController.initData(showPopUp: true);
  } else {
    AppUtility.showErrorSnackBar(_authorized.toString());
  }


  }
  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;

    } on PlatformException catch (e) {

      setState(() {
        canCheckBiometrics = false;
        _canCheckBiometrics = false;
        print("checkBiometric ${canCheckBiometrics}");
      });

      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
      print("checkBiometric ${canCheckBiometrics}");
    });
      _authenticate();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/design/logined.png"),
          AppText(
            text: "Login Successful",
            textColor: AppColor().green,
          )
        ],
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

// Scaffold(
// appBar: AppBar(
// title: const Text('Plugin example app'),
// ),
// body: ListView(
// padding: const EdgeInsets.only(top: 30),
// children: <Widget>[
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// if (_supportState == _SupportState.unknown)
// const CircularProgressIndicator()
// else if (_supportState == _SupportState.supported)
// const Text('This device is supported')
// else
// const Text('This device is not supported'),
// const Divider(height: 100),
// Text('Can check biometrics: $_canCheckBiometrics\n'),
// ElevatedButton(
// onPressed: _checkBiometrics,
// child: const Text('Check biometrics'),
// ),
// const Divider(height: 100),
// Text('Available biometrics: $_availableBiometrics\n'),
// ElevatedButton(
// onPressed: _getAvailableBiometrics,
// child: const Text('Get available biometrics'),
// ),
// const Divider(height: 100),
// Text('Current State: $_authorized\n'),
// if (_isAuthenticating)
// ElevatedButton(
// onPressed: _cancelAuthentication,
// // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
// // ignore: prefer_const_constructors
// child: Row(
// mainAxisSize: MainAxisSize.min,
// children: const <Widget>[
// Text('Cancel Authentication'),
// Icon(Icons.cancel),
// ],
// ),
// )
// else
// Column(
// children: <Widget>[
// ElevatedButton(
// onPressed: _authenticate,
// // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
// // ignore: prefer_const_constructors
// child: Row(
// mainAxisSize: MainAxisSize.min,
// children: const <Widget>[
// Text('Authenticate'),
// Icon(Icons.perm_device_information),
// ],
// ),
// ),
// ElevatedButton(
// onPressed: _authenticateWithBiometrics,
// child: Row(
// mainAxisSize: MainAxisSize.min,
// children: <Widget>[
// Text(_isAuthenticating
// ? 'Cancel'
//     : 'Authenticate: biometrics only'),
// const Icon(Icons.fingerprint),
// ],
// ),
// ),
// ],
// ),
// ],
// ),
// ],
// )
// );
