import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:company_roster/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset('assets/splash_bg.jpg'),
            ),
            const Text(
              'Solve it Together',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void splashTime() {
    var duration = const Duration(seconds: 1);
    Timer(duration, () {
      if (mounted) {
        context.router.replace(const HomeRoute());
      }
    });
  }
}
