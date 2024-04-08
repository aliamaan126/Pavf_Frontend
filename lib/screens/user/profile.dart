import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';



var user = retrieveData('username');
var email = retrieveData('email');
var fnmae = retrieveData('firstname');
var lname = retrieveData('lastname');
var role = retrieveData('role');

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      appBar: AppBar(
        elevation: 20, // Adds shadow
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/plant.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)), // Rounded corners
            ),
            alignment: Alignment(-0.8, 2),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_pic.png'),
              radius: 50,
              backgroundColor: Colors.white, // Contrast for the shadow
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    // Shadow for the avatar
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),

          
          ...ListTile.divideTiles(
            context: context,
            tiles: [
              SizedBox(height: 100),
              _buildListTile(Icons.person, 'Username', user),
              _buildListTile(Icons.email, 'Email', email),
              _buildListTile(Icons.text_fields, 'First Name', fnmae),
              _buildListTile(Icons.text_fields, 'Last Name', lname),
              _buildListTile(Icons.supervised_user_circle, 'Role', role),
            ],
          ).toList(),
        ],
      ),
          
      ),
    );
  }
  ListTile _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      leading: Icon(icon),
    );
  }
}


