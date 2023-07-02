import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/services/dashboard_service.dart';

import './auth_providers.dart';

final dashboardProvider = FutureProvider((ref) async {
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  DashboardService dashboardService = DashboardService();
  // ignore: unnecessary_cast
  final data = Future.wait([
    dashboardService.fetchPalikaProfile(state),
    dashboardService.fetchStudentSummaryAttendance(state),
    dashboardService.fetchTeacherSummaryAttendance(state)
  ]) as Future<List<dynamic>>;
  return data;
});
