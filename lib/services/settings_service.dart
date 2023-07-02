import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:palika_school/constants.dart';
import 'package:palika_school/models/student_model.dart';
import 'package:tuple/tuple.dart';

import '../models/login_model.dart';
import 'package:dio/dio.dart';

class SettingsService {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

// get Ward List from api
  Future<bool?> checkCurrentPassword(
      LoginModel? state, String currentPassword) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.post(
      '$endpoint/check-current-password',
      queryParameters: {
        'current_password': currentPassword,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    final checkPasswordResponse =
        LogoutResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (checkPasswordResponse.type == 'success' &&
          checkPasswordResponse.response != null) {
        // print(
        //     'ALL GOOD----->${checkPasswordResponse.response?.map((x) => x.toJson()).toList() ?? []}');
        return checkPasswordResponse.response;
      } else {
        // print('EROROOOOOOR+++++++++++++$response');
        throw checkPasswordResponse.message ?? 'Something went wrong!!!!';
      }
    } else {
      // print('EROROOOOOOR-------------->$response');
      throw checkPasswordResponse.message ?? 'Something went wrong!!!!';
    }
  }

  Future<bool?> changePassword(
      LoginModel? state, Tuple2<String, String> parameter) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.post(
      '$endpoint/update-password',
      queryParameters: {
        'new_password': parameter.item1,
        'new_password_confirmation': parameter.item2,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    final changePasswordResponse =
        LogoutResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (changePasswordResponse.type == 'success' &&
          changePasswordResponse.response != null) {
        // print(
        //     'ALL GOOD----->${changePasswordResponse.response?.map((x) => x.toJson()).toList() ?? []}');
        return changePasswordResponse.response;
      } else {
        // print('EROROOOOOOR+++++++++++++$response');
        throw changePasswordResponse.message ?? 'Something went wrong!!!!';
      }
    } else {
      // print('EROROOOOOOR-------------->$response');
      throw changePasswordResponse.message ?? 'Something went wrong!!!!';
    }
  }

  Future<bool?> updateProfile(
      LoginModel? state, Tuple3<String, String, File?> parameter) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.post(
      '$endpoint/profile-update',
      data: parameter.item3 != null
          ? {
              'profileid': parameter.item1,
              'profilename': parameter.item2,
              'profilephoto': parameter.item3
            }
          : {'profileid': parameter.item1, 'profilename': parameter.item2},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    final updateProfileResponse =
        LogoutResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (updateProfileResponse.type == 'success' &&
          updateProfileResponse.response != null) {
        // print(
        //     'ALL GOOD----->${updateProfileResponse.response?.map((x) => x.toJson()).toList() ?? []}');
        return updateProfileResponse.response;
      } else {
        // print('EROROOOOOOR+++++++++++++$response');
        throw updateProfileResponse.message ?? 'Something went wrong!!!!';
      }
    } else {
      // print('EROROOOOOOR-------------->$response');
      throw updateProfileResponse.message ?? 'Something went wrong!!!!';
    }
  }
}
