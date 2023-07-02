import 'package:flutter/material.dart';
import 'package:palika_school/features/home/components/card_title.dart';
import 'package:d_chart/d_chart.dart';
import 'package:palika_school/models/dashboard_model.dart';

class SingleTeacherFigure extends StatelessWidget {
  TeacherAttendanceSummaryModel data;
  String type;
  SingleTeacherFigure({super.key, required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    final bool isPresentType = type == "p" ? true : false;
    final bool isNoPresent = isPresentType &&
        data.presentFemale == 0 &&
        data.presentMale == 0 &&
        data.presentOther == 0;
    final bool isNoAbsent = !isPresentType &&
        data.absentFemale == 0 &&
        data.absentMale == 0 &&
        data.absentOther == 0;

    return Container(
      child: Column(
        children: [
          CardTitle(title: '${isPresentType ? 'Present' : 'Absent'} Teacher'),
          SizedBox(
            height: 30,
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(200)),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Stack(
                  children: [
                    DChartPie(
                      data: (isNoPresent || isNoAbsent)
                          ? [
                              {
                                'domain': 'None',
                                'measure': data.totalTeacher == 0
                                    ? 1
                                    : data.totalTeacher
                              }
                            ]
                          : [
                              {
                                'domain': 'Male',
                                'measure': isPresentType
                                    ? data.presentMale
                                    : data.absentFemale
                              },
                              {
                                'domain': 'Female',
                                'measure': isPresentType
                                    ? data.presentFemale
                                    : data.absentFemale
                              },
                              {
                                'domain': 'Others',
                                'measure': isPresentType
                                    ? data.presentOther
                                    : data.absentOther
                              },
                            ],
                      fillColor: (pieData, index) => (isNoPresent || isNoAbsent)
                          ? Color(0xFFF3F4F6)
                          : index == 0
                              ? Color(0xFF009FFF)
                              : index == 1
                                  ? Color(0xFF0571B1)
                                  : Color(0xFFF39200),
                      donutWidth: 16,
                      labelColor: Colors.white,
                    ),
                    Align(
                        child: Text((isPresentType
                                ? data.totalPresent?.toString()
                                : data.totalAbsent?.toString()) ??
                            '0')),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 54, top: 10),
            child: Row(
              children: [
                Text('Male: '),
                Text(
                  isPresentType
                      ? data.presentMale?.toString() ?? '0'
                      : data.absentFemale?.toString() ?? '0',
                  style: TextStyle(color: Color(0xFF009FFF)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 54, top: 10),
            child: Row(
              children: [
                Text('Female: '),
                Text(
                  isPresentType
                      ? data.presentFemale?.toString() ?? '0'
                      : data.absentFemale?.toString() ?? '0',
                  style: TextStyle(color: Color(0xFF0571B1)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 54, top: 10),
            child: Row(
              children: [
                Text('Others: '),
                Text(
                  isPresentType
                      ? data.presentOther?.toString() ?? '0'
                      : data.absentOther?.toString() ?? '0',
                  style: TextStyle(color: Color(0xFFF39200)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
