import 'package:flutter/material.dart';
import 'package:PAVF/screens/device/device_Setup.dart';

import 'package:PAVF/screens/device/device_conn.dart';

void main() {
  runApp(MaterialApp(
    home: WifiConn(),
  ));
}

class WifiConn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubHeader(heading: "Wifi Connection"),
      body: Center(
        // Wrap with Center widget

        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFC9E9C9),
          ),

          padding: EdgeInsets.all(40.0), // Add padding for better spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'SSID', // Username text
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ), // Add some space between the text and the text field
              TextField(
                // Text field for entering the username
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make border round
                    borderSide: BorderSide(
                        color: Color(0xFFE4E4E4)), // Change border color
                  ), // Add border to the text field
                  hintText: 'Enter SSID', // Placeholder text
                  filled: true,
                  fillColor: Color(0xFFF9FAF9), // Change box color
                ),
              ),
              SizedBox(
                height: 30,
              ), // Add some space between the username and password fields
              Text(
                'Password', // Password text
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ), // Add some space between the text and the text field
              TextField(
                // Text field for entering the password
                obscureText: true, // Hide the entered text
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make border round
                    borderSide: BorderSide(
                        color: Color(0xFFE4E4E4)), // Change border color
                  ), // Add border to the text field
                  hintText: 'Enter your password', // Placeholder text
                  filled: true,
                  fillColor: Color(0xFFF9FAF9), // Change box color
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your connection logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF18A818), // Background color
                    ),
                    child: Text(
                      'Connect',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 20, // Adjust text size
                        color: Colors.white, // Change text color to white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            MaterialPageRoute(builder: (context) => DeviceSetup()),
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
