import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobapp/constants/colors.dart';
import 'package:mobapp/controle(temp/light/humidity)/controle.dart';
import 'package:mobapp/screens/app/notification.dart';
import 'package:mobapp/screens/device/add_device.dart';
import 'package:mobapp/screens/auth/login_screen.dart';
import 'package:mobapp/screens/user/profile.dart';
import 'package:mobapp/screens/user/setting.dart';

final localStorage = LocalStorage('app_data.json');

class HomeController extends GetxController {
  ChewieController? chewieController;
}

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = "To Agro_Farm";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSpace(),
              _buildLightRow(),
              _buildSpace(),
              _buildVisualRecording(),
              _buildVideoBox(context),
              _buildMetricRows(context),
              _buildRecommendationSection(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 120,
      centerTitle: true,
      flexibleSpace: _buildAppBarBackground(),
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white, size: 35),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text(
        'Welcome $user', // Display the greeting with the username
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [_buildProfileIcon()],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC7F2D8), // Set drawer color to C7F2D8
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 20), // Added horizontal padding
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                  fontSize: 24, // Increased font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.settings,
                  text: 'Setting',
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
                    MaterialPageRoute(builder: (context) => const Profile()),
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
                    deleteData('username');
                    deleteData('email');
                    deleteData('firstname');
                    deleteData('lastname');
                    deleteData('slug');

                    Get.offAllNamed('/login');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({IconData? icon, String? text, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text ?? ''),
      onTap: onTap,
    );
  }

  Widget _buildAppBarBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/plant.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Padding _buildProfileIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person, color: Colors.black, size: 40),
      ),
    );
  }

  SizedBox _buildSpace({double height = 40.0}) => SizedBox(height: height);

  Widget _buildLightRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLightText(),
        SizedBox(width: 22),
        _buildLightBox(),
        SizedBox(width: 5),
        _buildLightBox(),
        SizedBox(width: 22),
        _buildLightText(),
      ],
    );
  }

  Text _buildLightText() {
    return Text(
      ". light...\n  0",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Color(0xff000000),
      ),
    );
  }

  Container _buildLightBox() {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(12), // Added rounded corners
      ),
    );
  }

  Widget _buildVisualRecording() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        "Visual Recording",
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Padding _buildVideoBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 200,
        width: double.infinity, // Makes it responsive
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) => controller.chewieController != null &&
                  controller.chewieController!.videoPlayerController.value
                      .isInitialized
              ? Chewie(controller: controller.chewieController!)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Widget _buildMetricRows(BuildContext context) {
    List<List<Map<String, dynamic>>> visualReadingMetrics = [
      [
        {
          "title": "Soil Moisture",
          "description": "Light value of the shelf.",
          "navigationPage": control(),
        },
        {
          "title": "Soil Temp",
          "description": "Temperature value of the shelf.",
          "navigationPage": LoginScreen(),
        },
      ],
      [
        {
          "title": "Soil EC",
          "description": "Light Control of the shelf.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Soil Nitrogen",
          "description": "Temperature Control of the shelf.",
          "navigationPage": LoginScreen(),
        },
      ],
      [
        {
          "title": "Soil Phosphorus",
          "description": "Moisture Control of the shelf.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Soil Potassium",
          "description": "Phosphorous level in the soil.",
          "navigationPage":
              Row(children: [LoginScreen(), Icon(Icons.thermostat)]),
        },
      ],
    ];

    List<List<Map<String, dynamic>>> controlMetrics = [
      [
        {
          "title": "Light Control",
          "description": "Description for Control Metric 1.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Temperature Control",
          "description": "Temprature  Control of the Shelf",
          "navigationPage": LoginScreen(),
        },
      ],
      [
        {
          "title": "Humidity Control",
          "description": "Description for Control Metric 3.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Water Control",
          "description": "Description for Control Metric 4.",
          "navigationPage": LoginScreen(),
        },
      ],
    ];

    return Column(
      children: [
        SizedBox(height: 20), // Add some gap here
        _buildMetricRow(context, "Visual Reading", visualReadingMetrics),
        SizedBox(height: 20), // Add some gap here
        _buildMetricRow(context, "Control", controlMetrics),
        SizedBox(height: 20), // Add some gap here
      ],
    );
  }

  Widget _buildMetricRow(BuildContext context, String heading,
      List<List<Map<String, dynamic>>> metrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Text(
            heading,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: metrics.map((row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row.map((metric) {
                  return _buildMetricCard(
                    context,
                    metric["title"],
                    metric["description"],
                    metric["navigationPage"],
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String description,
    Widget navigationPage,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigationPage),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        height: 180,
        width: MediaQuery.of(context).size.width * 0.46, //width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "View",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildRecommendationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 150,
        width: double.infinity, // For responsive
        decoration: BoxDecoration(
          color: Color(
              0xFFC9E9C9), // Set the background color to C9E9C9 without opacity
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.withOpacity(0.5),
              Color(0xFF3FA956), // Removed opacity
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Device Connection",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10), // Add space between text and button
            Text(
              "No Device Connected",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10), // Add space between text and button
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Adddevice()),
              ),
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Bind the device",
                    style: TextStyle(
                      color: Color.fromARGB(255, 153, 211, 7),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> storeData(String key, dynamic value) async {
  await localStorage.ready;
  localStorage.setItem(key, value);
}

// Retrieve data
dynamic retrieveData(String key) {
  return localStorage.getItem(key);
}

// Delete data
void deleteData(String key) {
  localStorage.deleteItem(key);
}
