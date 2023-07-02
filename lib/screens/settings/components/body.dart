import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/providers/auth_providers.dart';
import 'package:palika_school/screens/academic_year/academic_year_screen.dart';
import 'package:palika_school/screens/change_password/change_password_screen.dart';
import 'package:palika_school/screens/profile/profile_screen.dart';

import '../../../services/auth_service.dart';
import '../../sign_in/sign_in_screen.dart';

class Body extends ConsumerWidget {
  final AuthService authService = AuthService();

  Body({super.key});

  @override
  Widget build(BuildContext context, ref) {
    void handleLogout() async {
      try {
        final state = await ref.watch(getAuthenticatedUserProvider.future);
        await authService.logout(state);
        ref.read(resetStorage);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      } catch (e) {
        final snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: const ListTile(
                title: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    children: [
                      Icon(Icons.supervised_user_circle_outlined),
                      SizedBox(width: 8),
                      Expanded(child: Text('Update Profile')),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AcademicYearScreen.routeName);
              },
              child: const ListTile(
                title: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_outline),
                      SizedBox(width: 8),
                      Expanded(child: Text('Change Academic Year')),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ChangePasswordScreen.routeName);
              },
              child: const ListTile(
                title: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    children: [
                      Icon(Icons.vpn_key_outlined),
                      SizedBox(width: 8),
                      Expanded(child: Text('Change Password')),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: handleLogout,
              child: const ListTile(
                title: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    children: [
                      Icon(Icons.person_off_outlined),
                      SizedBox(width: 8),
                      Expanded(child: Text('Delete Account')),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: handleLogout,
              child: const ListTile(
                title: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 8),
                      Expanded(child: Text('Logout')),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
