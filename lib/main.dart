import 'package:PAVF/utils/notification_service.dart';
import 'package:PAVF/utils/socket_client.dart';
import 'package:flutter/material.dart';
import 'package:PAVF/src/route_generator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SocketService()),
        ChangeNotifierProvider(create: (context) => NotificationService()),
      ],
      child: MainApp(),
    ),);
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final notificationService = Provider.of<NotificationService>(context);
    socketService.socket?.on("flutterNotification", (data) => {
      notificationService.showNotification(data["title"], data["message"])
    });
    return GetMaterialApp(
      title: "PAVF",
      initialRoute: '/',
      //onGenerateRoute: RouteGenerator.generateRoute,
      getPages: RouteGenerator.routes,
    );

  
  }
}
