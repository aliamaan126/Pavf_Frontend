import 'package:flutter/material.dart';
import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/values/graphvalue.dart';

import 'package:kdgaugeview/kdgaugeview.dart';

import 'package:toggle_switch/toggle_switch.dart'; // Import ToggleSwitch package


double temperatureSpeed = double.parse(retrieveData('temp'));
double lightSpeed = double.parse(retrieveData('light'));
double humiditySpeed  = double.parse(retrieveData('humid'));

class realTime extends StatefulWidget {
  realTime({Key? key}) : super(key: key);

  @override
  _realtimeState createState() => _realtimeState();
}

class _realtimeState extends State<realTime> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = "To Agro_Farm";
  final PageController _pageController = PageController();

  // List of text and icon data
  final List<String> textData = [
    "Potassium",
    "Nitrogen",
    "Phosphorus",
    "Soil EC"
  ];
  final List<IconData> iconData = [
    Icons.emoji_nature, // Potassium icon
    Icons.grass, // Nitrogen icon
    Icons.thermostat, // Phosphorus icon
    Icons.landscape // Soil EC icon
  ];

  int currentIndex = 0;

  // Global variables for each meter's speed value
  double speedValue1 = double.parse(retrieveData('temp')); // Speed value for Potassium
  double speedValue2 = double.parse(retrieveData('light')); // Speed value for Nitrogen
  double speedValue3 = double.parse(retrieveData('light')); // Speed value for Phosphorus
  double speedValue4 = double.parse(retrieveData('light')); // Speed value for Soil EC

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: _buildBody(),
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

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 30.0), // Added space between app bar and body
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (currentIndex > 0) {
                    setState(() {
                      currentIndex--;
                    });
                    _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }
                },
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0), // Add padding here
                child: Icon(
                  iconData[currentIndex],
                  size: 40, // Increase the icon size as desired
                ),
              ),
              Text(
                textData[currentIndex],
                style: TextStyle(fontSize: 24), // Increase text size as desired
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0), // Add padding here
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (currentIndex < textData.length - 1) {
                      setState(() {
                        currentIndex++;
                      });
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildTextScreen(0, speedValue1 as int),
                _buildTextScreen(1, speedValue2 as int),
                _buildTextScreen(2, speedValue3 as int),
                _buildTextScreen(3, speedValue4 as int),
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
        SizedBox(
            height: 50), // Adjusted height between ToggleSwitch and GaugeView
        ToggleSwitch(
          minWidth: 90.0,
          cornerRadius: 100.0,
          activeBgColors: [
            [Color(0xFFC9E9C9)], // Set active background color to #C9E9C9
            [Color(0xFFC9E9C9)] // Set active background color to #C9E9C9
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
              // Navigate to the graph screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => graph()),
              );
            } else if (index == 1) {
              // Navigate to the realtime screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => realTime()),
              );
            }
          },
        ),

        SizedBox(height: 0), // Adjusted height after ToggleSwitch
        Expanded(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(12),
              child: KdGaugeView(
                minSpeed: 0,
                maxSpeed: 100,
                speed: speedValue.toDouble(), // Convert int to double
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
    home: realTime(),
  ));
}



Future<void> storeData(String key, dynamic value) async {
  await localStorage.ready;
  localStorage.setItem(key, value);
}

// Retrieve data
dynamic retrieveData(String key) {
  return localStorage.getItem(key);
}