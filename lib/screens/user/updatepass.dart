import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SubHeader(heading: "Update Password"),
      drawer: buildDrawer(
          context), // Call the buildDrawer function from drawer.dart
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC9E9C9),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.9,
                  height: screenWidth * 1.5, // Adjust width as needed
                  constraints:
                      BoxConstraints(maxWidth: 500), // Max width of the card
                  child: Card(
                    elevation: 5, // Add elevation for a shadow effect
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage('assets/profile.png'), // Change the image path accordingly
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Current Password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirm New Password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {

                              // await updatePass(context, currentPasswordController, passwordController, confirmPasswordController)
                            },
                            child: Text(
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
      backgroundColor: Color(0xFFC9E9C9),
      title: Center(
        child: Text(
          heading,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}





Future<String?> updatePass (BuildContext context, TextEditingController currentPasswordController,TextEditingController passwordController, TextEditingController confirmPasswordController) async {
    
    final currentPassword = currentPasswordController;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

  

    // Add your API endpoint URL here
    const apiUrl = '$server/profile/password/update';
    final token = await _secureStorage.read(key: 'auth_token');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'bearer $token'},
        body: json.encode({
          'currentPassword': currentPassword,
          'newPassword': password,
          'password_confirmation': confirmPassword,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password has successfully been updated'),
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