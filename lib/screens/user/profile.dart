import 'dart:io';
import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'package:PAVF/constants/colors.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
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
  File? _profileImage = File(retrieveData('file'));
  String? imageExist = retrieveData('image') ;


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
    print(imageExist);
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: imageExist!= ""
                      ?NetworkImage(userImageDir+retrieveData("image")): 
                      AssetImage('assets/profile.png')
                              as ImageProvider, 
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Container(
                        alignment: Alignment(0, 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            _getImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(Icons.edit_document),
                          ),
                        ),
                      ),
                  ],
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
                    onPressed: () async {
                      await _updateProfile(context, _firstNameController, _lastNameController,  _profileImage);
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
                        // Reset changes or handle cancel action
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
    // Check if the title is 'Username' or 'Email'
    bool canEdit = title != 'Username' && title != 'Email'&& title != 'Role' ;

    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: canEdit &&
              _isEditing // Check if editing is allowed and is currently in editing mode
          ? TextField(controller: controller)
          : Text(controller.text),
      leading: Icon(icon),
    );
  }

  // Function to pick image from gallery
  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File selectedImage = File(image.path);

      int fileSizeInBytes = await selectedImage.length();
      int fileSizeInKB = fileSizeInBytes ~/ 1024;

      if (fileSizeInKB >= 1 && fileSizeInKB <= 200) {
        setState(() {
          _profileImage = selectedImage;
        });
        print('Image selected: ${selectedImage.path}');
      } else {
        // Reset the profile image and show the error message
        setState(() {
          _profileImage = null;
        });
        final snackBar = SnackBar(
          content: Text('Image size must be between 1KB and 200KB'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Image size is not within the allowed range');
      }
    }
  }
}

Future<String?> _updateProfile(
    BuildContext context,
    TextEditingController firstname,
    TextEditingController lastname,
    File? profileImage,
) async {
  final Fname = firstname.text;
  final Lname = lastname.text;

  

  // Add your API endpoint URL here
  final apiUrl = '$server/profile/update';
  

  try {
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    final token = await _secureStorage.read(key: 'auth_token');
    request.headers['Authorization'] = 'bearer $token';

    // Add form fields to the request
    request.fields['firstname'] = Fname;
    request.fields['lastname'] = Lname;
    if (profileImage != null) {
      var fileStream = http.ByteStream(profileImage.openRead());
      var length = await profileImage.length();
      var multipartFile = http.MultipartFile(
        'user_image',
        fileStream,
        length,
        filename: profileImage.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    // Send the request and get the response
    var streamedResponse = await request.send();

    // Check the response status code
    if (streamedResponse.statusCode == 202) {

      await storeData('firstname', Fname);
      await storeData('lastname', Lname);
      
      String userProfile = retrieveData("image");

      final storage = userImageDir+userProfile;
      
      await retriveFile(storage, userProfile);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Successfully Updated'),
          backgroundColor: Color.fromARGB(255, 26, 227, 42),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      // Handle other status codes if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: ${streamedResponse.reasonPhrase}'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Update failed: $e'),
      ),
    );
    return null;
  }
}