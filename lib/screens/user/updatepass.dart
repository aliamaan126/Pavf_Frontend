// ignore_for_file: body_might_complete_normally_nullable

import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

void main() {
  runApp(MaterialApp(
    home: UpdatePass(),
  ));
}

class UpdatePass extends StatelessWidget {
  final TextEditingController currentPasswordController =TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const SubHeader(heading: "Update Password"),
      drawer: buildDrawer(context),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC9E9C9),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.6,
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          // CircleAvatar(
                          //   radius: 70,
                          //   backgroundImage:
                          //       //AssetImage('assets/avatar_image.png'),
                          // ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: currentPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Current Password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: newPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: confirmNewPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm New Password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Implement password change functionality
                              print("Change Password tapped");

                              updatePass(context, currentPasswordController, newPasswordController, confirmNewPasswordController);
                              // You can use these strings to perform password validation or update logic
                            },
                            child: const Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String heading;

  const SubHeader({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFC9E9C9),
      title: Center(
        child: Text(
          heading,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Future<String?> updatePass(
    BuildContext context,
    TextEditingController currentPasswordController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController) async {
  final currentPassword = currentPasswordController.text;
  final password = passwordController.text;
  final confirmPassword = confirmPasswordController.text;

  // Add your API endpoint URL here
  const apiUrl = '$server/profile/password/update';
  final token = await _secureStorage.read(key: 'auth_token');
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      body: json.encode({
        'currentPassword': currentPassword,
        'newPassword': password,
        'password_confirmation': confirmPassword
      }),
    );

    if (response.statusCode == 202) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password has successfully been updated'),
          backgroundColor: Color.fromARGB(255, 26, 227, 42),
          duration: Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Update failed: $e')),
    );
    return null;
  }
}
