import 'package:flutter/material.dart';
import 'package:mobapp/src/route_generator.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "PAVF",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      //onGenerateRoute: RouteGenerator.generateRoute,
      getPages: RouteGenerator.routes,
      routingCallback: (routing) {
        if(routing!.current=='/register'){
          print('register');
        }
        
      },
    );
  }
}
