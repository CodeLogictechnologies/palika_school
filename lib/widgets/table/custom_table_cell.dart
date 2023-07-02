import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  String title;
  CustomTableCell({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Text(title),
    );
  }
}
