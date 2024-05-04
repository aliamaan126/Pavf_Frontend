import 'package:flutter/material.dart';
import 'package:PAVF/component/drawer.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    // Your notification data
    {
      "id": 1,
      "icon": "assets/icons/filter.png",
      "heading": "Notification 1",
      "reason": "Reason 1",
      "date": "Today"
    },
    {
      "id": 2,
      "icon": "assets/icons/filter.png",
      "heading": "Notification 1",
      "reason": "Reason 1",
      "date": "Today"
    },
    {
      "id": 3,
      "icon": "assets/icons/M.png",
      "heading": "Notification 3",
      "reason": "Reason 3",
      "date": "Today"
    },
    {
      "id": 2,
      "icon": "assets/icons/device.png",
      "heading": "Notification 2",
      "reason": "Reason 2",
      "date": "Yesterday"
    },
    {
      "id": 4,
      "icon": "assets/icons/M.png",
      "heading": "Notification 4",
      "reason": "Reason 4",
      "date": "Yesterday"
    },
    {
      "id": 5,
      "icon": "assets/icons/M.png",
      "heading": "Notification 4",
      "reason": "Reason 4",
      "date": "Yesterday"
    }
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    notifications.sort((a, b) => b['date'].compareTo(a['date']));
    notifications = notifications.reversed.toList();

    String? lastDate;

    return Scaffold(
      key: _scaffoldKey,
      appBar: SubHeader(
        heading: 'Notifications',
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: buildDrawer(context),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          if (lastDate != notifications[index]["date"]) {
            lastDate = notifications[index]["date"];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * (10 / 375.0),
                    horizontal:
                        MediaQuery.of(context).size.width * (15 / 375.0),
                  ),
                  child: Text(
                    lastDate!,
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width * (18 / 375.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildNotificationList(index),
              ],
            );
          } else {
            return _buildNotificationList(index);
          }
        },
      ),
    );
  }

  Widget _buildNotificationList(int index) {
    return Dismissible(
      key: Key(notifications[index]["id"].toString()),
      background: Container(
        color: Colors.green,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * (15 / 375.0)),
        alignment: Alignment.centerLeft,
        child: Icon(Icons.archive),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * (15 / 375.0)),
        alignment: Alignment.centerRight,
        child: Icon(Icons.archive),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(notifications[index]["icon"]),
        ),
        title: Text(
          notifications[index]["heading"],
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * (16 / 375.0),
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          notifications[index]["reason"],
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * (14 / 375.0)),
        ),
        trailing: Icon(Icons.star_rate_rounded),
      ),
      onDismissed: (direction) {
        setState(() {
          notifications.removeAt(index);
        });
      },
    );
  }
}

class SubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String heading;
  final VoidCallback onPressed;

  const SubHeader({Key? key, required this.heading, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFC9E9C9),
      title: Center(
        child: Text(
          heading,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * (20 / 375.0),
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
