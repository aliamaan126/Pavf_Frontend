import 'package:PAVF/values/graph/soil_moisture.dart';
import 'package:PAVF/values/graph/soilphosporous.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/values/real/potassium.dart';

import 'package:intl/intl.dart';

// Define the main widget for the real-time screen
class Soilpotassiumgraph extends StatefulWidget {
  Soilpotassiumgraph({Key? key}) : super(key: key);

  @override
  _SoilpotassiumgraphState createState() => _SoilpotassiumgraphState();
}

class _SoilpotassiumgraphState extends State<Soilpotassiumgraph> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String user = "To Agro_Farm";
  final PageController _pageController = PageController();

  final List<String> textData = [
    "Potassium",
  ];
  final List<IconData> iconData = [
    Icons.eco, // Temperature icon
  ];

  int currentIndex = 0;

  int speedValue1 = 0;

  // Define chart data
  final List<SalesData> chartData = [
    SalesData(
      DateTime(1, 1),
      10,
    ),
    SalesData(DateTime(2, 1), 12),
    SalesData(DateTime(3, 1), 13),
    SalesData(DateTime(4, 1), 15),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      drawer: buildDrawer(),
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
                        builder: (context) => SoilPhosphorusgraph()),
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
                    MaterialPageRoute(builder: (context) => Soilgraph()),
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
        SizedBox(height: 10),
        ToggleSwitch(
          minWidth: 90.0,
          cornerRadius: 100.0,
          activeBgColors: [
            [Color(0xFF18A818)],
            [Color(0xFF18A818)]
          ],
          activeFgColor: Color.fromARGB(255, 6, 6, 6),
          inactiveBgColor: Color(0xFFC9E9C9),
          inactiveFgColor: Color.fromARGB(255, 0, 0, 0),
          initialLabelIndex: 1,
          totalSwitches: 2,
          labels: ['Graph', 'Realtime'],
          radiusStyle: true,
          onToggle: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoilPhosphorusgraph()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => realTime()),
              );
            }
          },
        ),
        SizedBox(height: 30), // Add this line
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red, // Color representing minimum value
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Text('Min 32', style: TextStyle(color: Colors.white))),
            ),
            Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green, // Color representing maximum value
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Text('Max 52', style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
        SizedBox(height: 40), // Add this line
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIntervalButton('1d'),
            _buildIntervalButton('3d'),
            _buildIntervalButton('7d'),
            _buildIntervalButton('1m'),
            _buildIntervalButton('1y'),
          ],
        ),
        SizedBox(height: 40), // Add this line
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 350,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 300,
                            child: SfCartesianChart(
                              backgroundColor: Colors.white,
                              primaryXAxis: DateTimeAxis(
                                title: AxisTitle(
                                  text: 'Date',
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                majorGridLines: MajorGridLines(
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                                plotOffset: 0,
                              ),
                              primaryYAxis: NumericAxis(
                                title: AxisTitle(
                                  text: 'Value',
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                axisLine: AxisLine(
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                                majorTickLines: MajorTickLines(
                                  size: 5,
                                  color: Colors.grey[300],
                                ),
                                numberFormat: NumberFormat.compact(),
                              ),
                              // Remove plotArea here
                              series: <CartesianSeries>[
                                LineSeries<SalesData, DateTime>(
                                  dataSource: chartData,
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales,
                                  color: Colors.blue,
                                  width: 2,
                                  markerSettings: MarkerSettings(
                                    isVisible: true,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIntervalButton(String interval) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press for the given interval
        // Update chart data based on the selected interval
      },
      child: Text(interval),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Soilpotassiumgraph(),
  ));
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
