
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();


Future<void> storeAuthToken(String authToken) async {
  await storage.write(key: 'auth_token', value: authToken);
}

Future<String?> getToken() async {
  return await storage.read(key: 'jwt_token');
}

Future<void> deleteToken(String data) async {
  await storage.delete(key: data);
}