import 'package:flutter/material.dart';
import 'package:mobapp/screens/app/dashboard.dart';
import 'package:mobapp/screens/user/profile.dart';

void main() {
  runApp(MaterialApp(
    home: Settings(),
  ));
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SubHeader(heading: "Settings"),
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
                  width: screenWidth * 1, // Adjust width as needed
                  height: screenHeight * 0.8, // Adjust height as needed
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    children: [
                      _buildRow("Personal Information", () {
                        // onTap action for Personal Information
                        print("Personal Information tapped");
                      }),
                      _buildRow("Notification", () {
                        // onTap action for Notification
                        print("Notification tapped");
                      }),
                      _buildRow("Privacy and Security", () {
                        // onTap action for Privacy and Security
                        print("Privacy and Security tapped");
                      }),
                      _buildRow("Terms and Policies", () {
                        // onTap action for Terms and Policies
                        print("Terms and Policies tapped");
                      }),
                      _buildRow("Rate App", () {
                        // onTap action for Rate App
                        print("Rate App tapped");
                      }),
                      _buildRow("Become a Professional", () {
                        // onTap action for Become a Professional
                        print("Become a Professional tapped");
                      }),
                      _buildRow("About", () {
                        // onTap action for About
                        print("About tapped");
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

  Widget _buildRow(String label, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding
      child: Container(
        height: 70, // Adjust height of ListTile
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
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
          title: Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2c2c2c),
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Color(0xFFC6C6C6),
            size: 20,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

// Define the _buildDrawerItem function here
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

class SubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String heading;

  const SubHeader({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFC9E9C9),
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
