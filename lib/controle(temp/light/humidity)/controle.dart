import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:mobapp/screens/dashboard.dart';
import 'package:mobapp/screens/user/setting.dart';

// Define global variables for speeds
double temperatureSpeed = 10.0;
double lightSpeed = 40.0;
double humiditySpeed = 100.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onMenuPressed;

  CustomAppBar({required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: onMenuPressed,
        color: Colors.black,
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class control extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      title: 'View',
      home: View1Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class View1Screen extends StatefulWidget {
  @override
  _View1ScreenState createState() => _View1ScreenState();
}

class _View1ScreenState extends State<View1Screen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String dynamicText = 'Temperature';
  int selectedIndex = 0;
  bool isTemperatureOn = false;
  double temperatureSliderValue = 0.0;
  bool isManualMode = false;
  bool isLightOn = false;
  double lightSliderValue = 0.0;
  bool isHumidityOn = false;
  double humiditySliderValue = 0.0;

  List<Map<String, dynamic>> buttonData = [
    {'icon': Icons.thermostat, 'name': 'Temperature'},
    {'icon': Icons.lightbulb, 'name': 'Light Bulb'},
    {'icon': Icons.opacity, 'name': 'Humidity'},
  ];

  // Define GlobalKey instances for each KdGaugeView
  GlobalKey<KdGaugeViewState> temperatureGaugeKey = GlobalKey();
  GlobalKey<KdGaugeViewState> lightGaugeKey = GlobalKey();
  GlobalKey<KdGaugeViewState> humidityGaugeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: Drawer(
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
              DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Personal'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('Security'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 600;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dynamicText,
                    style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: isSmallScreen ? 10 : 20),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: isSmallScreen ? 100.0 : 150.0,
                      viewportFraction: 0.4,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          dynamicText = buttonData[index]['name'];
                          selectedIndex = index;
                        });
                      },
                    ),
                    items: buttonData.map((button) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                dynamicText = button['name'];
                                selectedIndex = buttonData.indexOf(button);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 5.0 : 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: selectedIndex ==
                                              buttonData.indexOf(button)
                                          ? Color.fromARGB(255, 51, 243, 33)
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 2),
                                          blurRadius: 4.0,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(
                                      isSmallScreen ? 10.0 : 15.0,
                                    ),
                                    child: Icon(
                                      button['icon'],
                                      size: isSmallScreen ? 24.0 : 32.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 5.0 : 10.0),
                                  Text(
                                    button['name'],
                                    style: TextStyle(
                                      color: selectedIndex ==
                                              buttonData.indexOf(button)
                                          ? Colors.blue
                                          : Colors.grey,
                                      fontSize: isSmallScreen ? 12.0 : 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  if (dynamicText == 'Temperature') ...[
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isTemperatureOn = !isTemperatureOn;
                          });
                        },
                        child: Text(isTemperatureOn ? 'Turn Off' : 'Turn On'),
                      ),
                    ),
                    Container(
                      width: isSmallScreen ? 300 : 400,
                      height: isSmallScreen ? 300 : 400,
                      padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                      child: KdGaugeView(
                        key: temperatureGaugeKey, // Use GlobalKey instance
                        minSpeed: 0,
                        maxSpeed: 100,
                        speed: temperatureSpeed,
                        animate: true,
                        duration: Duration(seconds: 5),
                        alertSpeedArray: [40, 80, 90],
                        alertColorArray: [
                          Colors.green,
                          Colors.indigo,
                          Colors.green
                        ],
                        unitOfMeasurement: "",
                        gaugeWidth: 20,
                        fractionDigits: 0,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Slider(
                      value: temperatureSliderValue,
                      onChanged: (value) {
                        setState(() {
                          temperatureSliderValue = value;
                        });
                      },
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: temperatureSliderValue.round().toString(),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconButton(Icons.air, 'Fan', isSmallScreen),
                        _buildIconButton(Icons.ac_unit, 'Cool', isSmallScreen),
                        _buildIconButton(Icons.whatshot, 'Heat', isSmallScreen),
                        _buildIconButton(Icons.timer, 'Timer', isSmallScreen),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Manual',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12.0 : 16.0,
                          ),
                        ),
                        Switch(
                          value: isManualMode,
                          onChanged: (value) {
                            setState(() {
                              isManualMode = value;
                            });
                          },
                        ),
                        Text(
                          'Auto',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12.0 : 16.0,
                          ),
                        ),
                      ],
                    ),
                  ] else if (dynamicText == 'Light Bulb') ...[
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLightOn = !isLightOn;
                          });
                        },
                        child: Text(isLightOn ? 'Turn Off' : 'Turn On'),
                      ),
                    ),
                    Container(
                      width: isSmallScreen ? 300 : 400,
                      height: isSmallScreen ? 300 : 400,
                      padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                      child: KdGaugeView(
                        key: lightGaugeKey, // Use GlobalKey instance
                        minSpeed: 0,
                        maxSpeed: 100,
                        speed: lightSpeed,
                        animate: true,
                        duration: Duration(seconds: 5),
                        alertSpeedArray: [40, 80, 90],
                        alertColorArray: [
                          Colors.green,
                          Colors.indigo,
                          Colors.green
                        ],
                        unitOfMeasurement: "",
                        gaugeWidth: 20,
                        fractionDigits: 0,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Slider(
                      value: lightSliderValue,
                      onChanged: (value) {
                        setState(() {
                          lightSliderValue = value;
                        });
                      },
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: lightSliderValue.round().toString(),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconButton(Icons.air, 'Fan', isSmallScreen),
                        _buildIconButton(Icons.ac_unit, 'Cool', isSmallScreen),
                        _buildIconButton(Icons.whatshot, 'Heat', isSmallScreen),
                        _buildIconButton(Icons.timer, 'Timer', isSmallScreen),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Manual',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12.0 : 16.0,
                          ),
                        ),
                        Switch(
                          value: isManualMode,
                          onChanged: (value) {
                            setState(() {
                              isManualMode = value;
                            });
                          },
                        ),
                        Text(
                          'Auto',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12.0 : 16.0,
                          ),
                        ),
                      ],
                    ),
                  ] else if (dynamicText == 'Humidity') ...[
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isHumidityOn = !isHumidityOn;
                          });
                        },
                        child: Text(isHumidityOn ? 'Turn Off' : 'Turn On'),
                      ),
                    ),
                    Container(
                      width: isSmallScreen ? 300 : 400,
                      height: isSmallScreen ? 300 : 400,
                      padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                      child: KdGaugeView(
                        key: humidityGaugeKey, // Use GlobalKey instance
                        minSpeed: 0,
                        maxSpeed: 100,
                        speed: humiditySpeed,
                        animate: true,
                        duration: Duration(seconds: 5),
                        alertSpeedArray: [40, 80, 90],
                        alertColorArray: [
                          Colors.green,
                          Colors.indigo,
                          Colors.green
                        ],
                        unitOfMeasurement: "",
                        gaugeWidth: 20,
                        fractionDigits: 0,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Slider(
                      value: humiditySliderValue,
                      onChanged: (value) {
                        setState(() {
                          humiditySliderValue = value;
                        });
                      },
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: humiditySliderValue.round().toString(),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconButton(Icons.air, 'Fan', isSmallScreen),
                        _buildIconButton(Icons.ac_unit, 'Cool', isSmallScreen),
                        _buildIconButton(Icons.whatshot, 'Heat', isSmallScreen),
                        _buildIconButton(Icons.timer, 'Timer', isSmallScreen),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Manual',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12.0 : 16.0,
                          ),
                        ),
                        Switch(
                          value: isManualMode,
                          onChanged: (value) {
                            setState(() {
                              isManualMode = value;
                            });
                          },
                        ),
                        Text(
                          'Auto',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12.0 : 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, bool isSmallScreen) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
        ),
        SizedBox(height: isSmallScreen ? 5 : 10),
        Text(
          label,
        ),
      ],
    );
  }
}

void main() {
  runApp(control());
}
