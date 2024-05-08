import 'package:flutter/material.dart';
import 'package:PAVF/screens/app/dashboard.dart';
import 'package:PAVF/screens/device/device_Setup.dart';
import 'package:PAVF/screens/user/profile.dart';
import 'package:PAVF/screens/user/setting.dart';

void main() {
  runApp(MaterialApp(
    home: Shelfconfig(),
  ));
}

class Shelfconfig extends StatelessWidget {
  // Declare text controllers
  final TextEditingController _plantController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Define a list of plants
    List<String> plants = [
      'Plant A',
      'Plant B',
      'Plant C'
    ]; // Add your list of plants here

    // Define a variable to hold the selected plant and initialize it with null
    String? selectedPlant;

    return Scaffold(
      appBar: SubHeader(heading: "Shelf01"),
      body: Center(
        // Wrap with Center widget
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFC9E9C9),
          ),
          padding: EdgeInsets.all(40.0), // Add padding for better spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Select Plant', // Username text
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ), // Add some space between the text and the text field
              DropdownButtonFormField<String>(
                value: selectedPlant,
                onChanged: (String? newValue) {
                  // When a new plant is selected, update the selectedPlant variable
                  selectedPlant = newValue;
                },
                items: plants.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Make border round
                    borderSide: BorderSide(
                      color: Color(0xFFE4E4E4),
                    ), // Change border color
                  ), // Add border to the dropdown field
                  hintText: 'Select Plant', // Placeholder text
                  filled: true,
                  fillColor: Color(0xFFF9FAF9),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Date', // Password text
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ), // Add some space between the text and the text field
              TextFormField(
                // Text field for entering the date
                controller: _dateController, // Attach text controller

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xFFE4E4E4)),
                  ),
                  hintText: 'Enter Date',
                  filled: true,
                  fillColor: Color(0xFFF9FAF9),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Access entered text using text controllers
                      String selectedPlant = _plantController.text;
                      String enteredDate = _dateController.text;
                      // Add your connection logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF18A818), // Background color
                    ),
                    child: Text(
                      'confirm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 20, // Adjust text size
                        color: Colors.white, // Change text color to white
                      ),
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
      leading: GestureDetector(
        onTap: () {
          // Navigate to the AddDevice screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeviceSetup()),
          );
        },
        child: Icon(Icons.chevron_left), // Changed icon to "<"
      ),
      title: Center(
        child: Text(
          heading,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
