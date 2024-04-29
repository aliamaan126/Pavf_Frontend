// ignore_for_file: body_might_complete_normally_nullable

import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Otp extends StatelessWidget {
  Otp({Key? key});
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundImage(),
            CenteredContent(
              otpControllers: otpControllers,
              focusNodes: focusNodes,
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
  final List<TextEditingController> otpControllers;
  final List<FocusNode> focusNodes;

  CenteredContent({
    required this.otpControllers,
    required this.focusNodes,
  });

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
              fpText(),
              SizedBox(height: 20),
              OtpForm(
                otpControllers: otpControllers,
                focusNodes: focusNodes,
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
  final List<TextEditingController> otpControllers;
  final List<FocusNode> focusNodes;

  OtpForm({
    required this.otpControllers,
    required this.focusNodes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 4; i++)
              InputField(
                hintText: '',
                controller: otpControllers[i],
                focusNode: focusNodes[i],
                nextFocusNode: i < 3 ? focusNodes[i + 1] : null,
                prevFocusNode: i > 0 ? focusNodes[i - 1] : null,
              ),
          ],
        ),
        SizedBox(height: 20),
        LoginButton(
          otpControllers: otpControllers,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? prevFocusNode;

  InputField({
    required this.controller,
    required this.hintText,
    required this.focusNode,
    this.nextFocusNode,
    this.prevFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (nextFocusNode != null && value.length == 1) {
                nextFocusNode!.requestFocus();
              }
            } else {
              if (prevFocusNode != null) {
                prevFocusNode!.requestFocus();
              }
            }
          },
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final List<TextEditingController> otpControllers;

  LoginButton({
    required this.otpControllers,
  });

  @override
  Widget build(BuildContext context) {
    final inputFieldWidth = MediaQuery.of(context).size.width - 40;
    final buttonHeight = 50.0;

    // Function to concatenate OTP digits and return as a string
    String getOtp() {
      String otp = '';
      for (TextEditingController controller in otpControllers) {
        otp += controller.text;
      }
      return otp;
    }

    // Storing the OTP in a variable
    

    return SizedBox(
      width: inputFieldWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          String enteredOtp = getOtp();
          await _otpVerification(context,enteredOtp);
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

Future<String?> _otpVerification(BuildContext context, String otpVal) async {

    var args = Get.arguments;
    int otp = args['otp'];
    String email = args['email'];
    if (otpVal == otp.toString())
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