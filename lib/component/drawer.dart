import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/device/add_device.dart';
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
  double iconSize = 28.0,
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
  final imageUrl = retrieveData('image') ?? '';

  return Drawer(
    child: Container(
      color: const Color(0xFFC7F2D8), // Set the background color of the list body
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 220, // Specify the desired height of the UserAccountsDrawerHeader
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              currentAccountPicture: const Padding(
                padding: EdgeInsets.only(left: 0,top: 5),
                child: CircleAvatar(
                  radius: 800,
                  backgroundImage: 
                      AssetImage('assets/profile.png')
                              as ImageProvider, 
                ),
              ),
            accountEmail: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5), // Add vertical padding
              child: Text(
                retrieveData('email'),
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            accountName: Padding(
              padding: const EdgeInsets.only(top: 25), // Add bottom padding
              child: Text(
                retrieveData('username'),
                style: const TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Get.to(() => Dashboard()),
          ),
          _buildDrawerItem(
            icon: Icons.device_hub,
            text: 'Devices',
            onTap: () => Get.to(() => AddDevice()),
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
            onTap: () => Get.to(() => const Profile()),
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () async {
              await deleteData('username');
              await deleteData('email');
              await deleteData('firstname');
              await deleteData('lastname');
              await deleteData('slug');
              await deleteData('image');
              await deleteData('devices');
              await deleteToken("auth_token");
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
    ),
  );
}
