import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:PAVF/state_management/g_controller.dart';


// const server = "http://localhost:3000/api/v1";
final FlutterSecureStorage _storage = FlutterSecureStorage();
final GController controller = Get.put(GController());
const server = "https://pavf-gelj.onrender.com/api/v1";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
  final TextEditingController confirmPasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(hintText: 'Email', controller: emailController),
        SizedBox(height: 20),
        InputField(hintText: 'Username', controller: usernameController),
        SizedBox(height: 20),
        InputField(
            hintText: 'Password',
            isPassword: true,
            controller: passwordController),
        SizedBox(height: 20),
        InputField(
            hintText: 'Confirm Password',
            isPassword: true,
            controller: confirmPasswordController),
        SizedBox(height: 20),
        SignUpButton(
          emailController: emailController,
          usernameController: usernameController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          context: context,
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
  final BuildContext context;

  SignUpButton({
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final inputFieldWidth = MediaQuery.of(context).size.width - 40;
    final buttonHeight = 50.0;

    return SizedBox(
      width: inputFieldWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          await registerUser(
            usernameController.text,
            emailController.text,
            passwordController.text,
            confirmPasswordController.text,
            context,
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
          primary: Colors.green,
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
      onTap: () {
        
      },
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

Future<void> registerUser(String username, String email, String password,
    String passwordConfirmation, BuildContext context) async {
      // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final apiUrl = '$server/auth/register';
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
      // ignore: use_build_context_synchronously
      showSignUpConfirmationDialog(context, 'Account Created',
      'Your account has been successfully created.');
      
      final json = jsonDecode(response.body);
      var token = json['access_token'];
      storeAuthToken(token);

      var uname = json['user']['username'];
      var uemail = json['user']['email'];
      var uFirstName = json['user']['firstname'];
      var uLastName = json['user']['lastname'];
      var urole = json['user']['role'];

      await storeData('username', uname.toString());
      await storeData('email', uemail.toString());
      await storeData('firstname', uFirstName.toString());
      await storeData('lastname', uLastName.toString());
      await storeData('role', urole.toString());

      // final SharedPreferences? prefs = await _prefs;
      // await prefs?.setString('token', token);

      // await _storage.write(key: 'token', value: token.toString());
      // controller.updateUser(uname.toString(), uemail.toString(), uFirstName.toString(), uLastName.toString(), urole.toString());
      // print(token.toString());
      // print(uname.toString());
      // print(uemail.toString());
      // print(urole.toString());


      Get.offAllNamed('/dashboard');

    } else {
      print('Failed to register user: ${response.body}');
      var responseBody = json.decode(response.body);
      
      if (responseBody['error'] == 'Password too short') {
        
        showSignUpErrorDialog(context, 'Registration Failed',
            'Password is too short. Please use a longer password.');
      } else {
        showSignUpErrorDialog(context, 'Registration Failed',
            'Failed to register user. Please try again.');
      }
      if (response.statusCode == 400) {
        print('Password too short');
        showSignUpConfirmationDialog(context, 'Registration Failed',
            'password length must be between 5 to 128 character.');
      }
    }
  } catch (e) {
    print('Error occurred during registration: $e');
    showSignUpErrorDialog(
        context, 'Error', 'An unexpected error occurred. Please try again.');
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
            onPressed: () {
            },
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
