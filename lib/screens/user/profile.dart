import 'package:flutter/material.dart';
import 'package:PAVF/constants/colors.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _roleController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: retrieveData('username'));
    _emailController = TextEditingController(text: retrieveData('email'));
    _firstNameController =
        TextEditingController(text: retrieveData('firstname'));
    _lastNameController = TextEditingController(text: retrieveData('lastname'));
    _roleController = TextEditingController(text: retrieveData('role'));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: myBackground,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight + 150),
        child: AppBar(
          backgroundColor: Color.fromARGB(0, 191, 19, 19),
          iconTheme:
              IconThemeData(color: Colors.white), // Set icon color to white
          flexibleSpace: Stack(
            children: [
              Container(
                height: kToolbarHeight + 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/plant.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 100,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_pic.png'),
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Container(
                    alignment: Alignment(0, 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 201, 192, 192)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer(); // Open the drawer
              },
            ),
          ),
          title: Center(
            child: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 250, 249, 249),
              ),
            ),
          ),
        ),
      ),
      drawer: buildDrawer(context),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildListTile(Icons.person, 'Username', _usernameController),
            _buildListTile(Icons.email, 'Email', _emailController),
            _buildListTile(
                Icons.text_fields, 'First Name', _firstNameController),
            _buildListTile(Icons.text_fields, 'Last Name', _lastNameController),
            _buildListTile(
                Icons.supervised_user_circle, 'Role', _roleController),
            SizedBox(height: 20),
            if (_isEditing)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(
                          0xFF18A818), // Set the save button color to 18A818
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(
                          0xFFF3F3F3), // Set the cancel button color to F3F3F3
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFFA81818)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: !_isEditing
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              child: Icon(Icons.edit),
            )
          : null,
    );
  }

  ListTile _buildListTile(
      IconData icon, String title, TextEditingController controller) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _isEditing
          ? TextField(controller: controller)
          : Text(controller.text),
      leading: Icon(icon),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Profile(),
  ));
}
