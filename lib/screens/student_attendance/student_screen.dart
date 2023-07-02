import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:palika_school/screens/student_attendance/components/daily_view.dart';
import 'package:palika_school/screens/student_attendance/components/monthly_view.dart';
import 'package:palika_school/widgets/attendance_filter/attendance_filter.dart';
import 'package:tuple/tuple.dart';

import '../../providers/student_providers.dart';

class StudentScreen extends ConsumerStatefulWidget {
  const StudentScreen({super.key});

  @override
  ConsumerState<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends ConsumerState<StudentScreen> {
  String reportType = 'datepicker';
  String? dropdownValue;
  String? _selectedMonth;
  NepaliDateTime? _selectedDateTime = NepaliDateTime.now();
  int organizationid = 0;

  @override
  void initState() {
    super.initState();
    dropdownValue = '1';
  }

  void handleValueChange(value, module) {
    switch (module) {
      case "organizationid":
        organizationid = value;
        break;

      case "dropdownValue":
        dropdownValue = value;
        break;

      case "selectedMonth":
        _selectedMonth = value;
        break;

      case "selectedDateTime":
        _selectedDateTime = value;

      case "reportType":
        reportType = value;
        break;

      default:
        break;
    }
  }

  void handleRefreshApi(filter) {
    ref.refresh(studentAttendanceProvider(filter).future);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Text(
            'Student Attendance Report',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          AttendanceFilter(
              reportType: reportType,
              dropdownValue: dropdownValue,
              selectedMonth: _selectedMonth,
              selectedDateTime: _selectedDateTime,
              organizationid: organizationid,
              onChange: handleValueChange,
              refreshApi: handleRefreshApi),
          ref
              .watch(studentAttendanceProvider(Tuple5(
                  organizationid,
                  reportType,
                  _selectedDateTime!.format('yyyy-MM-dd'),
                  _selectedMonth.toString(),
                  2080)))
              .when(
                  data: (data) {
                    return reportType == "datepicker"
                        ? DailyView(data: data, date: _selectedDateTime)
                        : MonthlyView(
                            data: data, selectedMonth: _selectedMonth);
                  },
                  error: (error, err) {
                    return reportType == "datepicker"
                        ? DailyView(data: [])
                        : MonthlyView(data: [], selectedMonth: _selectedMonth);
                  },
                  loading: () => const Expanded(
                      child: Center(child: CircularProgressIndicator())))
        ],
      ),
    ));
  }
}
