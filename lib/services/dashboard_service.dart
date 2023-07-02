import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:palika_school/constants.dart';
import 'package:palika_school/models/student_model.dart';

import '../models/dashboard_model.dart';
import '../models/login_model.dart';
import 'package:dio/dio.dart';

class DashboardService {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

// get Ward List from api
  Future<PalikaProfileModel> fetchPalikaProfile(LoginModel? state) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.get(
      '$endpoint/palika-profile',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    PalikaProfileReponseModel palikaProfileResponse =
        PalikaProfileReponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (palikaProfileResponse.type == 'success' &&
          palikaProfileResponse.response != null) {
        return palikaProfileResponse.response!;
      } else {
        throw 'Something went wrong';
      }
    } else {
      throw 'Something went wrong';
    }
  }

  Future<TeacherAttendanceSummaryModel> fetchTeacherSummaryAttendance(
      LoginModel? state) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.post(
      '$endpoint/staff-attendance-summary',
      queryParameters: {
        'attendancedatebs': NepaliDateTime.now().format('yyyy-MM-dd')
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    TeacherAttendanceSummaryResponseModel teacherAttendanceResponse =
        TeacherAttendanceSummaryResponseModel.fromJson(
            jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (teacherAttendanceResponse.type == 'success' &&
          teacherAttendanceResponse.response != null) {
        return teacherAttendanceResponse.response!;
      } else {
        throw 'Something went wrong';
      }
    } else {
      throw 'Something went wrong';
    }
  }

  Future<StudentAttendanceSummaryModel> fetchStudentSummaryAttendance(
      LoginModel? state) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.post(
      '$endpoint/student-attendance-summary',
      queryParameters: {
        'attendancedatebs': NepaliDateTime.now().format('yyyy-MM-dd')
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    StudentAttendaceSummaryResponseModel studentAttedanceSummaryResponse =
        StudentAttendaceSummaryResponseModel.fromJson(
            jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (studentAttedanceSummaryResponse.type == 'success' &&
          studentAttedanceSummaryResponse.response != null) {
        return studentAttedanceSummaryResponse.response!;
      } else {
        throw 'Something went wrong';
      }
    } else {
      throw 'Something went wrong';
    }
  }
}
