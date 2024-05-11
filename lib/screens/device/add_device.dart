import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:PAVF/screens/device/device_Setup.dart';
import 'package:PAVF/screens/device/shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Example JSON response containing an array of items
final jsonResponse = {
  "items": [
  ]
};

String deviceIds = retrieveData('devices').replaceAll('[', '').replaceAll(']', '') ?? '';

void main() {
  runApp(MaterialApp(
    home: AddDevice(),
  ));
}

class AddDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    List<String> deviceIdList = deviceIds.split(',').map((id) => id.trim()).toList();
    
    List<String> items = List<String>.from(jsonResponse['items'] ?? []);

    // Update items list with device IDs
    deviceIdList.forEach((deviceId) {
      items.add("Device $deviceId");
    });

    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key to the key property
      drawer: buildDrawer(),
      appBar: const SubHeader(heading: "Device"),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC9E9C9),
        ),
        child: ListView.builder(
          itemCount: items.length +1, 
          itemBuilder: (context, index) {
            if (index < items.length) {
              final itemName = items[index];
              final item = items[index];
              return CardItem(
                itemId: index + 1,
                itemName: itemName,
                onTap: () {
                  // Handle card tap (e.g., navigate to detail page)
                  // print('Card tapped: ${item['name']}');
                  Navigator.of(context).pop(); // Close the drawer
                  Get.to(() => Shelf());
                  // Implement your navigation logic here
                },
              );
            } else {
              // Render the "Add Device" button
              return GestureDetector(
                onTap: () {
                  Get.to(() => DeviceSetup());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Add Device',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final int itemId;
  final String itemName;
  final VoidCallback onTap;

  CardItem({
    required this.itemId,
    required this.itemName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth, // Set maximum width to screen width
          maxHeight: screenHeight,
        ),
        child: Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20, left: 20),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

      leading: IconButton(
        icon: Icon(
            Icons.menu), // Specify the icon for the left button (e.g., menu)
        onPressed: () {
          // Handle onPressed event for the left button
          // Implement your logic here
          _scaffoldKey.currentState?.openDrawer(); // Open the drawer
        },
      ),
      title: Text(
        heading,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center, // Align the text to center
      ),
      centerTitle: true, // Center the title within the AppBar
      actions: [
        IconButton(
          icon: Icon(
              Icons.add), // Specify the icon for the right button (e.g., add)
          onPressed: () {
            Get.to(() => DeviceSetup());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
