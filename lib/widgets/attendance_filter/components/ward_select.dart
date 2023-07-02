import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class WardSelect extends StatelessWidget {
  List<String> list;
  String? value;
  void Function(String? value) onChange;
  WardSelect(
      {super.key, required this.list, this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      style: const TextStyle(color: Colors.white),
      onChanged: onChange,
      items: list
          .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
          .toList(),
      selectedItemBuilder: (BuildContext ctxt) {
        return list.map<Widget>((item) {
          return DropdownMenuItem(
              value: item,
              child: Text("Ward no.: $item ",
                  style: const TextStyle(color: Colors.white)));
        }).toList();
      },
      icon: SvgPicture.asset('assets/icons/down.svg'),
      iconSize: 42,
      underline: const SizedBox(),
    );
  }
}
