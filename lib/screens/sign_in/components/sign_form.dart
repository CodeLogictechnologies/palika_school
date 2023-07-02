import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/providers/auth_providers.dart';
import 'package:palika_school/screens/home/home_screen.dart';
// import 'package:shop_app/components/custom_surfix_icon.dart';
// import 'package:shop_app/components/form_error.dart';
import '../../../helper/keyboard.dart';
// import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';

// import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../services/auth_service.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;
  bool loading = false;
  final List<String?> errors = [];

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

  void _handleSignIn(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });
      try {
        final response =
            await authService.loginUser(username as String, password as String);
        ref.read(setAuthStateProvider.notifier).state = response;
        ref.read(setAuthenticatedUserProvider(response));
        KeyboardUtil.hideKeyboard(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        setState(() {
          loading = false;
        });
      } catch (e) {
        final snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              // GestureDetector(
              //   // onTap: () => Navigator.pushNamed(
              //   //     context, ForgotPasswordScreen.routeName),
              //   child: Text(
              //     "Forgot Password",
              //     style: TextStyle(decoration: TextDecoration.underline),
              //   ),
              // )
            ],
          ),
          // FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              height: 44.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF1873DC), Color(0xFF185CAB)]),
                  borderRadius: BorderRadius.circular(4)),
              child: Consumer(
                  builder: (context, watch, child) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(loading ? 'Loading...' : 'Login'),
                        onPressed: () => _handleSignIn(watch),
                      )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              'Please contact to the education department authority of your muncipality')
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      style: TextStyle(color: Color(0xFF78797C)),
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: new InputDecoration(
        prefixIcon: Icon(Icons.key),
        labelText: "Password",
        filled: true,
        fillColor: Color(0xFFF3F4F6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFFE1E0E0)),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFF0F80C4)),
            borderRadius: BorderRadius.circular(20)),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      style: TextStyle(color: Color(0xFF78797C)),
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUserNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kUserNameNullError);
          return "";
        }
        return null;
      },
      decoration: new InputDecoration(
        prefixIcon: Icon(Icons.verified_user),
        labelText: "Username",
        filled: true,
        fillColor: Color(0xFFF3F4F6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFFE1E0E0)),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFF0F80C4)),
            borderRadius: BorderRadius.circular(20)),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
      ),
    );
  }
}
