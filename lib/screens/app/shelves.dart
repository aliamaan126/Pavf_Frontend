import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  ChewieController? chewieController;

  
}

class Shelves extends StatelessWidget {
  Shelves({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = retrieveData("username");

  // Sample data for shelves (replace it with your actual data)
  
  final String deviceName = Get.arguments['deviceName'];
  final String deviceId = Get.arguments['deviceId'];
  List<dynamic> shelfs = Get.arguments['shelfs'];

  
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
                itemCount: shelfs.length,
                itemBuilder: (context, index) {
                  return _buildShelfCard(context, "Shelf ID: "+shelfs[index]["shelf_id"],shelfs[index]);
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
        deviceName,
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

  Widget _buildShelfCard(BuildContext context, String ShelfId,Map<String, dynamic>? Shelves) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          color: Color(0xFFE4F3E0),
          elevation: 4.0,
          child: InkWell(
            onTap: () async {
              if(Shelves?["isConfigured"] == true){
                print(Shelves?["plant_data"]);
                await storeData("plantName", Shelves!["plant_data"]["name"]);
                await storeData("tempMin", Shelves!["plant_data"]["temperature"]["min"]);
                await storeData("tempMax", Shelves!["plant_data"]["temperature"]["max"]);
                await storeData("moisMin", Shelves!["plant_data"]["moisture"]["min"]);
                await storeData("moisMax", Shelves!["plant_data"]["moisture"]["max"]);
                await storeData("ecMin", Shelves!["plant_data"]["electrical_conductivity"]["min"]);
                await storeData("ecMax", Shelves!["plant_data"]["electrical_conductivity"]["max"]);
                await storeData("humiMin", Shelves!["plant_data"]["humidity"]["min"]);
                await storeData("humiMax", Shelves!["plant_data"]["humidity"]["max"]);
                await storeData("nitroMin", Shelves!["plant_data"]["nitrogen"]["min"]);
                await storeData("nitroMax", Shelves!["plant_data"]["nitrogen"]["max"]);
                await storeData("phosMin", Shelves!["plant_data"]["phosphorus"]["min"]);
                await storeData("phosMax", Shelves!["plant_data"]["phosphorus"]["max"]);
                await storeData("potaMin", Shelves!["plant_data"]["potassium"]["min"]);
                await storeData("potaMax", Shelves!["plant_data"]["potassium"]["max"]);
                await storeData("phMax", Shelves!["plant_data"]["ph"]["min"]);
                await storeData("phMin", Shelves!["plant_data"]["ph"]["max"]);

                Get.toNamed("/shelfdashboard");
                               
              }
              else
              {
                Get.toNamed("/shelfConfig",arguments: {"deviceID":deviceId,"shelfId":ShelfId,"deviceName":deviceName,"shelfs":shelfs});
              }
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  ShelfId,
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
      height: 80,
      width: double.infinity, // For responsive
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 201, 233, 201), // Set the background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        
      ),
    );
  }
}
