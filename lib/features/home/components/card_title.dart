import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final String? subTitle;

  const CardTitle({super.key, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: subTitle != null ? 40 : 19,
          color: Color(0xFF18AB64),
        ),
        SizedBox(
          width: 10,
        ),
        subTitle != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(subTitle ?? '')
                ],
              )
            : Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
      ],
    );
  }
}
