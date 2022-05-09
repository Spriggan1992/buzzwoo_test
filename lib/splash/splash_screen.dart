import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/presentation/routes/app_router.gr.dart';
import '../home/core/presentation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello Bazzwoo! :)'),
      ),
    );
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    context.navigateTo(const HomeScreenRoute());
  }
}
