import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //   //<-- SEE HERE
      //   // Status bar color
      //   statusBarColor: Colors.green,
      //   statusBarIconBrightness: Brightness.dark,
      //   statusBarBrightness: Brightness.light,
      // )),
      body: Body(),
    );
  }
}
