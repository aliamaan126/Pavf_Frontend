import 'package:PAVF/values/graph/graphvalue.dart';

import 'package:PAVF/values/real/potassium.dart';
import 'package:PAVF/values/real/soil_moisture.dart';
import 'package:PAVF/values/real/soilec.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:PAVF/component/drawer.dart';

// Define the main widget for the real-time screen
class TemperatureValue extends StatefulWidget {
  TemperatureValue({Key? key}) : super(key: key);

  @override
  _TemperatureValueState createState() => _TemperatureValueState();
}

class _TemperatureValueState extends State<TemperatureValue> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String user = "To Agro_Farm";
  final PageController _pageController = PageController();

  final List<String> textData = [
    "Temperature",
  ];
  final List<IconData> iconData = [
    Icons.thermostat, // Temperature icon
  ];
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
  int speedValue1 = 30;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      drawer: buildDrawer(context),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SoilMoistureValue()),
                  );
                },
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: null,
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  iconData[currentIndex],
                  size: 40,
                ),
              ),
              Text(
                textData[currentIndex],
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    //forward move
                    MaterialPageRoute(builder: (context) => SoilEcValue()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
          minWidth: 90.0,
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
              Navigator.push(
                context,
                //graph
                MaterialPageRoute(builder: (context) => Tempgraph()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TemperatureValue()),
              );
            }
          },
        ),
        SizedBox(height: 0),
        Expanded(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(12),
              child: KdGaugeView(
                minSpeed: 0,
                maxSpeed: 100,
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
    home: TemperatureValue(),
  ));
}
