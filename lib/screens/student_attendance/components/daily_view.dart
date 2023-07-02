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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(60),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                StudentTableHeader(title: 'S.N'),
                StudentTableHeader(title: 'Class'),
                StudentTableHeader(
                  title: 'Male',
                  isSpan: true,
                  subTitle: const ['P', 'A'],
                ),
                StudentTableHeader(
                  title: 'Female',
                  isSpan: true,
                  subTitle: const ['P', 'A'],
                ),
                StudentTableHeader(title: 'Total'),
              ],
            ),
            ..._generateData(data),
          ],
        )
      ]),
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
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                (i + 1).toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(data[i].classname),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(color: Color(0xFF8D8D8D), width: 1))),
                  child: Text(
                    data[i].presentmale?.toString() ?? '-',
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Text(
                    data[i].absentmale?.toString() ?? '-',
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(width: 1, color: Color(0xFF8D8D8D)))),
                  child: Text(
                    data[i].presentfemale?.toString() ?? '-',
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    data[i].absentfemale?.toString() ?? '-',
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                data[i].totalstudents?.toString() ?? '-',
                textAlign: TextAlign.center,
              ),
            )
          ]));
    }
    return datas;
  }
}
