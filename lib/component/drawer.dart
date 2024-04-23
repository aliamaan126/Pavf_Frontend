import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:PAVF/screens/app/notification.dart';
import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/screens/user/setting.dart';
import 'package:PAVF/screens/user/profile.dart';
import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:PAVF/screens/app/local_storage.dart';

Widget _buildDrawerItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
  double iconSize = 24.0,
  double textSize = 16.0,
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
      color: Color(0xFFC7F2D8), // Set the background color of the list body
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/5.png', // Provide the correct asset path directly
              ),
            ),
            accountEmail: Text('jane.doe@example.com'),
            accountName: Text(
              'Jane Doe',
              style: TextStyle(fontSize: 24.0),
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Get.to(() => Dashboard()),
          ),
          _buildDrawerItem(
            icon: Icons.notifications,
            text: 'Notifications',
            onTap: () => Get.to(() => NotificationPage()),
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => Get.to(() => Settings()),
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: 'Profile',
            onTap: () => Get.to(() => Profile()),
          ),
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
    ),
  );
}
