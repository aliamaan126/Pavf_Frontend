import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/screens/app/local_storage.dart';
import 'package:PAVF/utils/socket_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:PAVF/constants/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

final localStorage = LocalStorage('app_data.json');
const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String user = retrieveData("username").toString();

  // List to hold connected devices
  List<dynamic> connectedDevices = [];
  

  @override
  initState() {
    super.initState();
    // Fetch connected devices here, and update the list
    _fetchUserProfile();
    fetchConnectedDevices();
  }

  void fetchConnectedDevices() {
      setState(() {
      connectedDevices = retrieveData("devices");

      for(int i=0;i<connectedDevices.length;i++)
      {
        connectedDevices[i]["status"]=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    socketService.socket?.on("arduino-status", (data) => {
      setState((){
        for(int i=0;i<connectedDevices.length;i++)
      {
        if(connectedDevices[i]["deviceCredentials"]["username"]==data["deviceName"])
        {
            connectedDevices[i]["status"]=data["status"]; 
        }
      }
      })
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: buildDrawer(),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Display connected devices dynamically
              _buildConnectedDevices(context),
              _buildRecommendationSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectedDevices(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double screenWidth = mediaQueryData.size.width;
    // double screenHeight = mediaQueryData.size.height;

    print(connectedDevices);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Connected Devices",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: connectedDevices.length>0?
            GridView.builder(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns in the grid
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: (1/0.4)
              ),
              itemCount: connectedDevices.length,
              itemBuilder: (context, index) {
                return InkWell(
                onTap: () {
                  if(connectedDevices[index]["status"]==true)
                  {
                    Get.toNamed("/shelves",arguments: {"shelfs":connectedDevices[index]["shelfs"],"deviceId":connectedDevices[index]["_id"],"deviceName":connectedDevices[index]["deviceCredentials"]["username"]});
                  }
                  else{
                    Get.snackbar("Cannot Continue", "Device is offline",backgroundColor: Color.fromARGB(255, 243, 64, 48), duration: const Duration(seconds: 3));
                  }
                },
                child: Card(
                  elevation: 4.0,
                  color: Color.fromARGB(255, 228, 243, 224),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                        connectedDevices[index]["deviceCredentials"]["username"].toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 160),
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: connectedDevices[index]["status"]==true? Color.fromARGB(255, 27, 138, 93):const Color.fromARGB(255, 117, 118, 120),
                          shape: BoxShape.circle,
                        ),
                      )
                      ]
                    ),
                  ),
                ),);
              },
            ):GridView.builder(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns in the grid
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: (1/0.4)
              ),
              itemCount: 1,
              itemBuilder: (context, index) {
                return const Card(
                  elevation: 4.0,
                  color: Color.fromARGB(255, 228, 243, 224),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        "No Device Registered",
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
          ),
        ],
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
      height: 100,
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
          InkWell(
            onTap: () {
              Get.toNamed("/deviceConn");
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

Future<int> _fetchUserProfile() async {
    try {
      const apiUrl = '$server/profile';
      final token = await _secureStorage.read(key: 'auth_token');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String? user = data['user']?['username'];
        String? email = data['user']?['email'];
        String? fname = data['user']?['firstname'];
        String? lname = data['user']?['lastname'];
        String? role = data['user']?['role'];
        String? image = data['user']?['image'];
        List<dynamic>? devices = data['user']?['devices'];

        await storeData('username', user.toString());
        await storeData('email', email.toString());
        await storeData('firstname', fname.toString());
        await storeData('lastname', lname.toString());
        await storeData('role', role.toString());
        await storeData('image', image.toString());
        await storeData('devices', devices);
        return 200;
      } 
      else if(response.statusCode==401){
        return 401;
      }
      return response.statusCode;
    } catch (e) {
      // Handle exception
      print('Error fetching user profile: $e');
      throw e; // Propagate the error upwards if needed
    }
  }
