import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/screens/device/shelfconfig.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/component/drawer.dart';
import 'package:get/get.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// Example JSON response containing an array of items
final jsonResponse = {
  "items": []
};

void main() {
  runApp(MaterialApp(
    home: Shelf(),
  ));
}

class Shelf extends StatelessWidget {
  const Shelf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<dynamic> items =
        jsonResponse['items']!; // Extract array of items from JSON response

    return Scaffold(
      drawer: buildDrawer(), // This line includes the drawer
      appBar: const SubHeader(heading: "Shelf"),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC9E9C9),
        ),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CardItem(
              itemId: item['id'],
              itemName: item['name'],
              onTap: () {
                // Handle card tap (e.g., navigate to detail page)
                print('Card tapped: ${item['name']}');
                // Implement your navigation logic here
                Get.to(() => Shelfconfig());
              },
            );
          },
        ),
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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth, // Set maximum width to screen width
          minHeight: 110, // Set minimum height to 20 (adjust as needed)
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

class SubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String heading;

  const SubHeader({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFC9E9C9),
      leading: IconButton(
        icon: Icon(
            Icons.menu), // Specify the icon for the left button (e.g., menu)
        onPressed: () {
          // Handle onPressed event for the left button
          // Implement your logic here
          _scaffoldKey.currentState?.openDrawer(); // Open the drawer
        },
      ),
      title: Text(
        heading,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center, // Align the text to center
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
