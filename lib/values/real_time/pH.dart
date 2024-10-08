import 'package:PAVF/screens/app/local_storage.dart';
import 'package:PAVF/values/real_time/phosphorous.dart';

import 'package:PAVF/values/real_time/potassium.dart';
import 'package:PAVF/values/real_time/soil_moisture.dart';
import 'package:PAVF/values/real_time/soilec.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:PAVF/component/drawer.dart';

// Define the main widget for the real-time screen
class PhValue extends StatefulWidget {
  PhValue({Key? key}) : super(key: key);

  @override
  _PhValueState createState() => _PhValueState();
}

// Add MediaQuery
late MediaQueryData mediaQueryData;
late double screenWidth;
late double screenHeight;

class _PhValueState extends State<PhValue> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String user = "To Agro_Farm";
  final PageController _pageController = PageController();
  //media queruy
  late MediaQueryData mediaQueryData;
  late double screenWidth;
  late double screenHeight;

  final List<String> textData = [
    "PH Value",
  ];
  final List<IconData> iconData = [
    Icons.connected_tv_sharp,
    //  Icons.thermostat,
  ];
  int currentIndex = 0;
  // Global variables for each meter's speed value
  int speedValue1 = (retrieveData('temp')); 
double temperatureSpeed = double.parse(retrieveData('temp'));
double lightSpeed = double.parse(retrieveData('light'));
double humiditySpeed  = double.parse(retrieveData('humid'));
  

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
                  // backwad
                  Get.toNamed('/potassvalue');
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
                  Get.toNamed('/soilmoisture');
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
              Get.toNamed('/PGRAPH');
            } else if (index == 1) {
              Get.toNamed('/ph');
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
                  child: Text('Min '+retrieveData("phMin").toString(), style: TextStyle(color: Colors.white))),
            ),
            Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.065,
              decoration: BoxDecoration(
                color: Colors.green, // Color representing maximum value
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Text('Max '+retrieveData("phMax").toString(), style: TextStyle(color: Colors.white))),
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
                minSpeed: 0,
                maxSpeed: 14,
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
    home: PhValue(),
  ));
}
