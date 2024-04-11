import 'package:PAVF/screens/app/notification.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/screens/user/setting.dart';
import 'package:PAVF/screens/user/profile.dart';
import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:get/get.dart';

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

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFC7F2D8), // Set drawer color to C7F2D8
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 20, horizontal: 20), // Added horizontal padding
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black, // Set text color to black
                fontSize: 24, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                ),
              ),
              _buildDrawerItem(
                icon: Icons.settings,
                text: 'Setting',
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
                  MaterialPageRoute(builder: (context) => const Profile()),
                ),
              ),
              // _buildDrawerItem(
              //   icon: Icons.security,
              //   text: 'Security',
              //   onTap: () {},
              // ),
              _buildDrawerItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  deleteData('username');
                  deleteData('email');
                  deleteData('firstname');
                  deleteData('lastname');
                  deleteData('slug');
                  deleteToken("auth_token");
                  Get.offAllNamed('/login');
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
