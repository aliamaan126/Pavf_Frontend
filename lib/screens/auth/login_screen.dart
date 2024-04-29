// ignore_for_file: body_might_complete_normally_nullable

import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

final storage = FlutterSecureStorage();
final localStorage = LocalStorage('app_data.json');


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
            // Checkbox(
            //   activeColor: Colors.white,
            //   value: true,
            //   onChanged: (bool? value) {},
            // ),
            // Text(
            //   'Remember Me',
            //   style: TextStyle(
            //     color: Colors.lightGreen,
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            Get.toNamed('/forgotPass');
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

    return SizedBox(
      width: inputFieldWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          await _login(context,usernameController,passwordController);
          
          // await fetchData();
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

  Future<String?> _login(BuildContext context,TextEditingController usernameController,
    TextEditingController passwordController,) async {
    final username = usernameController.text;
    final password = passwordController.text;

    // Add your API endpoint URL here
    final apiUrl = '$server/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      print(json.decode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print(data);
        String token = data['access_token'];
        // print (token);
        storeAuthToken(token);

        String? user = data['user']?['username'];
        String? email = data['user']?['email'];
        String? fname = data['user']?['firstname'];
        String? lname = data['user']?['lastname'];
        String? role = data['user']?['role'];
        String? image = data['user']?['image'];
        List<dynamic>? devices = data['user']?['devices'];

        await storeData('username', user.toString());
        await storeData('email', email.toString());
        await storeData('firstname', fname.toString());
        await storeData('lastname', lname.toString());
        await storeData('role', role.toString());
        await storeData('image', image.toString());
        await storeData('devices', devices.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful'),
          backgroundColor: Colors.green, 
          duration: Duration(seconds: 4),),
        );
        
        Get.offAllNamed('/dashboard');
        // print(lname);
        // Corrected property name
        // await _storeToken(jwtToken);

        // Get.find().addUser(user,email,fname,lname,'role');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed: Invalid Username or Password'),
          backgroundColor: Colors.red, 
          duration: Duration(seconds: 3),
          ),
          
          
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

Future<void> fetchData() async {
  try {
    // Make the HTTP GET request
    final response = await http.get(Uri.parse('$server/device/data/01/fetch'));

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = json.decode(response.body);

      // print('data:');
      // print(data);

      // print('response:');
      // print(response.body);

      int humidity = int.parse(data['soildata']["moisture"]);
      int temp = int.parse(data['soildata']["Temperature"]);
      int light = int.parse(data['soildata']["Conductivity"]);

      print(humidity);
      print(temp);
      print(light);

      await storeData('humid', humidity.toString());
      await storeData('temp', temp.toString());
      await storeData('light', light.toString());
    } else {
      print('Failed to fetch data1: ${response.statusCode}');
      print(response.body);
    }
  } catch (error) {
    // Handle any exceptions that occur during the request
    print('Error fetching data: $error');
  }
}

// Store data


String getImagePath(String imageName) {
  return 'assets/$imageName';
}
