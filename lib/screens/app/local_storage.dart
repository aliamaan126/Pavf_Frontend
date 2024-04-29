import 'dart:io';

import 'package:PAVF/constants/url.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

final localStorage = LocalStorage('app_data.json');
final filestorage = '$userImageDir'+retrieveData("username")+".jpg";

Future<void> storeData(String key, dynamic value) async {
  await localStorage.ready;
  localStorage.setItem(key, value);
}

// Retrieve data
dynamic retrieveData(String key) {
  return localStorage.getItem(key);
}

// Delete data
Future<void> deleteData(String key) async {
  localStorage.deleteItem(key);
}


Future<void> retriveFile(filestorage,String user) async {
    final response = await http.get(Uri.parse(filestorage));
    final bytes = response.bodyBytes;

    // Get the device's external storage directory
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/$user');

    // Write the file
    await file.writeAsBytes(bytes);
    await storeData("file", file.path);
    print('File downloaded to:'+retrieveData('file'));
  }


