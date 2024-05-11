import 'package:PAVF/constants/url.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
const FlutterSecureStorage _secureStorage = FlutterSecureStorage();


// Define global variables for speeds
double temperatureSpeed = 2;
double lightSpeed = 30;
double humiditySpeed = 40;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onMenuPressed;

  const CustomAppBar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    double appBarHeight = kToolbarHeight * 2;

    return Stack(
      children: [
        Image.asset(
          'assets/plant.jpg', // Path to your background image
          fit: BoxFit.cover,
          width: double.infinity,
          height: appBarHeight, // Set the height here
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, // Hide the default leading icon

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0), // Add space from the top
                child: IconButton(
                  icon: Icon(Icons.menu, size: 35),
                  onPressed: onMenuPressed,
                  color: Colors.white, // Set the color to white
                ),
              ),
              Expanded(
                  child:
                      Container()), // Empty Expanded to push the menu icon to the left corner
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2);
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
  final int initialIndex;

  View1Screen({this.initialIndex = 0}); // Define initialIndex parameter

  @override
  _View1ScreenState createState() => _View1ScreenState();
}

class _View1ScreenState extends State<View1Screen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String dynamicText = 'Temperature';

  int selectedIndex = 0;
  CarouselController _carouselController = CarouselController();

  bool isTemperatureOn = false;
  double temperatureSliderValue = retrieveData("setTempValue")>0?retrieveData("setTempValue"):temperatureSpeed;
  bool isManualMode = false;
  bool isLightOn = false;
  double lightSliderValue = retrieveData("setLightValue")>0?retrieveData("setLightValue"):lightSpeed;
  bool isHumidityOn = false;
  double humiditySliderValue = retrieveData("setHumidityValue")>0?retrieveData("setHumidityValue"):humiditySpeed;
  int state = 0;
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
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex; // Set selectedIndex to initialIndex
    dynamicText = buttonData[widget.initialIndex]['name']; // Set dynamicText
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: buildDrawer(),
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
                    // Set the currentIndex to selectedIndex
                    carouselController: _carouselController,
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
                      // Set initial index
                      initialPage: selectedIndex,
                    ),
                    items: buttonData.map((button) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () async {
                              // await fetchData();
                              setState(() {
                                dynamicText = button['name'];
                                selectedIndex = buttonData.indexOf(button);
                              });
                              // Set the current index of the carousel
                              _carouselController.animateToPage(selectedIndex);
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
                                      size: isSmallScreen ? 42.0 : 52.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 5.0 : 10.0),
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
                            if(isTemperatureOn==false)
                            {
                              state = 0;
                            }
                            else
                            {
                              state = 1;
                            }
                            controlUnit(context, "3d2c5777-25a4-455a-b8f3-fa0e135cc12b", "heating", retrieveData("setHumidityValue"), state);
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
                        duration: Duration(seconds: 2),
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
                          storeData("setTempValue", value);
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
                        // _buildIconButton(Icons.timer, 'Timer', isSmallScreen),
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
                            if(isLightOn==false)
                            {
                              state = 0;
                            }
                            else
                            {
                              state = 1;
                            }
                            controlUnit(context, "3d2c5777-25a4-455a-b8f3-fa0e135cc12b", "shelf_light", retrieveData("setLightValue"), state);
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
                      onChanged: isManualMode
                      ? null
                      : (value) {
                           setState(() {
                            print('Slider value changed: $value');
                          temperatureSliderValue = value;
                          storeData("setLightValue", value);
                          });
                        },
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: lightSliderValue.round().toString(),
                      activeColor: isManualMode ? Colors.grey:Colors.green,
                  thumbColor: isManualMode ?  Colors.grey:Colors.green,
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // _buildIconButton(Icons.air, 'Fan', isSmallScreen),
                        // _buildIconButton(Icons.ac_unit, 'Cool', isSmallScreen),
                        // _buildIconButton(Icons.whatshot, 'Heat', isSmallScreen),
                        // _buildIconButton(Icons.timer, 'Timer', isSmallScreen),
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
                            if(isHumidityOn==false)
                            {
                              state = 0;
                            }
                            else
                            {
                              state = 1;
                            }
                            controlUnit(context, "3d2c5777-25a4-455a-b8f3-fa0e135cc12b", "humidity", retrieveData("setHumidityValue"), state);
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
                          storeData("setHumidityValue", value);
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
                        _buildIconButton(Icons.air,'wind',isSmallScreen,),
                        // _buildIconButton(Icons.ac_unit, 'Cool', isSmallScreen),
                        _buildIconButton(Icons.whatshot, 'Heat', isSmallScreen),
                        // _buildIconButton(Icons.timer, 'Timer', isSmallScreen),
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

  //handel icon code
  Widget _buildIconButton(IconData icon, String label, bool isSmallScreen) {
    double iconSize = isSmallScreen ? 50.0 : 50.0;
    double labelSize = isSmallScreen ? 12.0 : 15.0;
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          iconSize: iconSize, // Set icon size based on screen size
          onPressed: () {
            isHumidityOn = !isHumidityOn;
            if(isHumidityOn==false)
            {
              state = 0;
            }
            else
            {
              state = 1;
            }
            controlUnit(context, "3d2c5777-25a4-455a-b8f3-fa0e135cc12b", "humidity", retrieveData("setHumidityValue"), state);
                          
          },
        ),
        SizedBox(height: isSmallScreen ? 25 : 15),
        Text(
          label,
          style: TextStyle(
              fontSize: labelSize), // Set label size based on screen size
        ),
      ],
    );
  }
}

Future<String?> controlUnit(
    BuildContext context,
    String deviceId,
    String action,
    double value,int state) async {
  const apiUrl = '$server/profile/device-control';
  final token = await _secureStorage.read(key: 'auth_token');
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        'deviceID': deviceId,
        'action': action,
        'state':state,
        'value': value
      }),
    );
    print(response.body);
    if (response.statusCode == 202) {
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Update failed: $e')),
    );
  }
  return null;
}