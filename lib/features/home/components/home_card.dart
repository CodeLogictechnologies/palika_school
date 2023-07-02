import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final Widget child;

  const HomeCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xFF9CA3AF)),
            borderRadius: BorderRadius.circular(4)),
        child: child);
  }
}
