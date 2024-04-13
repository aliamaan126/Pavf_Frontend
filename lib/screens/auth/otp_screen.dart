import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Otp extends StatelessWidget {
  Otp({super.key});
  final TextEditingController otpController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      body: SafeArea(
        child: Stack(
        children: [
          BackgroundImage(),
          CenteredContent(
            otpController: otpController,
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
  final TextEditingController otpController;

  CenteredContent({
    required this.otpController,
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
              OtpForm(
                otpController: otpController,
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
      'Verification',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class OtpForm extends StatelessWidget {
  
  final TextEditingController otpController;

  OtpForm({
    required this.otpController,
  });

  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(hintText: 'OTP', controller: otpController),
        SizedBox(height: 20),
        SizedBox(height: 10),
        LoginButton(otpController: otpController,),
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
  
  final TextEditingController otpController;
  LoginButton({
    required this.otpController,
  });

  Widget build(BuildContext context) {
    final inputFieldWidth = MediaQuery.of(context).size.width - 40;
    final buttonHeight = 50.0;

    return SizedBox(
      width: inputFieldWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          await _otpVerification(context,otpController);
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

Future<String?> _otpVerification(BuildContext context, TextEditingController otpController) async {


    final otpCont = otpController.text;
    // Add your API endpoint URL here
    var args = Get.arguments;
    int otp = args['otp'];
    String email = args['email'];
    if (otpCont == otp.toString())
    {  
      final apiUrl = '$server/auth/confirm-otp';

      try {
        final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"otp_success":"success","email": email}),
      );

      // Check the response status code
      if (response.statusCode == 201) {
        // Email sent successfully
        final data = json.decode(response.body);
        String reset_token = data['reset_token'];
        String emailRcv = data['email'];

        // Navigate to resetpass screen
        Get.toNamed('/resetPass',arguments: {'reset_token': reset_token, 'email': emailRcv});
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
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect OTP entered Please try Again'),
            backgroundColor: Color.fromARGB(255, 250, 3, 3),
            duration: Duration(seconds: 4),
          ),
        );
    }
  }


String getImagePath(String imageName) {
  return 'assets/$imageName';
}
