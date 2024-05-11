import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/screens/device/device_Setup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

void main() {
  runApp(MaterialApp(
    home: DeviceConn(),
  ));
}

class DeviceConn extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController =TextEditingController();

  DeviceConn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubHeader(heading: "Device Connection"),
      body: Center(
        // Wrap with Center widget
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFC9E9C9),
          ),
          padding: EdgeInsets.all(40.0), // Add padding for better spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Username', // Username text
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ), // Add some space between the text and the text field
              TextField(
                // Text field for entering the username
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make border round
                    borderSide: BorderSide(
                        color: Color(0xFFE4E4E4)), // Change border color
                  ), // Add border to the text field
                  hintText: 'Enter your username', // Placeholder text
                  filled: true,
                  fillColor: Color(0xFFF9FAF9), // Change box color
                ),
              ),
              SizedBox(
                height: 30,
              ), // Add some space between the username and password fields
              Text(
                'Password', // Password text
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ), // Add some space between the text and the text field
              TextField(
                // Text field for entering the password
                controller: passwordController,
                obscureText: true, // Hide the entered text
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make border round
                    borderSide: BorderSide(
                        color: Color(0xFFE4E4E4)), // Change border color
                  ), // Add border to the text field
                  hintText: 'Enter your password', // Placeholder text
                  filled: true,
                  fillColor: Color(0xFFF9FAF9), // Change box color
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                     await  deviceBind(context, usernameController, passwordController);
                     Get.offNamed("/addDevice");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF18A818), // Background color
                    ),
                    child: Text(
                      'Connect',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 20, // Adjust text size
                        color: Colors.white, // Change text color to white
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
      leading: GestureDetector(
        onTap: () {
          // Navigate to the AddDevice screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeviceSetup()),
          );
        },
        child: Icon(Icons.chevron_left), // Changed icon to "<"
      ),
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


Future<String?> deviceBind(
    BuildContext context,
    TextEditingController userNameController,
    TextEditingController passwordController) async {
  final username = userNameController.text;
  final password = passwordController.text;

  // Add your API endpoint URL here
  const apiUrl = '$server/profile/deviceBind';
  final token = await _secureStorage.read(key: 'auth_token');
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        'username': username,
        'password': password
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device Connected Successfully'),
          backgroundColor: Color.fromARGB(255, 26, 227, 42),
          duration: Duration(seconds: 3),
        ),
      );
    }

    else if(response.statusCode == 403){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device already Connected to User'),
          backgroundColor: Color.fromARGB(255, 185, 47, 47),
          duration: Duration(seconds: 3),
        ),
      );
    }
    else if(response.statusCode == 400){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device does not Exist or Invalid Credentials '),
          backgroundColor: Color.fromARGB(255, 185, 47, 47),
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
