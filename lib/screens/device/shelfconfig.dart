import 'package:PAVF/constants/plants.dart';
import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();


void main() {
  runApp(MaterialApp(
    home: Shelfconfig(),
  ));
}

class Shelfconfig extends StatelessWidget {
  // Declare text controllers
  final TextEditingController _plantController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final String shelfId = Get.arguments['shelfId'];
  final String deviceId = Get.arguments['deviceID'];
  final String deviceName = Get.arguments['deviceName'];
  List<dynamic> shelfs = Get.arguments['shelfs'];


  Map<String, dynamic>? plantData;
  @override
  Widget build(BuildContext context) {
    List<String> plantNames = plantsDatabase.map((plant) => plant['name'] as String).toList();
    
    String? selectedPlant;

    return Scaffold(
      appBar: SubHeader(heading: "Shelf01"),
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
                'Select Plant', // Username text
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ), // Add some space between the text and the text field
              DropdownButtonFormField<String>(
                value: selectedPlant,
                onChanged: (dynamic? newValue) {
                  // When a new plant is selected, update the selectedPlant variable
                  selectedPlant = newValue;
                  plantData = plantsDatabase.firstWhere((plant) => plant['name'] == selectedPlant );

                  print("plant selected: $plantData");

                },
                items: plantNames.map<DropdownMenuItem<String>>((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make border round
                    borderSide: BorderSide(
                      color: Color(0xFFE4E4E4),
                    ), // Change border color
                  ), // Add border to the dropdown field
                  hintText: 'Select Plant', // Placeholder text
                  filled: true,
                  fillColor: Color(0xFFF9FAF9),
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
                    onPressed: () {
                      // Access entered text using text controllers
                      String selectedPlant = _plantController.text;
                      // String enteredDate = _dateController.text;
                      plantConfig(context,deviceId,shelfId,plantData!);
                      Get.offAndToNamed("/shelves",arguments: {"deviceName":deviceName,"deviceId":deviceId,"shelfs":shelfs});
                      // Add your connection logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF18A818), // Background color
                    ),
                    child: Text(
                      'confirm',
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
          Get.offAndToNamed("/shelves");
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



Future<String?> plantConfig(
    BuildContext context,
    String deviceId,
    String shelfId,
    Map<String, dynamic> plantContent) async {

  // Add your API endpoint URL here
  print("device ID: "+deviceId);
    print("shelf ID: "+shelfId);
      print(plantContent);


  const apiUrl = '$server/profile/add-plant';
  final token = await _secureStorage.read(key: 'auth_token');
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $token'
      },  
      body: json.encode({
        "deviceId":deviceId,
        "shelfId":shelfId,
        "plant_data":plantContent
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Shelf connfigured successfully");
      // Get.offNamed("/shelves",arguments: {"deviceID":deviceId});
    }

    if (response.statusCode == 400) {

    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Update failed: $e')),
    );
    return null;
  }
}