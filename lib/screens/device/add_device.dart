import 'package:flutter/material.dart';
import 'package:mobapp/screens/dashboard.dart';
import 'package:mobapp/screens/device/device_Setup.dart';
import 'package:mobapp/screens/user/profile.dart';
import 'package:mobapp/screens/user/setting.dart';

void main() {
  runApp(MaterialApp(
    home: Adddevice(),
  ));
}

class Adddevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SubHeader(heading: "Device"),
      drawer: _buildDrawer(context),
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
                  width: screenWidth * 2, // Adjust width as needed
                  height: screenHeight * 0.9, // Adjust height as needed
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    children: [
                      _buildRow("Add device", "Multiple device can be added",
                          () {
                        // onTap action for Personal Information
                        // Navigate to AddDevice screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeviceSetup()),
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
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15, // Increased text size
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC9E9C9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _buildDrawerItem(
                    icon: Icons.home,
                    text: 'Home',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.notifications,
                    text: 'Notifications',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.person,
                    text: 'Personal',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.security,
                    text: 'Security',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      // Handle logout
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    double iconSize = 24.0, // default icon size
    double textSize = 16.0, // default text size
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: iconSize,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
        ),
      ),
      onTap: onTap,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                heading,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add device action
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
