import 'package:flutter/material.dart';

class CustomTableHeader extends StatelessWidget {
  String title;
  double? width;
  CustomTableHeader({super.key, required this.title, this.width});

  @override
  Widget build(BuildContext context) {
    return width != null
        ? Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Color(0xFF8D8D8D), width: 1))),
            width: width ?? 0,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                child: Text(title)),
          )
        : Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Color(0xFF8D8D8D), width: 1))),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                child: Text(title)),
          );
  }
}
