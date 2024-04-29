import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:PAVF/values/real/nitrogen.dart';

import 'package:PAVF/values/real/phosphorous.dart';
import 'package:PAVF/values/real/potassium.dart';
import 'package:PAVF/values/real/soil_moisture.dart';
import 'package:PAVF/values/real/soilec.dart';
import 'package:PAVF/values/real/temperature.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import 'package:PAVF/control/control.dart';

import 'package:PAVF/screens/device/add_device.dart';

final localStorage = LocalStorage('app_data.json');

class HomeController extends GetxController {
  ChewieController? chewieController;
}

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = "To Agro_Farm";
  bool shouldDisplayRecommendation(List<dynamic> items) {
    return items.isEmpty; // Only display if items array is not empty
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = [];
    print("image:");
    print(retrieveData("image"));
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // _buildSpace(),
              // _buildLightRow(),
              // _buildSpace(),
              // _buildVisualRecording(),
              // _buildVideoBox(context),
              _buildMetricRows(context),
              if (shouldDisplayRecommendation(items))
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

  // Padding _buildProfileIcon() {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 20.0),
  //     child: CircleAvatar(
  //       backgroundColor: Colors.white,
  //       child: Icon(Icons.person, color: Colors.black, size: 40),
  //     ),
  //   );
  // }

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
          "navigationPage": SoilMoistureValue(),
        },
        {
          "title": "Soil Temp",
          "description": "Temperature value of the shelf.",
          "navigationPage": TemperatureValue(),
        },
      ],
      [
        {
          "title": "Soil EC",
          "description": "Light Control of the shelf.",
          "navigationPage": SoilEcValue(),
        },
        {
          "title": "Soil Nitrogen",
          "description": "Temperature Control of the shelf.",
          "navigationPage": Nitrogenvalue(),
        },
      ],
      [
        {
          "title": "Soil Phosphorus",
          "description": "Moisture Control of the shelf.",
          "navigationPage": Phosphorusvalue(),
        },
        {
          "title": "Soil Potassium",
          "description": "Phosphorous level in the soil.",
          "navigationPage": realTime(),
        },
      ],
    ];

    List<List<Map<String, dynamic>>> controlMetrics = [
      [
        {
          "title": "Light Control",
          "description": "Description for Control Metric 1.",
          "navigationPage": control(),
        },
        {
          "title": "Temperature Control",
          "description": "Temprature  Control of the Shelf",
          "navigationPage": control(),
        },
      ],
      [
        {
          "title": "Humidity Control",
          "description": "Description for Control Metric 3.",
          "navigationPage": control(),
        },
        {
          "title": "Water Control",
          "description": "Description for Control Metric 4.",
          "navigationPage": control(),
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
          color: Color.fromARGB(255, 201, 233, 201),
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
                fontSize: 12,
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
          color: Color.fromARGB(255, 201, 233, 201), // Set the background color to C9E9C9 without opacity
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
                Get.to(() => const AddDevice());
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
                child: const Center(
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
      ),
    );
  }
}
