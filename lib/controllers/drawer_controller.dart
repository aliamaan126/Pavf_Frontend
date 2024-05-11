import 'package:PAVF/screens/app/local_storage.dart';
import 'package:get/get.dart';

class DrawerController extends GetxController {
  final imageExist = ''.obs; // Observable variable for imageExist

  @override
  void onInit() {
    super.onInit();
    // Initialize imageExist with retrieved data
    imageExist.value = retrieveData('image') ?? '';
  }
}
