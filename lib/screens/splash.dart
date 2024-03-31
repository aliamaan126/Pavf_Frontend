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
        body: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset('../../assets/profile.png'),
            nextScreen: LoginScreen(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.black,
            splashIconSize: 400,           
          ),]
        ),
      ),
    );
  }
}
