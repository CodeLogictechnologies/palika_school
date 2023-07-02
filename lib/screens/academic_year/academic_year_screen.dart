import 'package:flutter/material.dart';
import './components/body.dart';

class AcademicYearScreen extends StatelessWidget {
  static String routeName = "/academic_year";
  const AcademicYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Academic Year')),
      body: Body(),
    );
  }
}
