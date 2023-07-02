import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:palika_school/constants.dart';
import 'package:palika_school/models/student_model.dart';
import 'package:tuple/tuple.dart';

import '../models/login_model.dart';
import 'package:dio/dio.dart';

class StudentService {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

// get Ward List from api
  Future<List<dynamic>> fetchStudentsAttendance(LoginModel? state,
      Tuple5<int, String, String, String, int> paramter) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.post(
      '$endpoint/student-attendance-report',
      queryParameters: {
        'organizationid': paramter.item1,
        'reporttype': paramter.item2, // datepicker | monthpicker
        'attendancedatebs': paramter.item3, // Format: 2080-02-30
        'monthid': paramter.item4, // Format: 01, 02, 11, 12
        'academicyear': 2080 //paramter.item5
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    dynamic studentAttendanceResponse;
    if (paramter.item2 == "datepicker") {
      studentAttendanceResponse = StudentDailyAttendanceResponseModel.fromJson(
          jsonDecode(response.data));
    } else {
      studentAttendanceResponse =
          StudentMonthlyAttendanceResponseModel.fromJson(
              jsonDecode(response.data));
    }
    if (response.statusCode == 200) {
      if (studentAttendanceResponse.type == 'success' &&
          studentAttendanceResponse.response != null) {
        // print(
        //     'ALL GOOD----->${studentAttendanceResponse.response?.map((x) => x.toJson()).toList() ?? []}');
        return studentAttendanceResponse.response!;
      } else {
        // print('EROROOOOOOR+++++++++++++$response');
        throw studentAttendanceResponse.message ?? 'Something went wrong!!!!';
      }
    } else {
      // print('EROROOOOOOR-------------->$response');
      throw studentAttendanceResponse.message ?? 'Something went wrong!!!!';
    }
  }
}
