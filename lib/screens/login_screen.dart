import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:mobapp/state_management/custom_storage.dart';

final storage = FlutterSecureStorage();
// const server = "http://localhost:3000/api/v1";
final localStorage = LocalStorage('app_data.json');

const server = "https://pavf-gelj.onrender.com/api/v1";

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundImage(),
            CenteredContent(
              usernameController: usernameController,
              passwordController: passwordController,
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
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  CenteredContent({
    required this.usernameController,
    required this.passwordController,
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
              LoginText(),
              SizedBox(height: 20),
              LoginForm(
                usernameController: usernameController,
                passwordController: passwordController,
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

class LoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
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
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  LoginForm({
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(hintText: 'username', controller: usernameController),
        SizedBox(height: 20),
        InputField(
            hintText: 'Password',
            isPassword: true,
            controller: passwordController),
        SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
              activeColor: Colors.white,
              value: true,
              onChanged: (bool? value) {},
            ),
            Text(
              'Remember Me',
              style: TextStyle(
                color: Colors.lightGreen,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/forgotPass');
          },
          child: Text(
            'Forgot Password ?',
            style: TextStyle(
              color: Colors.lightGreen,
            ),
          ),
        ),
        SizedBox(height: 10),
        LoginButton(
          usernameController: usernameController,
          passwordController: passwordController,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
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
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  LoginButton({
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final inputFieldWidth = MediaQuery.of(context).size.width - 40;
    final buttonHeight = 50.0;
    Future<void> _storeToken(String jwtToken) async {
      await storage.write(key: 'jwt_token', value: jwtToken);
    }

    return SizedBox(
      width: inputFieldWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          final jwtToken = await _login(context);
          await _storeToken(jwtToken!);

          // Store the JWT token securely (you can use a secure storage library)

          // Navigate to the dashboard or another screen
        },
        child: Text(
          'Login',
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

  Future<String?> _login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    // Add your API endpoint URL here
    final apiUrl = '$server/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print(response);
        String token = data['access_token'];
        String token_refresh = data['refersh_token'];
        String user = data['user']["username"];
        // print(user);
        String email = data['user']["email"];
        // print(email);
        String fname = data['user']["firstname"];
        // print(fname);
        String lname = data['user']["lastname"];
        String role = data['user']['role']["slug"];

        await storeData('token', token.toString());
        await storeData('refreshToken', token_refresh.toString());
        await storeData('username', user.toString());
        await storeData('email', email.toString());
        await storeData('firstname', fname.toString());
        await storeData('lastname', lname.toString());
        await storeData('slug', role.toString());

        Get.toNamed('/dashboard');
        // print(lname);
        // Corrected property name
        // await _storeToken(jwtToken);

        // Get.find().addUser(user,email,fname,lname,'role');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.body}')),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
      return null;
    }
  }
}

// Store data
Future<void> storeData(String key, dynamic value) async {
  await localStorage.ready;
  localStorage.setItem(key, value);
}

// Retrieve data
dynamic retrieveData(String key) {
  return localStorage.getItem(key);
}

// Delete data
void deleteData(String key) {
  localStorage.deleteItem(key);
}

String getImagePath(String imageName) {
  return 'assets/$imageName';
}
