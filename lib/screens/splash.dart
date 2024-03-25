import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mobapp/screens/auth/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Code',
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: AnimatedSplashScreen(
            duration: 3000,
            splash: Icons.home,
            nextScreen: LoginScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
