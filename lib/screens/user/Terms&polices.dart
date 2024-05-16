import 'package:flutter/material.dart';
import 'package:PAVF/component/drawer.dart';

import 'package:get/get.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void main() {
  runApp(MaterialApp(
    home: TermPolicy(),
  ));
}

class TermPolicy extends StatelessWidget {
  const TermPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign _scaffoldKey to the Scaffold's key parameter
      backgroundColor: Color(0xFFC9E9C9),
      drawer: const buildDrawer(),
      appBar: const SubHeader(heading: ""),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xFFC9E9C9),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Terms and Policy",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "By accessing and using our app, you agree to abide by the following terms and policies. Users are granted a limited license to use the app for personal purposes only and must adhere to all applicable laws and regulations. We collect and use personal information in accordance with our privacy policy, ensuring its security and confidentiality. User-generated content must comply with our guidelines, and any infringement of intellectual property rights will result in termination of access. We reserve the right to modify these terms and policies at any time and encourage users to review them periodically.",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                            height: 20), // Adding space before the leaf icon
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedLogo(), // Using AnimatedLogo widget
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String heading;

  const SubHeader({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFC9E9C9),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
        ),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text(
        heading,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2), // Animation duration
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1).animate(_controller),
        child: Container(
          width: 50, // Adjust width of the container
          height: 50, // Adjust height of the container

          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/profile.png', // Corrected path to splash image
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
