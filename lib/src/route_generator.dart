import "package:flutter/material.dart";
import "package:mobapp/screens/app/dashboard.dart";
import "package:mobapp/screens/auth/forgotPass_screen.dart";
import "package:mobapp/screens/home_screen.dart";
import "package:mobapp/screens/auth/login_screen.dart";
import "package:mobapp/screens/auth/otp_screen.dart";
import "package:mobapp/screens/auth/register_screen.dart";
import "package:mobapp/screens/auth/resetPass_screen.dart";
import 'package:get/get.dart';
import "package:mobapp/screens/splash.dart";


class RouteGenerator {
  static List<GetPage> routes = [
    GetPage(
      name: '/',
      page: () => const Splash(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: '/forgotPass',
      page: () => ForgotPassScreen(),
    ),
    GetPage(
      name: '/otp',
      page: () => Otp(),
    ),
    GetPage(
      name: '/resetPass',
      page: () => ResetPass(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => Dashboard(),
    ),
  ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) =>  const RegisterScreen());
      case '/forgotPass':
        return MaterialPageRoute(builder: (_) =>  const ForgotPassScreen());
      case '/otp':
        return MaterialPageRoute(builder: (_) =>  const Otp());
      case '/resetPass':
        return MaterialPageRoute(builder: (_) =>  const ResetPass());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) =>  Dashboard());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("No Route"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Sorry No Route"),
        ),
      );
    });
  }
}
