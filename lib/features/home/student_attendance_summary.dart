import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:palika_school/features/home/components/home_card.dart';
import 'package:palika_school/models/dashboard_model.dart';

import './components/card_title.dart';

// ignore: must_be_immutable
class StudentAttendanceSummary extends StatelessWidget {
  StudentAttendanceSummaryModel data;
  StudentAttendanceSummary({super.key, required this.data});

  void _handleClick() {}

  @override
  Widget build(BuildContext context) {
    print(data.toJson());
    return HomeCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CardTitle(
        title: 'Student attendance report',
        subTitle: 'Date: ${NepaliDateTime.now().format('yyyy-MM-dd')}',
      ),
      SizedBox(
        height: 15,
      ),
      Padding(
        padding: EdgeInsets.only(left: 25),
        child: Text('Total Students: ${data.totalStudent}'),
      ),
      SizedBox(
        height: 15,
      ),
      AspectRatio(
        aspectRatio: 4 / 3,
        child: DChartBar(
          data: [
            {
              'id': 'Present',
              'data': [
                {'domain': 'Male', 'measure': data.presentMale},
                {'domain': 'Female', 'measure': data.presentFemale},
                {'domain': 'Others', 'measure': data.presentOther},
              ],
            },
            {
              'id': 'Absent',
              'data': [
                {'domain': 'Male', 'measure': data.absentMale},
                {'domain': 'Female', 'measure': data.absentFemale},
                {'domain': 'Others', 'measure': data.absentOther},
              ],
            },
          ],
          domainLabelPaddingToAxisLine: 16,
          axisLineTick: 1,
          axisLinePointTick: 1,
          axisLinePointWidth: 10,
          axisLineColor: Color(0xFF6B7280),
          measureLabelPaddingToAxisLine: 16,
          barColor: (barData, index, id) =>
              id == 'Present' ? Color(0xFF18AB64) : Color(0xFFF39200),
          barValue: (barData, index) => '${barData['measure']}',
          barValuePosition: BarValuePosition.outside,
          showBarValue: true,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF18AB64)),
          ),
          SizedBox(width: 10),
          Text('Male'),
          SizedBox(width: 30),
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFFF39200)),
          ),
          SizedBox(width: 10),
          Text('Female'),
        ],
      ),
      SizedBox(height: 10),
      // FractionallySizedBox(
      //   widthFactor: 1,
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(primary: Color(0xFF0F80C4)),
      //     child: const Text('View Details'),
      //     onPressed: _handleClick,
      //   ),
      // )
    ]));
  }
}
