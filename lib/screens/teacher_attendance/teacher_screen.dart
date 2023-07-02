import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:palika_school/providers/student_providers.dart';
import 'package:palika_school/providers/teacher_providers.dart';
import './components/daily_view.dart';
import './components/monthly_view.dart';
import 'package:tuple/tuple.dart';

import '../../widgets/attendance_filter/attendance_filter.dart';

class TeacherScreen extends ConsumerStatefulWidget {
  const TeacherScreen({super.key});

  @override
  ConsumerState<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends ConsumerState<TeacherScreen> {
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
            'Teacher Attendance Report',
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
              .watch(teacherAttendanceProvider(Tuple5(
                  organizationid,
                  reportType,
                  _selectedDateTime!.format('yyyy-MM-dd'),
                  _selectedMonth.toString(),
                  2080)))
              .when(
                  data: (data) => reportType == "datepicker"
                      ? DailyView(data: data, date: _selectedDateTime)
                      : MonthlyView(data: data, selectedMonth: _selectedMonth),
                  error: (error, err) => reportType == "datepicker"
                      ? DailyView(data: [])
                      : MonthlyView(data: []),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()))
        ],
      ),
    ));
  }
}
