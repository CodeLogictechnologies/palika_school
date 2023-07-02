import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButtom extends StatelessWidget {
  bool? loading;
  String text;
  void Function()? onPressed;
  CustomButtom({super.key, this.loading, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 44.0,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF1873DC), Color(0xFF185CAB)]),
            borderRadius: BorderRadius.circular(4)),
        child: Consumer(
            builder: (context, watch, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text(loading == true ? 'Loading...' : text),
                  onPressed: onPressed,
                )),
      ),
    );
  }
}
