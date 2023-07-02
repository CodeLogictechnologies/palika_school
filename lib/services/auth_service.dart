import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:palika_school/constants.dart';
import 'package:palika_school/models/profile_model.dart';

import '../models/login_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

  Future<LoginModel> loginUser(String username, String password) async {
    final response = await dio.post('$endpoint/login', data: {
      'mobilenumber': username,
      'password': password,
      'devicetoken': 'XKFGJSAKjt9wq3845kjnfgi'
    });
    LoginResponseModel loginResponse =
        LoginResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (loginResponse.type == 'success') {
        return loginResponse.response!;
      } else {
        throw loginResponse.message;
      }
    } else {
      throw loginResponse.message;
    }
  }

  Future<LogoutResponseModel> logout(LoginModel? state) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;

    final response = await dio.post(
      '$endpoint/logout',
      queryParameters: {'devicetoken': 'XKFGJSAKjt9wq3845kjnfgi'},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    LogoutResponseModel loginResponse =
        LogoutResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (loginResponse.type == 'success') {
        return loginResponse;
      } else {
        throw loginResponse.message;
      }
    } else {
      throw loginResponse.message;
    }
  }

  Future<ProfileModel> fetchProfile(LoginModel? state) async {
    if (state == null) {
      throw 'Not Logged in';
    }
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.get(
      '$endpoint/profile-fetch',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    ProfileResponseModel profileResponse =
        ProfileResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (profileResponse.type == 'success' &&
          profileResponse.response != null) {
        return profileResponse.response as ProfileModel;
      } else {
        throw profileResponse.message;
      }
    } else {
      throw profileResponse.message;
    }
  }

  Future<LogoutResponseModel> updateProfile(
      LoginModel state, String username, String password) async {
    final token = state.token;
    final userid = state.userid;
    final palikaprofileid = state.palikaprofileid;
    final response = await dio.get(
      '$endpoint/profile-update',
      options: Options(
        headers: {
          'Authorization': token,
          'userid': userid,
          'palikaprofileid': palikaprofileid
        },
      ),
    );
    LogoutResponseModel profileResponse =
        LogoutResponseModel.fromJson(jsonDecode(response.data));
    if (response.statusCode == 200) {
      if (profileResponse.type == 'success') {
        return profileResponse;
      } else {
        throw profileResponse.message;
      }
    } else {
      throw profileResponse.message;
    }
  }
}
