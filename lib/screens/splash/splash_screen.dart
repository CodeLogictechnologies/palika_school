import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_providers.dart';
import './components/body.dart';
import '../../size_config.dart';

class SplashScreen extends ConsumerWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    SizeConfig().init(context);
    return Scaffold(
      body: ref.watch(getIsAuthenticatedProvider).when(
          data: (bool data) => Body(isAuthenticated: data),
          error: (data, err) => const Body(isAuthenticated: false),
          loading: () => Container()),
    );
  }
}
