import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/features/home/home_header.dart';
import 'package:palika_school/features/home/student_attendance_summary.dart';
import 'package:palika_school/features/home/teacher_attendance_summary.dart';

import '../providers/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(dashboardProvider).when(
        data: (data) => SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
                HomeHeader(
                    basic: data[0]?.basicschool ?? 0,
                    palikaname: data[0]?.palikaname ?? '',
                    secondary: data[0]?.secondaryschool ?? 0),
                const SizedBox(
                  height: 15,
                ),
                TeacherAttendanceSummary(data: data[2]),
                const SizedBox(
                  height: 20,
                ),
                StudentAttendanceSummary(data: data[1])
              ])),
            ),
        error: (error, err) => const Text('Error Came up!!'),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
