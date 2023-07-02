import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/services/student_service.dart';
import 'package:tuple/tuple.dart';

import './auth_providers.dart';

final studentAttendanceProvider = FutureProvider.family(
    (ref, Tuple5<int, String, String, String, int> parameter) async {
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  StudentService studentService = StudentService();
  if (parameter.item1 == 0) {
    return [];
  }
  return studentService.fetchStudentsAttendance(state, parameter);
});
