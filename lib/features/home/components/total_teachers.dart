import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:palika_school/features/home/components/card_title.dart';
import 'package:palika_school/models/dashboard_model.dart';

List<Widget> _buildSection1ListItems() {
  return [
    Text('Section 1 List Item 1'),
    Text('Section 1 List Item 2'),
  ];
}

// ignore: must_be_immutable
class TotalTeachers extends StatelessWidget {
  TeacherAttendanceSummaryModel data;
  TotalTeachers({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(
          title: 'Teacher attendance report',
          subTitle: 'Date: ${NepaliDateTime.now().format('yyyy-MM-dd')}',
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text('Total Teacher :${data.totalTeacher}'),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(width: 15),
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF0F80C4)),
              ),
              SizedBox(
                width: 15,
              ),
              Text('Male:'),
              SizedBox(
                width: 2,
              ),
              Text(
                data.totalMale?.toString() ?? '0',
                style: TextStyle(color: Color(0xFF009FFF)),
              ),
              SizedBox(
                width: 40,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF39200)),
              ),
              SizedBox(
                width: 15,
              ),
              Text('Female:'),
              SizedBox(
                width: 2,
              ),
              Text(
                data.totalFemale?.toString() ?? '0',
                style: TextStyle(color: Color(0xFFF39200)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
