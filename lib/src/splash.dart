import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:PAVF/screens/auth/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

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
                image: AssetImage('assets/5.png'), // Corrected path to background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Animated splash screen content
          AnimatedSplashScreen(
            duration: 3000,
            splash: SizedBox(
              width: 100,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/profile.png', // Corrected path to splash image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            nextScreen: const SplashScreenContent(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.transparent,
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
      body: FutureBuilder<void>(
        future: _initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Container(); // This will be replaced by navigation to Dashboard or LoginScreen
          }
        },
      ),
    );
  }

  Future<void> _initializeApp() async {
    bool tokenExists = await _checkTokenExists();
    if (tokenExists) {
      int stCode = await _fetchUserProfile();

      if(stCode == 401 || stCode == 404){
        deleteData("key");
        WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offNamed('/login');
      });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offNamed('/dashboard');
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offNamed('/login');
      });
    }
  }

  Future<bool> _checkTokenExists() async {
    String? token = await _secureStorage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }

  Future<int> _fetchUserProfile() async {
    try {
      const apiUrl = '$server/profile';
      final token = await _secureStorage.read(key: 'auth_token');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'bearer $token'},
      );
      print(response.statusCode);
      print("token:$token");

      if (response.statusCode == 200) {
        print("200 obtained");
        final data = json.decode(response.body);
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
        await storeData('devices', devices);

        


        await storeData('setHumidityValue', 0.0);
        await storeData('setTempValue', 0.0);
        await storeData('setLightValue', 0.0);
        return 200;
      } 
      else if(response.statusCode==401){
        return 401;
        // Get.offAllNamed("/login");
      }
      return response.statusCode;
    } catch (e) {
      // Handle exception
      print('Error fetching user profile: $e');
      throw e; // Propagate the error upwards if needed
    }
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

Future<void> fetchLatestSoilData(String deviceID) async {
  try {
    final url = '$server/arduino/fetch-Data';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(<String, String>{
        'deviceID': deviceID,
      }),
    );
    print(response.statusCode);
  } catch (error) {
    print('Error fetching soil data: $error');
    // Handle the error gracefully, e.g., display a message to the user
  }
}
