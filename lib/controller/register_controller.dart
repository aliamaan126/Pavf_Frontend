import 'dart:convert';
import 'package:mobapp/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.register);
      Map body = {
        'username': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'password_confirmation':confirmPasswordController.text.trim(),
      };
      print(nameController);
      print(emailController);
      print(passwordController);
      print(confirmPasswordController);
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        // if (json['code'] == 0) {
        //   var token = json['data']['Token'];
        //   print(token);
        //   final SharedPreferences? prefs = await _prefs;
        //   await prefs?.setString('token', token);
        //   nameController.clear();
        //   emailController.clear();
        //   passwordController.clear();
        //   Get.offAllNamed('/');
        // } else {
        //   throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
        // }
      } else {
        print(jsonDecode(response.body));
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (e) {
      
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}