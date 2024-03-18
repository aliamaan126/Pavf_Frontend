import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobapp/constants/colors.dart';
import 'package:mobapp/screens/login_screen.dart';
import 'package:mobapp/screens/profile.dart';


final localStorage = LocalStorage('app_data.json');


class HomeController extends GetxController {
  ChewieController? chewieController;
}

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightGreen, Colors.white],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _drawerHeader(),
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
              onTap: () {

              },
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              text: 'Setting',
              onTap: () {

              },
            ),
            _buildDrawerItem(
              icon: Icons.person,
              text: 'Personal',
              onTap: ()  => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.security,
              text: 'Security',
              onTap: () {
                
              },
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
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
      child: Text(
        'Menu',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
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
    // used a loop for rows
    List<List<Map<String, dynamic>>> metricRows = [
      [
        {
          "title": "Light Value",
          "description": "Light value of the shelf.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Temperature Value",
          "description": "Temperature value of the shelf.",
          "navigationPage": LoginScreen(),
        },
      ],
      [
        {
          "title": "Light Control",
          "description": "Light Control of the shelf.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Temperature contole",
          "description": "Temperature Control of the shelf.",
          "navigationPage": LoginScreen(),
        },
      ],
      [
        {
          "title": "Moisture",
          "description": "Moisture Control of the shelf.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Phosphorous",
          "description": "Phosphorous level in the soil.",
          "navigationPage": Row(children: [LoginScreen(), Icon(Icons.thermostat)]),
        },
      ],
      [
        {
          "title": "Moisture",
          "description": "Moisture Control of the shelf.",
          "navigationPage": LoginScreen(),
        },
        {
          "title": "Temperature",
          "description": "Temperature Control of the shelf.",
          "navigationPage": Row(children: [LoginScreen(), Icon(Icons.thermostat)]),
        },
      ],
    ];

    return Column(
      children: metricRows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: _buildMetricRow(context, row),
        );
      }).toList(),
    );
  }

  Widget _buildMetricRow(
      BuildContext context, List<Map<String, dynamic>> metrics) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjusted spacing
      children: metrics.map((metric) {
        return _buildMetricCard(
          context,
          metric["title"],
          metric["description"],
          metric["navigationPage"],
        );
      }).toList(),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String description,
    Widget navigationPage,
  ) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 180,
      width: MediaQuery.of(context).size.width * 0.4, //width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.green,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.green.withOpacity(0.7)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigationPage),
              ),
              child: Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "View",
                    style: TextStyle(
                      color: Color(0xff18A818),
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
Padding _buildRecommendationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 250,
        width: double.infinity, // For responsive
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green.withOpacity(0.5),
                Colors.white.withOpacity(0.9),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 160),
            InkWell(
              onTap: (){

              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: Center(
                    child: Text("To bind the device",
                        style: TextStyle(color: Colors.black, fontSize: 16))),
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