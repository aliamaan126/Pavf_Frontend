import 'package:PAVF/screens/device/add_device.dart';
import 'package:flutter/material.dart';

import 'package:PAVF/screens/device/device_Setup.dart';

void main() {
  runApp(MaterialApp(
    home: shelf(),
  ));
}

class shelf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SubHeader(heading: "Shelfs"),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC9E9C9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: screenWidth * 9, // Adjust width as needed
                  height: screenHeight * 0.9, // Adjust height as needed
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    children: [
                      _buildRow("Add device", "", () {
                        // onTap action for Personal Information
                        // Navigate to AddDevice screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeviceSetup()),
                        );

                        print("Personal Information tapped");
                      }),
                      _buildRow("Add device", "    ", () {
                        // onTap action for Personal Information
                        // Navigate to AddDevice screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeviceSetup()),
                        );

                        print("Personal Information tapped");
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String subtitle, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding
      child: Container(
        height: 120, // Adjust height of ListTile
        decoration: BoxDecoration(
          color: Color(0xFFF9FAF9), // Set background color to F9FAF9
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(10, 10),
              blurRadius: 1,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: ListTile(
          title: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20, // Increased text size
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2c2c2c),
                  ),
                ),
                SizedBox(height: 5), // Added SizedBox for spacing
              ],
            ),
          ),
          onTap: onTap,
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
      title: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 50.0), // Adjust padding as needed
        child: Text(
          heading,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true, // Center aligns the title horizontally
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
