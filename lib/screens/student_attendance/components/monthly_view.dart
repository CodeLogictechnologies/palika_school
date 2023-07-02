import 'package:flutter/material.dart';

import '../../../features/students/widgets/student_table_header.dart';
import '../../../models/config_model.dart';

final List<DropdownModel> months = [
  DropdownModel(label: 'Baisakh', value: '01'),
  DropdownModel(label: 'Jestha', value: '02'),
  DropdownModel(label: 'Ashadh', value: '03'),
  DropdownModel(label: 'Shrawan', value: '04'),
  DropdownModel(label: 'Bhadra', value: '05'),
  DropdownModel(label: 'Ashoj', value: '06'),
  DropdownModel(label: 'Kartik', value: '07'),
  DropdownModel(label: 'Mangsir', value: '08'),
  DropdownModel(label: 'Poush', value: '09'),
  DropdownModel(label: 'Magh', value: '10'),
  DropdownModel(label: 'Falgun', value: '11'),
  DropdownModel(label: 'Chaitra', value: '12')
];

// ignore: must_be_immutable
class MonthlyView extends StatelessWidget {
  List<dynamic> data;
  String? selectedMonth;
  MonthlyView({super.key, required this.data, required this.selectedMonth});

  @override
  Widget build(BuildContext context) {
    final month = months.firstWhere((mth) => mth.value == selectedMonth).label;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attendance of $month, 2080'),
          // Text('School open days: ${data[0]?.total}'),
          const SizedBox(height: 10),
          Table(
            border: TableBorder(
                right: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                top: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                bottom: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                left: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                verticalInside: BorderSide(width: 1, color: Color(0xFF8D8D8D))),
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth(30),
              1: FlexColumnWidth(),
              2: FixedColumnWidth(70),
              3: FixedColumnWidth(70),
              4: FixedColumnWidth(90),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  StudentTableHeader(title: 'S.N'),
                  StudentTableHeader(title: 'CLASS'),
                  StudentTableHeader(title: 'MALE'),
                  StudentTableHeader(title: 'FEMALE'),
                  StudentTableHeader(title: 'TOTAL'),
                ],
              ),
              ..._generateData(data),
            ],
          )
        ],
      ),
    );
  }

  _generateData(List<dynamic> data) {
    List<TableRow> datas = [];
    for (var i = 0; i < data.length; i++) {
      datas.add(TableRow(
          decoration: BoxDecoration(
              color: (i != 0 && i % 2 == 1)
                  ? Color(0xFFF4F4F4)
                  : Color(0xFFFFFFFF)),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                (i + 1).toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(data[i].classname),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                data[i].presentmalepercent,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                data[i].presentfemalepercent,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                data[i].presentpercent,
                textAlign: TextAlign.center,
              ),
            )
          ]));
    }
    return datas;
  }
}
