import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/screens/home/home_screen.dart';
import 'package:tuple/tuple.dart';

import '../../../constants.dart';
import '../../../providers/auth_providers.dart';
import '../../../providers/settings_providers.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/table/custom_button.dart';
import '../../sign_in/sign_in_screen.dart';

class Body extends ConsumerStatefulWidget {
  const Body({super.key});

  @override
  ConsumerState<Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<Body> {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;
  String state = 'check';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  final AuthService authService = AuthService();

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _handleCheckPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });
      try {
        final response =
            await ref.read(checkPasswordProvider(currentPassword ?? '').future);
        if (response == true) {
          setState(() {
            currentPassword = null;
            state = 'change';
          });
        }
      } catch (err) {
        final snackBar = SnackBar(content: Text(err.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

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

  void _handleChangePassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });
      try {
        final response = await ref.read(changePasswordProvider(
                Tuple2(newPassword ?? '', confirmPassword ?? ''))
            .future);
        if (response == true) {
          handleLogout();
        }
      } catch (err) {
        final snackBar = SnackBar(content: Text(err.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Enter your current password and change your password.',
                ),
                const SizedBox(height: 25),
                ...formState(state)
              ],
            )),
      ),
    ));
  }

  List<Widget> formState(String state) {
    if (state == 'check') {
      return [
        TextFormField(
            decoration: const InputDecoration(
              labelText: "Current Password",
            ),
            onSaved: (newValue) => currentPassword = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 5) {
                removeError(error: kShortPassError);
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 5) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            }),
        const SizedBox(height: 20),
        CustomButtom(text: 'Verify', onPressed: _handleCheckPassword)
      ];
    }
    return [
      TextFormField(
        decoration: const InputDecoration(
          labelText: "New Password",
        ),
        // onSaved: (newValue) {
        //   print(newValue);

        // },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 5) {
            removeError(error: kShortPassError);
          }
          newPassword = value;
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 5) {
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        initialValue: null,
      ),
      const SizedBox(height: 12),
      TextFormField(
        decoration: const InputDecoration(
          labelText: "Confirm Password",
        ),
        onSaved: (newValue) => confirmPassword = newValue,
        onChanged: (value) {
          print('$value, $newPassword');
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 5) {
            removeError(error: kShortPassError);
          } else if (value != newPassword) {
            removeError(error: kMatchPassError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 5) {
            addError(error: kShortPassError);
            return "";
          } else if (value != newPassword) {
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        },
        initialValue: null,
      ),
      const SizedBox(height: 20),
      CustomButtom(text: 'Change Password', onPressed: _handleChangePassword)
    ];
  }
}
