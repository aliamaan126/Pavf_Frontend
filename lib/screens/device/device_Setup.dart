import 'package:flutter/material.dart';
import 'package:mobapp/screens/device/add_device.dart';
import 'package:mobapp/screens/device/device_conn.dart'; // Import the AddDevice screen
import 'package:mobapp/screens/device/wifi_conect.dart';

void main() {
  runApp(MaterialApp(
    home: DeviceSetup(),
  ));
}

class DeviceSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SubHeader(heading: "Device Setup"),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC9E9C9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: screenWidth * 2, // Adjust width as needed
                  height: screenHeight * 0.9, // Adjust height as needed
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    children: [
                      _buildRow("Connect and Configure Device", "", () {
                        // onTap action for Connect and Configure Device
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DeviceConn()), // Navigate to AddDevice screen
                        );
                      }),
                      SizedBox(height: 40),
                      _buildRow("onnect Device only", "", () {
                        // onTap action for Connect and Configure Device
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WifiConn()), // Navigate to AddDevice screen
                        );
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
                    fontSize: 15, // Increased text size
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2c2c2c),
                  ),
                ),
                SizedBox(height: 10), // Added SizedBox for spacing
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 20, // Increased text size
                    color: Color(0xFF2c2c2c),
                  ),
                ),
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
      leading: GestureDetector(
        onTap: () {
          // Navigate to the AddDevice screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Adddevice()),
          );
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
