import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/shelves.dart';
import 'package:PAVF/screens/app/shlef_dashboard.dart';
import 'package:PAVF/screens/device/add_device.dart';
import 'package:PAVF/screens/device/shelfconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:PAVF/screens/app/notification.dart';
import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/screens/user/setting.dart';
import 'package:PAVF/screens/user/profile.dart';
import 'package:PAVF/screens/app/flutter_secure_storage.dart';
import 'package:PAVF/screens/app/local_storage.dart';

class buildDrawer extends StatelessWidget {
  const buildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imageExist = retrieveData('image') ?? '';

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
                currentAccountPicture: Padding(
                  padding: EdgeInsets.only(left: 0, top: 5),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: imageExist!.isNotEmpty
                        ? NetworkImage(userImageDir + retrieveData('image')!)
                        : const AssetImage('assets/profile.png')
                            as ImageProvider,
                  ),
                ),
                accountEmail: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          MediaQuery.of(context).size.width * (5 / 375.0)),
                  child: Text(
                    retrieveData('email') ?? '',
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
                accountName: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * (25 / 375.0)),
                  child: Text(
                    retrieveData('username') ?? '',
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            DrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Get.to(() => ShelfDashboard()),
            ),
            DrawerItem(
              icon: Icons.device_hub,
              text: 'Devices',
              onTap: () => Get.to(() => AddDevice()),
            ),
            DrawerItem(
              icon: Icons.notifications,
              text: 'Notifications',
              onTap: () => Get.to(() => NotificationPage()),
            ),
            DrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () => Get.to(() => Settings()),
            ),
            DrawerItem(
              icon: Icons.device_hub,
              text: 'shelf',
              onTap: () => Get.to(() => Shelves()),
            ),
            DrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () => {Get.to(() => const Profile())},
            ),
            DrawerItem(
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
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: MediaQuery.of(context).size.width * (28 / 375.0),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * (16 / 375.0),
        ),
      ),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }
}
