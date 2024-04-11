import 'package:PAVF/component/drawer.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/screens/user/profile.dart';

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
      drawer: buildDrawer(
          context), // Call the buildDrawer function from drawer.dart
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
                      _buildRow("Notification", () {
                        print("Notification tapped");
                      }),
                      _buildRow("Privacy and Security", () {
                        print("Privacy and Security tapped");
                      }),
                      _buildRow("Terms and Policies", () {
                        print("Terms and Policies tapped");
                      }),
                      _buildRow("About", () {
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
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 70,
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
