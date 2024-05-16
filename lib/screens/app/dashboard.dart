import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:PAVF/screens/device/shelfconfig.dart';
import 'package:PAVF/values/real_time/nitrogen.dart';
import 'package:PAVF/values/real_time/phosphorous.dart';
import 'package:PAVF/values/real_time/potassium.dart';
import 'package:PAVF/values/real_time/soil_moisture.dart';
import 'package:PAVF/values/real_time/soilec.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:PAVF/control/control.dart';
import 'package:PAVF/screens/device/add_device.dart';

final localStorage = LocalStorage('app_data.json');

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = retrieveData("username");

  // List to hold connected devices
  List<String> connectedDevices = [];

  @override
  void initState() {
    super.initState();
    // Fetch connected devices here, and update the list
    fetchConnectedDevices();
  }

  // Method to fetch connected devices (you need to implement this)
  void fetchConnectedDevices() {
    // Fetch connected devices logic goes here
    // For demonstration purpose, I'm adding some sample devices
    setState(() {
      connectedDevices = ['Device 1', 'Device 2', 'Device 3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Assuming a boolean variable `_isDeviceRegistered` to track device registration status
    bool _isDeviceRegistered =
        false; // Set this value based on registration status

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: buildDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Add other widgets above if needed

                    // Centered Container containing Card Button
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        width: screenSize.width * 0.9, // 90% of screen width
                        height: screenSize.height * 0.1,
                        child: Card(
                          color: _isDeviceRegistered
                              ? Color(0xFFE4F3E0)
                              : Colors
                                  .white, // Background color based on registration status
                          elevation: 4.0,
                          child: InkWell(
                            onTap: () {
                              // Handle onTap event
                              if (!_isDeviceRegistered) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Shelfconfig()),
                                );
                              } else {
                                // Handle device activation
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  _isDeviceRegistered
                                      ? "Device Registered"
                                      : "Device Not Registered",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Display connected devices dynamically
                    _buildConnectedDevices(),
                  ],
                ),
              ),
            ),
            _buildRecommendationSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedDevices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Connected Devices",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            mainAxisSpacing: 10.0, // Spacing between rows
            crossAxisSpacing: 10.0, // Spacing between columns
            childAspectRatio: 1.0, // Aspect ratio of each grid item
          ),
          itemCount: connectedDevices.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    connectedDevices[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
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

  Widget _buildRecommendationSection(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 150,
      width: double.infinity, // For responsive
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 201, 233, 201), // Set the background color
        borderRadius: BorderRadius.circular(10),
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
            onTap: () {
              Get.to(() => AddDevice());
            },
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 253, 253),
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  "Bind the device",
                  style: TextStyle(
                    color: Color.fromARGB(255, 40, 176, 6),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final int itemId;
  final String itemName;
  final VoidCallback onTap;

  CardItem({
    required this.itemId,
    required this.itemName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth, // Set maximum width to screen width
          maxHeight: screenHeight,
        ),
        child: Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20, left: 20),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
