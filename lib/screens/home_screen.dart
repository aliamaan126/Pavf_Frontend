import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobapp/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              TextButton(
                child: const Text("Login"),
                onPressed: () {
                  Get.toNamed('/login',arguments: 'hello');
                  },
              ),
              TextButton(
                child: const Text("Dashboard"),
                onPressed: () {
                  Get.toNamed('/dashboard',arguments: 'hello');
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
