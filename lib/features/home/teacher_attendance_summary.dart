import 'package:flutter/material.dart';
import 'package:palika_school/features/home/components/card_title.dart';
import 'package:palika_school/features/home/components/home_card.dart';
import 'package:palika_school/features/home/components/total_teachers.dart';
import 'package:palika_school/models/dashboard_model.dart';

import 'components/single_teacher_figure.dart';

// ignore: must_be_immutable
class TeacherAttendanceSummary extends StatelessWidget {
  TeacherAttendanceSummaryModel data;
  TeacherAttendanceSummary({super.key, required this.data});

  void _handleClick() {}

  @override
  Widget build(BuildContext context) {
    print('---------------->$data');
    return HomeCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TotalTeachers(data: data),
        const SizedBox(
          height: 15,
        ),
        const Divider(color: Color(0xFF9CA3AF)),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(child: SingleTeacherFigure(data: data, type: 'p')),
            Expanded(child: SingleTeacherFigure(data: data, type: 'a')),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // FractionallySizedBox(
        //   widthFactor: 1,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(primary: Color(0xFF0F80C4)),
        //     child: const Text('View Details'),
        //     onPressed: _handleClick,
        //   ),
        // )
      ],
    ));
  }
}
