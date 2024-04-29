import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      body: SafeArea(
        child: Stack(
        children: [
          BackgroundImage(),
          CenteredContent(
            emailController: emailController,
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

  final TextEditingController emailController;

  CenteredContent({
    required this.emailController,
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
              fpText(),
              SizedBox(height: 20),
              Form(
                emailController: emailController,
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

class fpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Forgotten Password',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Form extends StatelessWidget {
  final TextEditingController emailController;

  Form({
    required this.emailController,
  });

  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(hintText: 'Email', controller: emailController),
        SizedBox(height: 20),
        SizedBox(height: 10),
        SubmitButton(emailController: emailController,),
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

class SubmitButton extends StatelessWidget {
  final TextEditingController emailController;
  SubmitButton({
    required this.emailController,
  });
  Widget build(BuildContext context) {
    final inputFieldWidth = MediaQuery.of(context).size.width - 40;
    final buttonHeight = 50.0;

    return SizedBox(
      width: inputFieldWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          await _sendEmail(context,emailController);
        },
        child: Text(
          'Send Otp',
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

 // ignore: body_might_complete_normally_nullable
 Future<String?> _sendEmail(BuildContext context, TextEditingController emailController) async {
    final email = emailController.text;
    final apiUrl = '$server/auth/forgot-password';

    try {
       final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Email sent successfully
      final data = json.decode(response.body);

      int otp = data['otp'];
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email containing OTP sent'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 4),
        ),
      );
      // Navigate to OTP screen
      Get.toNamed('/otp',arguments: {'otp': otp, 'email': email});
    } else {
      // Email sending failed (handle error)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email does not exist. Please try again!'),
          backgroundColor: Color.fromARGB(255, 232, 6, 6),
          duration: Duration(seconds: 4),
        ),
      );
    }
      
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to send email: $e'),
        backgroundColor: Color.fromARGB(255, 232, 6, 6),
        duration: Duration(seconds: 4),
      ),
    );
      return null;
    }
  }

String getImagePath(String imageName) {
  return 'assets/$imageName';
}
