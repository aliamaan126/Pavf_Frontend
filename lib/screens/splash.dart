import 'dart:ffi';
import 'dart:io';
import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/screens/auth/login_screen.dart';
import 'package:PAVF/utils/socket_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

void main() {
  runApp(const Splash());
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAK AGRO',
      home: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('5.png'), // Change to your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Animated splash screen content
          // Animated splash screen content
          AnimatedSplashScreen(
            duration: 3000,
            splash: SizedBox(
              // width: max(200, 200), // Adjust the width as needed
              // height: max(200, 200), // Adjust the height as needed
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Adjust the radius as needed
                child: Image.asset(
                  'profile.png', // Change to your splash image path
                  fit: BoxFit.cover, // Ensure the image fills the SizedBox
                ),
              ),
            ),
            nextScreen: const SplashScreenContent(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor:
                Colors.transparent, // Set background color to transparent
          ),
        ],
      ),
    );
  }
}

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkTokenExists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
             child: CircularProgressIndicator(),
             );
          } else {
            if (snapshot.data == true) {
              return FutureBuilder<void>(
                future: _fetchUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    socketCLient("http://localhost:3000");
                    return const Center(
                    child: CircularProgressIndicator(),
                    );                   
                  } else {
                    return Dashboard();
                  }
                },
              );
            } else {
              return LoginScreen();
            }
          }
        },
      ),
    );
  }

  Future<bool> _checkTokenExists() async {
    String? token = await _secureStorage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }

  Future<void> _fetchUserProfile() async {
    try {
      final apiUrl = '$server/profile';
      final token = await _secureStorage.read(key: 'auth_token');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String? user = data['user']?['username'];
        String? email = data['user']?['email'];
        String? fname = data['user']?['firstname'];
        String? lname = data['user']?['lastname'];
        String? role = data['user']?['role'];
        String? image = data['user']?['image'];
        List<dynamic>? devices = data['user']?['devices'];
        
        print("data obj: $data");
        print("username: $user");
        print(image);
        await storeData('username', user.toString());
        await storeData('email', email.toString());
        await storeData('firstname', fname.toString());
        await storeData('lastname', lname.toString());
        await storeData('role', role.toString());
        await storeData('image', image.toString());
        await storeData('devices', devices.toString());
        print(retrieveData("devices"));
        // Handle user profile data as needed
      } else {
        // Handle HTTP error response
              await deleteData('username');
              await deleteData('email');
              await deleteData('firstname');
              await deleteData('lastname');
              await deleteData('slug');
              await deleteData('image');
              await deleteData('devices');
              await deleteToken("auth_token");
        Get.offAllNamed('/login');
      }
    } catch (e) {
      // Handle exception
      print('Error fetching user profile: $e');
      throw e; // Propagate the error upwards if needed
    }
  }
}

// Existing code from your question
// Place your existing code for Dashboard, LoginScreen, and other widgets here

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
              const SizedBox(height: 50), // Add space at the top
              CircleAvatarWidget(),
              const SizedBox(height: 20),
              SignUpText(),
              const SizedBox(height: 20),
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
    return const Column(
      children: [
        Text(
          'PAK AGRO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'VERTICAL FARMING',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}


void socketCLient(address) {
  IO.Socket socket = IO.io(address);
  socket.onConnect((_) {
    print('connect');
  });
}
