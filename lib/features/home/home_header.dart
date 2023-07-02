import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palika_school/providers/auth_providers.dart';
import 'package:palika_school/screens/profile/profile_screen.dart';

class HomeHeader extends ConsumerWidget {
  final int basic;
  final int secondary;
  final String palikaname;
  const HomeHeader(
      {super.key,
      required this.basic,
      required this.palikaname,
      required this.secondary});

  @override
  Widget build(BuildContext context, ref) {
    return Stack(
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart, children: [
          Container(
            height: 218,
            color: Color(0xFFE4F1FF),
          ),
          FractionallySizedBox(
              widthFactor: 1,
              child: FittedBox(
                child: SvgPicture.asset('assets/icons/wave.svg'),
                fit: BoxFit.fill,
              )),
        ]),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: Text(
                  palikaname,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         // Text(
              //         //   "Hello,",
              //         //   style: TextStyle(
              //         //       fontSize: 24, fontWeight: FontWeight.w500),
              //         // ),
              //         FractionallySizedBox(
              //           widthFactor: 1,
              //           child: Text(
              //             'Kathekhola Rural Municipality',
              //             style: TextStyle(
              //                 fontSize: 20, fontWeight: FontWeight.w500),
              //             textAlign: TextAlign.center,
              //           ),
              //         )
              //       ],
              //     ),
              //     // GestureDetector(
              //     //   onTap: () {
              //     //     Navigator.pushNamed(context, ProfileScreen.routeName);
              //     //   },
              //     //   child: Container(
              //     //     width: 50,
              //     //     height: 50,
              //     //     decoration: BoxDecoration(
              //     //       borderRadius: BorderRadius.circular(30),
              //     //       border: Border.all(width: 4, color: Color(0xFFFFFFFF)),
              //     //     ),
              //     //     child: Image.asset('assets/images/thumbnail.png'),
              //     //     // child: Container(
              //     //     //   width: 25,
              //     //     //   height: 25,
              //     //     //   decoration: BoxDecoration(
              //     //     //       borderRadius: BorderRadius.circular(30),
              //     //     //       color: Color(0xFF1964BB)),
              //     //     // ),
              //     //   ),
              //     // )
              //   ],
              // ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset('assets/images/polygon.png'),
                          Text(
                            secondary.toString(),
                            style: TextStyle(
                                color: Color(0xFFB11F3E),
                                fontSize: 36,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Text(
                        "Secondary School",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset('assets/images/polygon.png'),
                          Text(
                            basic.toString(),
                            style: TextStyle(
                                color: Color(0xFF0F80C4),
                                fontSize: 36,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Text(
                        "Basic School",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
