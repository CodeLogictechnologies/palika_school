import 'package:flutter/material.dart';
import './components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = "/change_password";
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Body(),
    );
  }
}
