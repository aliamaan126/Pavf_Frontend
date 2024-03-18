import 'package:localstorage/localstorage.dart';

class CustomStorage {
  final localStorage = LocalStorage('app_data.json');
  // Store data
  Future<void> storeData(String key, dynamic value) async {
  await localStorage.ready;
  localStorage.setItem(key, value);
}

// Retrieve data
dynamic retrieveData(String key) {
  return localStorage.getItem(key);
}

// Delete data
void deleteData(String key) {
  localStorage.deleteItem(key);
}

}