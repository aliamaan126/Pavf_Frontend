import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:PAVF/values/real_time/nitrogen.dart';

import 'package:PAVF/values/real_time/phosphorous.dart';
import 'package:PAVF/values/real_time/potassium.dart';
import 'package:PAVF/values/real_time/soil_moisture.dart';
import 'package:PAVF/values/real_time/soilec.dart';
import 'package:PAVF/values/real_time/temperature.dart';
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

class Shelves extends StatelessWidget {
  Shelves({Key? key}) : super(key: key);
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = retrieveData("username");

  @override
  Widget build(BuildContext context) {
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
