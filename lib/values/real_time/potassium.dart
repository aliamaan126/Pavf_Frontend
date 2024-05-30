import 'package:PAVF/screens/app/local_storage.dart';
import 'package:PAVF/values/graph/potassium.dart';
import 'package:PAVF/values/real_time/nitrogen.dart';
import 'package:PAVF/values/real_time/pH.dart';
import 'package:PAVF/values/real_time/phosphorous.dart';
import 'package:PAVF/values/real_time/soil_moisture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:toggle_switch/toggle_switch.dart'; // Import ToggleSwitch package

// Define the main widget for the real-time screen
class potassiumvalue extends StatefulWidget {
  potassiumvalue({Key? key}) : super(key: key);

  @override
  _RealTimeState createState() => _RealTimeState();
}

// Add MediaQuery
late MediaQueryData mediaQueryData;
late double screenWidth;
late double screenHeight;

class _RealTimeState extends State<potassiumvalue> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String user = "To Agro_Farm";
  final PageController _pageController = PageController();
  //media queru
  late MediaQueryData mediaQueryData;
  late double screenWidth;
  late double screenHeight;

  final List<String> textData = ["Potassium"];
  final List<IconData> iconData = [Icons.emoji_nature];
  int currentIndex = 0;
  // Global variables for each meter's speed value
  // double speedValue1 =
  //     double.parse(retrieveData('temp')); // Speed value for Potassium
  // double speedValue2 =
  //     double.parse(retrieveData('light')); // Speed value for Nitrogen
  // double speedValue3 =
  //     double.parse(retrieveData('light')); // Speed value for Phosphorus
  // double speedValue4 =
  //     double.parse(retrieveData('light')); // Speed value for Soil EC

  // Define the speed value for the Potassium meter
// double temperatureSpeed = double.parse(retrieveData('temp'));
// double lightSpeed = double.parse(retrieveData('light'));
// double humiditySpeed  = double.parse(retrieveData('humid'));
  // int speedValue1 = retrieveData("moisture");
  int speedValue1 = 37;

  Widget build(BuildContext context) {
    // Retrieve MediaQuery
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      drawer: buildDrawer(),
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
        retrieveData("plantName"), // Display the greeting with the username
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      // actions: [_buildProfileIcon()],
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

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //backward
                  Get.toNamed('/phosvalue');
                },
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: null,
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Icon(
                  iconData[currentIndex],
                  size: screenWidth *
                      0.08, // Adjust icon size based on screen width
                ),
              ),
              Text(
                textData[currentIndex],
                style: TextStyle(
                    fontSize: screenWidth *
                        0.05), // Adjust font size based on screen width
              ),
              SizedBox(width: screenWidth * 0.03),
              GestureDetector(
                onTap: () {
                  //forward
                  Get.toNamed('/ph');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: null,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildTextScreen(0, speedValue1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextScreen(int index, int speedValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        ToggleSwitch(
          minWidth: screenWidth * 0.25, // Adjust width based on screen width
          cornerRadius: 100.0,
          activeBgColors: [
            [Color(0xFFC9E9C9)],
            [Color(0xFFC9E9C9)]
          ],
          activeFgColor: Color.fromARGB(255, 6, 6, 6),
          inactiveBgColor: Color(0xFF18A818),
          inactiveFgColor: Color.fromARGB(255, 0, 0, 0),
          initialLabelIndex: 1,
          totalSwitches: 2,
          labels: ['Graph', 'Realtime'],
          radiusStyle: true,
          onToggle: (index) {
            if (index == 0) {
              Get.toNamed('/potassgraph');
            } else if (index == 1) {
              Get.toNamed('/potassvalue');
            }
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.065,
              decoration: BoxDecoration(
                color: Colors.red, // Color representing minimum value
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Text('Min '+retrieveData("potaMin").toString(), style: TextStyle(color: Colors.white))),
            ),
            Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.065,
              decoration: BoxDecoration(
                color: Colors.green, // Color representing maximum value
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Text('Max '+retrieveData("potaMax").toString(), style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenWidth * 0.9,
              padding: EdgeInsets.all(12),
              child: KdGaugeView(
                minSpeed: 150,
                maxSpeed: 300,
                speed: speedValue.toDouble(),
                animate: true,
                duration: Duration(seconds: 5),
                alertSpeedArray: [40, 80, 90],
                alertColorArray: [Colors.green, Colors.indigo, Colors.green],
                unitOfMeasurement: "",
                gaugeWidth: 20,
                fractionDigits: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: potassiumvalue(),
  ));
}
