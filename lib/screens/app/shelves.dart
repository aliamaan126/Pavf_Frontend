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

class HomeController extends GetxController {
  ChewieController? chewieController;
}

class Shelves extends StatelessWidget {
  Shelves({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = retrieveData("username");

  // Sample data for shelves (replace it with your actual data)
  final List<String> shelfNames = ["Shelf 1", "Shelf 2", "Shelf 3"];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: buildDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: shelfNames.length,
                itemBuilder: (context, index) {
                  return _buildShelfCard(context, shelfNames[index]);
                },
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
        'Welcome $user',
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

  Widget _buildShelfCard(BuildContext context, String shelfName) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          color: Color(0xFFE4F3E0),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shelfconfig()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  shelfName,
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
    );
  }

  Widget _buildRecommendationSection(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 201, 233, 201),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
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
