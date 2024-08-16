// ignore_for_file: body_might_complete_normally_nullable
import 'package:PAVF/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
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
  final LoginController loginController = Get.find();

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
              const SizedBox(height: 50),
              CircleAvatarWidget(),
              const SizedBox(height: 20),
              LoginText(),
              const SizedBox(height: 20),
              LoginForm(),
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

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'LOG IN',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InputField(
          hintText: 'username',
          inputWidth: screenWidth * 0.8,
          controller: usernameController,
        ),
        const SizedBox(height: 20),
        InputField(
          hintText: 'Password',
          isPassword: true,
          inputWidth: screenWidth * 0.8,
          controller: passwordController,
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            Get.toNamed('/forgotPass');
          },
          child: const Text(
            'Forgot Password ?',
            style: TextStyle(
              color: Colors.lightGreen,
            ),
          ),
        ),
        const SizedBox(height: 10),
        LoginButton(
          usernameController: usernameController,
          passwordController: passwordController,
          buttonWidth: screenWidth * 0.8,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/register');
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final double inputWidth;

  const InputField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.inputWidth, // Added
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inputWidth, // Added
      height: 60,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        obscureText: isPassword,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.star,
            size: 14,
          ),
          suffixIconColor: Colors.white,
          suffixStyle: const TextStyle(color: Colors.white),
          fillColor: const Color(0xff9CF2Bd).withOpacity(0.5),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
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
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final double buttonWidth; // Added
  const LoginButton({super.key, 
    required this.usernameController,
    required this.passwordController,
    required this.buttonWidth, // Added
  });
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Obx(() => SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              loginController.login(
                usernameController.text,
                passwordController.text,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: loginController.isLoading.value
                ? const CircularProgressIndicator()
                : const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xff364732),
                    ),
                  ),
          ),
        ));
  }
}



String getImagePath(String imageName) {
  return 'assets/$imageName';
}
