import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../services/settings_service.dart';
import './auth_providers.dart';

final checkPasswordProvider =
    FutureProvider.family((ref, String password) async {
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  SettingsService settingsService = SettingsService();
  return settingsService.checkCurrentPassword(state, password);
});

final changePasswordProvider =
    FutureProvider.family((ref, Tuple2<String, String> parameter) async {
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  SettingsService settingsService = SettingsService();
  return settingsService.changePassword(state, parameter);
});

final updateProfileProvider =
    FutureProvider.family((ref, Tuple3<String, String, File?> parameter) async {
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  SettingsService settingsService = SettingsService();
  return settingsService.updateProfile(state, parameter);
});
