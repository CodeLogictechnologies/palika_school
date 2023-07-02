import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/services/teacher_service.dart';
import 'package:tuple/tuple.dart';

import './auth_providers.dart';

final teacherAttendanceProvider = FutureProvider.family(
    (ref, Tuple5<int, String, String, String, int> parameter) async {
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  TeacherService teacherService = TeacherService();
  if (parameter.item1 == 0) {
    return [];
  }
  return teacherService.fetchStaffsAttendance(state, parameter);
});
