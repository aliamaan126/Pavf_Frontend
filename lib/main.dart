import 'package:flutter/material.dart';
import 'package:PAVF/src/route_generator.dart';
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
      initialRoute: '/',
      //onGenerateRoute: RouteGenerator.generateRoute,
      getPages: RouteGenerator.routes,
    );
  }
}
