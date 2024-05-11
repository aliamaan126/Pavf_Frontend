import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController extends GetxController {

  Future<void> registerUser(
    String username,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    const apiUrl = '$server/auth/register';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );
      print(response.body);
      if (response.statusCode == 201) {

      final json = jsonDecode(response.body);
      var token = json['access_token'];
      storeAuthToken(token);

      var uname = json['user']['username'];
      var uemail = json['user']['email'];
      var uFirstName = json['user']['firstname'];
      var uLastName = json['user']['lastname'];
      var urole = json['user']['role'];

      await storeData('username', uname.toString());
      await storeData('email', uemail.toString());
      await storeData('firstname', uFirstName.toString());
      await storeData('lastname', uLastName.toString());
      await storeData('role', urole.toString());

      Get.offAllNamed('/');
    } else {
        var responseBody = json.decode(response.body);
        String errorMessage = responseBody['error']?? 'Registration failed';

        // Show error messager
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      // Show error message
      Get.snackbar('Error', 'Registration failed: $e');
    }
  }
}
