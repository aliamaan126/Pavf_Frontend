import 'package:PAVF/controllers/register_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize RegisterController using GetX's dependency injection
    Get.put(RegisterController());

    return Scaffold(
      backgroundColor: myBackground,
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundImage(),
            CenteredContent(),
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              CircleAvatarWidget(),
              SizedBox(height: 20),
              SignUpText(),
              SizedBox(height: 20),
              SignUpForm(),
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

class SignUpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'SIGN UP',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InputField(
          hintText: 'Email',
          controller: emailController,
          inputWidth: screenWidth * 0.8, // Adjusted width based on screen size
        ),
        SizedBox(height: 20),
        InputField(
          hintText: 'Username',
          controller: usernameController,
          inputWidth: screenWidth * 0.8, // Adjusted width based on screen size
        ),
        SizedBox(height: 20),
        InputField(
          hintText: 'Password',
          isPassword: true,
          controller: passwordController,
          inputWidth: screenWidth * 0.8, // Adjusted width based on screen size
        ),
        SizedBox(height: 20),
        InputField(
          hintText: 'Confirm Password',
          isPassword: true,
          controller: confirmPasswordController,
          inputWidth: screenWidth * 0.8, // Adjusted width based on screen size
        ),
        SizedBox(height: 20),
        SignUpButton(
          emailController: emailController,
          usernameController: usernameController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController
        ),
        SizedBox(height: 20),
        LoginLink(),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final double inputWidth; // Added inputWidth parameter

  InputField({
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.inputWidth, // Defined inputWidth parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inputWidth, // Set width based on inputWidth parameter
      height: 60,
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        obscureText: isPassword,
        decoration: InputDecoration(
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

class SignUpButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  SignUpButton({
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final registerController = Get.find<RegisterController>(); // Get the instance of RegisterController

    return SizedBox(
      width: screenWidth * 0.8,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          String user = usernameController.text;
          String email = emailController.text;
          String password = passwordController.text;
          String confirmPassword = confirmPasswordController.text;

          registerController.registerUser( // Call registerUser on the instance
            user,
            email,
            password,
            confirmPassword,
          );
        },
        child: Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xff364732),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class LoginLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: RichText(
        text: TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'Login here.',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/login');
                },
            ),
          ],
        ),
      ),
    );
  }
}

void showSignUpConfirmationDialog(
    BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showSignUpErrorDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

String getImagePath(String imageName) {
  return 'assets/$imageName';
}
