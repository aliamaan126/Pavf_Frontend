// ignore_for_file: body_might_complete_normally_nullable

import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPass extends StatelessWidget {
  ResetPass({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      body: SafeArea(
        child: Stack(
        children: [
          BackgroundImage(),
          CenteredContent(
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),
        ],
      ),
      ),
    );
  }
}


class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getImagePath('5.png')),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
      ),
    );
  }
}

class CenteredContent extends StatelessWidget {
  
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  CenteredContent({
    required this.passwordController,
    required this.confirmPasswordController,
  });

  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50), // Add space at the top
              CircleAvatarWidget(),
              SizedBox(height: 20),
              NPText(),
              SizedBox(height: 20),
              LoginForm(
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage(getImagePath('profile.png')),
    );
  }
}

class NPText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Set New Password',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  LoginForm({
    required this.passwordController,
    required this.confirmPasswordController,
  });

  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(hintText: 'Password', isPassword: true,controller: passwordController),
        SizedBox(height: 20),
        InputField(hintText: 'Confirm Password', isPassword: true,controller: confirmPasswordController),
        SizedBox(height: 10),
        LoginButton(
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  InputField({
    required this.hintText,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        obscureText: isPassword,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.star,
            size: 14,
          ),
          suffixIconColor: Colors.white,
          suffixStyle: TextStyle(color: Colors.white),
          fillColor: Color(0xff9CF2Bd).withOpacity(0.5),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {


  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  LoginButton({
    required this.passwordController,
    required this.confirmPasswordController,
  });


  Widget build(BuildContext context) {
    final inputFieldWidth = MediaQuery.of(context).size.width - 40;
    final buttonHeight = 50.0;

    return SizedBox(
      width: inputFieldWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          await _resetPass(context, passwordController,confirmPasswordController);
        },
        child: Text(
          'Confirm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xff364732),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  
}

Future<String?> _resetPass (BuildContext context, TextEditingController passwordController, TextEditingController confirmPasswordController) async {
    
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    var args = Get.arguments;
    String resetToken = args['reset_token'];
    String email = args['email'];

    // Add your API endpoint URL here
    final apiUrl = '$server/auth/reset-password';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'reset_token': resetToken,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paswword has successfully been changed'),
          backgroundColor: Color.fromARGB(255, 26, 227, 42), 
          duration: Duration(seconds: 3),
          ),         
        );
        Get.offAllNamed('/login');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
      return null;
    }
  }

String getImagePath(String imageName) {
  return 'assets/$imageName';
}
