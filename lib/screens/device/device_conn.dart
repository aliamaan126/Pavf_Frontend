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
  final ButtonController buttonController = Get.put(ButtonController());


  DeviceConn({super.key});
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: SubHeader(heading: "Device Connection"),
    body: Container(
      decoration: BoxDecoration(
        color: Color(0xFFC9E9C9),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 40.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xFFE4E4E4)),
                            ),
                            hintText: 'Enter your username',
                            filled: true,
                            fillColor: Color(0xFFF9FAF9),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xFFE4E4E4)),
                            ),
                            hintText: 'Enter your password',
                            filled: true,
                            fillColor: Color(0xFFF9FAF9),
                          ),
                        ),
                        SizedBox(height: 100),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: Obx(() => ElevatedButton(
                              onPressed: buttonController.isLoading.value
                                  ? null
                                  : () async {
                                      buttonController.isLoading.value = true;
                                      bool success = await deviceBind(context, usernameController, passwordController);
                                      buttonController.isLoading.value = false;
                                      if (success) {
                                        Get.offNamed("/dashboard");
                                      } else {
                                        // Handle failure (optional)
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF18A818),
                              ),
                              child: buttonController.isLoading.value
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    )
                                  : Text(
                                      'Connect',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
      leading: GestureDetector(
        onTap: () {
          Get.offAndToNamed("/dashboard");
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


Future<bool> deviceBind(
    BuildContext context,
    TextEditingController userNameController,
    TextEditingController passwordController) async {
  final username = userNameController.text;
  final password = passwordController.text;

  if(username == ""&&password=="")
  {
    Get.snackbar("Error", "Both fields must be filled",backgroundColor: const Color.fromARGB(255, 250, 50, 35),
            duration: const Duration(seconds: 3));
    return false;
  }
  if(username == "")
  {
    Get.snackbar("Error", "Username field must be filled",backgroundColor: const Color.fromARGB(255, 250, 50, 35),
            duration: const Duration(seconds: 3));
    return false;
  }
  if(password=="")
  {
    Get.snackbar("Error", "Password field must be filled",backgroundColor: const Color.fromARGB(255, 250, 50, 35),
            duration: const Duration(seconds: 3));
    return false;
  }

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
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.snackbar("Success", 'Device Connected Successfully',backgroundColor: Color.fromARGB(255, 26, 227, 42),
      duration: Duration(seconds: 3));
      return true;
    }

    else if(response.statusCode == 401){

      Get.snackbar("Error", 'Device already Connected to User',backgroundColor: Color.fromARGB(255, 185, 47, 47),
          duration: Duration(seconds: 3));
            return false;
    }
    else if(response.statusCode == 400){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device does not Exist or Invalid Credentials '),
          backgroundColor: Color.fromARGB(255, 185, 47, 47),
          duration: Duration(seconds: 3),
        ),
      );
                  return false;

    }
                return false;

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Update failed: $e')),
    );
    return false;
  }
}

class ButtonController extends GetxController {
  var isLoading = false.obs;
}