import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/presentation/app_texts.dart';
import '../core/presentation/routes/app_router.gr.dart';
import '../core/presentation/themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleTransition;

  @override
  void initState() {
    _setAnimation();
    _navigateToHome();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray3,
      body: ScaleTransition(
        scale: _scaleTransition,
        child: Center(
          child: Text(
            AppTexts.greatens,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }

  void _setAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleTransition = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    );
    _controller.forward();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    context.navigateTo(
      const HomeScreenRoute(),
    );
  }
}
