import 'package:flutter/material.dart';

class StudentTableHeader extends StatelessWidget {
  bool isSpan = false;
  String title;
  List<String>? subTitle;

  StudentTableHeader(
      {super.key, this.isSpan = false, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return isSpan
        ? Column(children: [
            SizedBox(height: 5),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xFF8D8D8D), width: 1))),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                            bottom: BorderSide(
                                width: 1, color: Color(0xFF8D8D8D)))),
                    child: Text(subTitle?.elementAt(0) ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xFF8D8D8D)))),
                    padding: EdgeInsets.all(5),
                    child: Text(subTitle?.elementAt(1) ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                  )),
                ],
              ),
            )
          ])
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 17.5),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
            )),
            child: Text(title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          );
  }
}
