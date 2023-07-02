import 'package:flutter/material.dart';
import 'package:palika_school/screens/home/home_screen.dart';
import '../../sign_in/sign_in_screen.dart';

// This is the best practice

class Body extends StatefulWidget {
  final bool isAuthenticated;

  const Body({super.key, required this.isAuthenticated});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void _checkLogin() async {
    Future.delayed(const Duration(seconds: 3), () {
      print(widget.isAuthenticated);
      widget.isAuthenticated
          ? Navigator.pushReplacementNamed(context, HomeScreen.routeName)
          : Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                )),
            const SizedBox(
              height: 20.0,
              width: 20.0,
              child: Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('©2023 Code Logic Technologies Pvt. Ltd.'),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
