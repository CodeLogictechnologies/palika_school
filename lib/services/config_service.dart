import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:palika_school/constants.dart';

import '../models/config_model.dart';
import '../models/login_model.dart';
import 'package:dio/dio.dart';

class ConfigService {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

// get Ward List from api
  Future<List<String>> fetchWards(LoginModel? state) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.get(
      '$endpoint/ward-list',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    WardListResponseModel wardResponse =
        WardListResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (wardResponse.type == 'success' && wardResponse.response != null) {
        return wardResponse.response!;
      } else {
        throw wardResponse.message;
      }
    } else {
      throw wardResponse.message;
    }
  }

// get Ward Schools from api
  Future<List<SchoolListModel>> fetchSchools(
      LoginModel? state, String? wardno, String? searchKey) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.post(
      '$endpoint/school-list',
      queryParameters: {'wardname': wardno, 'searchkey': searchKey},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid,
        },
      ),
    );
    SchoolListResponseModel schoolResponse =
        SchoolListResponseModel.fromJson(jsonDecode(response.data));
    if (schoolResponse.type == 'success' && schoolResponse.response != null) {
      return schoolResponse.response!;
    } else {
      throw schoolResponse.message;
    }
  }
}
