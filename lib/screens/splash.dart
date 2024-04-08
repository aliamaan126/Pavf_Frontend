import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/screens/auth/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Code',
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: _checkTokenExists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator or splash screen here
              return CircularProgressIndicator();
            } else {
              if (snapshot.data == true) {
                // Token exists, fetch user profile data using the token
                return FutureBuilder<void>(
                  future: _fetchUserProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while fetching profile data
                      return CircularProgressIndicator();
                    } else {
                      // Profile data fetched successfully, navigate to Dashboard
                      return Dashboard();
                    }
                  },
                );
              } else {
                // Token doesn't exist, navigate to login screen
                return LoginScreen();
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> _checkTokenExists() async {
    // Check if token exists in Flutter Secure Storage
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
        print(data);
        
        String? user = data['user']?['username'];
        String? email = data['user']?['email'];
        String? fname = data['user']?['firstname'];
        String? lname = data['user']?['lastname'];
        String? role = data['user']?['role'];


        await storeData('username', user.toString());
        await storeData('email', email.toString());
        await storeData('firstname', fname.toString());
        await storeData('lastname', lname.toString());
        await storeData('role', role.toString());

      
        // Handle user profile data as needed
      } else {
        // Handle HTTP error response
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      // Handle exception
      print('Error fetching user profile: $e');
      throw e; // Propagate the error upwards if needed
    }
  }
}
