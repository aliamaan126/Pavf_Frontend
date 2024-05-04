import 'package:PAVF/values/graph/graphvalue.dart';
import 'package:PAVF/values/graph/potassium.dart';
import 'package:PAVF/values/real/soil_moisture.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:PAVF/values/real/potassium.dart';

import 'package:intl/intl.dart';

// Define the main widget for the real-time screen
void main() {
  runApp(MaterialApp(
    home: Soilgraph(),
  ));
}

class Soilgraph extends StatefulWidget {
  Soilgraph({Key? key}) : super(key: key);

  @override
  _SoilgraphState createState() => _SoilgraphState();
}

class _SoilgraphState extends State<Soilgraph> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String user = "To Agro_Farm";
  final PageController _pageController = PageController();
  late MediaQueryData mediaQueryData;
  late double screenWidth;
  late double screenHeight;

  final List<String> textData = ["Soil Moisture"];
  final List<IconData> iconData = [Icons.thermostat];
  int currentIndex = 0;

  int speedValue1 = 0;

  List<SalesData> chartData = [];

  @override
  void initState() {
    super.initState();
    chartData = _generateDummyData('1d'); // Initially set data to 1d
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      drawer: buildDrawer(context),
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
                        builder: (context) => Soilpotassiumgraph()),
                  );
                },
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: null,
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Icon(
                  iconData[currentIndex],
                  size: screenWidth * 0.08,
                ),
              ),
              Text(
                textData[currentIndex],
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tempgraph()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
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
          minWidth: screenWidth * 0.25,
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
                MaterialPageRoute(builder: (context) => SoilMoistureValue()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoilMoistureValue()),
              );
            }
          },
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: screenWidth * 0.15,
              height: screenHeight * 0.065,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Text('Min 32', style: TextStyle(color: Colors.white))),
            ),
            Container(
              width: screenWidth * 0.15,
              height: screenHeight * 0.065,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Text('Max 52', style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIntervalButton('1d'),
            _buildIntervalButton('3d'),
            _buildIntervalButton('7d'),
            _buildIntervalButton('1m'),
            _buildIntervalButton('3m'),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: SizedBox(
            height: 350,
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.08),
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
                                dateFormat: DateFormat
                                    .MMMd(), // Add this line to format dates
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
        updateChartData(interval);
      },
      child: Text(interval),
    );
  }

  List<SalesData> _generateDummyData(String interval) {
    // Dummy data generation logic based on interval
    List<SalesData> dummyData = [];
    DateTime now = DateTime.now();
    switch (interval) {
      case '1d':
        dummyData = [
          SalesData(now.subtract(Duration(days: 1)), 10),
          SalesData(now, 12),
        ];
        break;
      case '3d':
        dummyData = [
          SalesData(now.subtract(Duration(days: 3)), 8),
          SalesData(now.subtract(Duration(days: 2)), 9),
          SalesData(now.subtract(Duration(days: 1)), 10),
          SalesData(now, 12),
        ];
        break;
      // Add cases for other intervals if needed
      case '7d':
        dummyData = [
          SalesData(now.subtract(Duration(days: 3)), 8),
          SalesData(now.subtract(Duration(days: 2)), 9),
          SalesData(now.subtract(Duration(days: 5)), 11),
          SalesData(now, 12),
        ];
        break;
      case '1m':
        dummyData = [
          SalesData(now.subtract(Duration(days: 4)), 8),
          SalesData(now.subtract(Duration(days: 2)), 9),
          SalesData(now.subtract(Duration(days: 5)), 11),
          SalesData(now, 12),
        ];
        break;
      case '3m':
        dummyData = [
          SalesData(now.subtract(Duration(days: 7)), 8),
          SalesData(now.subtract(Duration(days: 21)), 9),
          SalesData(now.subtract(Duration(days: 5)), 11),
          SalesData(now, 12),
        ];
        break;
    }
    return dummyData;
  }

  void updateChartData(String interval) {
    setState(() {
      chartData = _generateDummyData(interval);
    });
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
