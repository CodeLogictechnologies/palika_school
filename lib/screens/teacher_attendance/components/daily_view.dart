import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../../../features/students/widgets/student_table_header.dart';

// ignore: must_be_immutable
class DailyView extends StatelessWidget {
  List<dynamic> data;
  NepaliDateTime? date;
  DailyView({super.key, required this.data, this.date});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFB11F3E)),
              ),
              const SizedBox(width: 10),
              const Text('Lately IN and early Out'),
            ],
          ),
          const SizedBox(height: 12),
          Text('Attendance of ${date?.format('MMMM d, y') ?? ''}'),
          const SizedBox(height: 10),
          Table(
            border: const TableBorder(
                right: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                top: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                bottom: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                left: BorderSide(width: 1, color: Color(0xFF8D8D8D)),
                verticalInside: BorderSide(width: 1, color: Color(0xFF8D8D8D))),
            columnWidths: const <int, TableColumnWidth>{
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
                  StudentTableHeader(title: 'Staff'),
                  StudentTableHeader(title: 'IN'),
                  StudentTableHeader(title: 'OUT'),
                  StudentTableHeader(title: 'Working Hour'),
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
                  ? const Color(0xFFF4F4F4)
                  : const Color(0xFFFFFFFF)),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                (i + 1).toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(data[i].staffname),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                data[i].checkintime ?? '-',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: data[i].checkinstatus == 'Red'
                        ? Color(0xFFB11F3E)
                        : Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                data[i].checkouttime ?? '-',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: data[i].checkoutstatus == 'Red'
                        ? Color(0xFFB11F3E)
                        : Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                data[i].workinghours ?? '-',
                textAlign: TextAlign.center,
              ),
            )
          ]));
    }
    return datas;
  }
}
