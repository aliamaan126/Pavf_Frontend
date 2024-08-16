import "package:PAVF/screens/app/shelves.dart";
import 'package:PAVF/screens/app/shelf_dashboard.dart';
import "package:PAVF/screens/device/add_device.dart";
import "package:PAVF/screens/device/device_Setup.dart";
import "package:PAVF/screens/app/dashboard.dart";
import "package:PAVF/screens/auth/forgotPass_screen.dart";
import "package:PAVF/screens/auth/login_screen.dart";
import "package:PAVF/screens/auth/otp_screen.dart";
import "package:PAVF/screens/auth/register_screen.dart";
import "package:PAVF/screens/auth/resetPass_screen.dart";
import "package:PAVF/screens/device/device_conn.dart";
import "package:PAVF/screens/device/shelfconfig.dart";
import "package:PAVF/values/graph/ph_graph.dart";
import "package:PAVF/values/graph/potassium.dart";
import "package:PAVF/values/graph/soil_Ec.dart";
import "package:PAVF/values/graph/soil_moisture.dart";
import "package:PAVF/values/graph/soil_nitrogen.dart";
import "package:PAVF/values/graph/soilphosporous.dart";
import "package:PAVF/values/real_time/nitrogen.dart";
import "package:PAVF/values/real_time/pH.dart";
import "package:PAVF/values/real_time/phosphorous.dart";
import "package:PAVF/values/real_time/potassium.dart";
import "package:PAVF/values/real_time/soil_moisture.dart";
import "package:PAVF/values/real_time/soilec.dart";
import 'package:get/get.dart';
import 'package:PAVF/src/splash.dart';

class RouteGenerator {
  static List<GetPage> routes = [
    GetPage(
      name: '/',
      page: () => const Splash(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: '/forgotPass',
      page: () => ForgotPassScreen(),
    ),
    GetPage(
      name: '/otp',
      page: () => Otp(),
    ),
    GetPage(
      name: '/resetPass',
      page: () => ResetPass(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => Dashboard(),
    ),
    GetPage(
      name: '/shelves',
      page: () => Shelves(),
    ),
    GetPage(
      name: '/shelfdashboard',
      page: () => ShelfDashboard(),
    ),
    GetPage(
      name: "/shelfConfig", 
      page: ()=>Shelfconfig()
    ),
    GetPage(
      name: '/addDevice',
      page: () => AddDevice(),
    ),
    GetPage(
      name: '/deviceSetup',
      page: () => DeviceSetup(),
    ),
    GetPage(
      name: '/deviceConn',
      page: () => DeviceConn(),
    ),
    //real value
    GetPage(
      name: '/ecvalue',
      page: () => SoilEcValue(),
    ),
    GetPage(
      name: '/soilmoisture',
      page: () => SoilMoistureValue(),
    ),
    GetPage(
      name: '/ph',
      page: () => PhValue(),
    ),
    GetPage(
      name: '/phosvalue',
      page: () => Phosphorusvalue(),
    ),
    GetPage(
      name: '/Nitrovalue',
      page: () => Nitrogenvalue(),
    ),
    GetPage(
      name: '/potassvalue',
      page: () => potassiumvalue(),
    ),
    //graph
    GetPage(
      name: '/Egraph',
      page: () => SoilECgraph(),
    ),
    GetPage(
      name: '/PGRAPH',
      page: () => Phgraph(),
    ),
    GetPage(
      name: '/phosgraph',
      page: () => SoilPhosphorusgraph(),
    ),
    GetPage(
      name: '/potassgraph',
      page: () => Soilpotassiumgraph(),
    ),
    GetPage(
      name: '/soilmois',
      page: () => Soilgraph(),
    ),
    GetPage(
      name: '/soilnitro',
      page: () => SoilNCgraph(),
    ),
  ];

  
}
