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
  required BuildContext context,
}) {
  return ListTile(
    leading: Icon(
      icon,
      size: MediaQuery.of(context).size.width * (iconSize / 375.0),
    ),
    title: Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * (textSize / 375.0),
      ),
    ),
    onTap: onTap,
  );
}

Widget buildDrawer(BuildContext context) {
  final imageUrl = retrieveData('image') ?? '';

  return Drawer(
    child: Container(
      color: const Color(0xFFC7F2D8),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * (220 / 375.0),
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              currentAccountPicture: const Padding(
                padding: EdgeInsets.only(left: 0, top: 5),
                child: CircleAvatar(
                  radius: 800,
                  backgroundImage:
                      AssetImage('assets/profile.png') as ImageProvider,
                ),
              ),
              accountEmail: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * (5 / 375.0)),
                child: Text(
                  retrieveData('email'),
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              accountName: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * (25 / 375.0)),
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
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.device_hub,
            text: 'Devices',
            onTap: () => Get.to(() => AddDevice()),
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.notifications,
            text: 'Notifications',
            onTap: () => Get.to(() => NotificationPage()),
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => Get.to(() => Settings()),
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: 'Profile',
            onTap: () => Get.to(() => const Profile()),
            context: context,
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

              await deleteData('moisture');
              await deleteData('temperature');
              await deleteData('conductivity');
              await deleteToken("pH");

              Get.offAllNamed('/login');
            },
            context: context,
          ),
        ],
      ),
    ),
  );
}
