import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.translate(
            offset: const Offset(0, -4),
            child: FractionallySizedBox(
                widthFactor: 1,
                child: FittedBox(
                  child: SvgPicture.asset('assets/icons/login-top-wave.svg'),
                  fit: BoxFit.fill,
                ))),
        const Text(
          'Welcome,',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('"Smart School Monitoring System"'),
        const SizedBox(height: 10),
        const Text('Glad to see you !'),
        const SizedBox(
          height: 30,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SignForm(),
        )),
        Transform.translate(
            offset: const Offset(0, 10),
            child: FractionallySizedBox(
                widthFactor: 1,
                child: FittedBox(
                  child: SvgPicture.asset('assets/icons/login-bottom.svg'),
                  fit: BoxFit.fill,
                ))),
      ],
    ));
  }
}
