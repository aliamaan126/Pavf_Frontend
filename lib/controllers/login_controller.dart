import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading(true);
    print(username);
    try {
      const apiUrl = '$server/auth/login';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
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
        await storeData('setHumidityValue', 0.0);
        await storeData('setTempValue', 0.0);
        await storeData('setLightValue', 0.0);
        Get.snackbar("Success", "Login Successful",
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3));
        Get.offAllNamed('/dashboard');

        // Get.find().addUser(user,email,fname,lname,'role');
      }
      //user name check
      if (response.statusCode == 201) {
        Get.snackbar('Error', 'Username Field is empty');
      }
      if (response.statusCode == 201) {
        Get.snackbar('Error', 'Incorrect Username');
      }
//PASSWORD HECK
      if (response.statusCode == 201) {
        Get.snackbar('Error', 'Password Field is empty');
      }
      if (response.statusCode == 201) {
        Get.snackbar('Error', 'Incorrect Password');
      } else {
        Get.snackbar(
            "Request Failed", "Login failed: Invalid Username or Password",
            backgroundColor: const Color.fromARGB(255, 221, 92, 82),
            duration: const Duration(seconds: 3));
      }
    } catch (e) {
      // Handle exceptions
    } finally {
      isLoading(false);
    }
  }
}
