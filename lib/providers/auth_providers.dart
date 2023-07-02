import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/models/login_model.dart';
import 'package:palika_school/models/profile_model.dart';
import 'package:palika_school/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

final sharedPrefProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

final setAuthStateProvider = StateProvider<LoginModel?>(
  (ref) => null,
);

final setAuthenticatedUserProvider = StateProvider.family<void, LoginModel>(
  (ref, authData) async {
    // print('TO BE SAVED--->${jsonEncode(authData.toJson())}');
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    prefs.setString(
      AUTHENTICATED_USER,
      jsonEncode(authData.toJson()),
    );
  },
);

final getIsAuthenticatedProvider = FutureProvider<bool>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    return prefs.getString(AUTHENTICATED_USER) != null ? true : false;
  },
);

final getAuthenticatedUserProvider = FutureProvider<LoginModel?>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    final userJson = prefs.getString(AUTHENTICATED_USER) != null
        ? jsonDecode(prefs.getString(AUTHENTICATED_USER) ?? '')
        : null;

    return userJson != null ? LoginModel.fromJson(userJson) : null;
  },
);

// Todo: Handle logout or and reset
final resetStorage = StateProvider<dynamic>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    final isCleared = await prefs.clear();
    return isCleared;
  },
);

final profileProvider = FutureProvider<ProfileModel?>((ref) async {
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  return AuthService().fetchProfile(state);
});
