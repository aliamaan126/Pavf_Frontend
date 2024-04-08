import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:PAVF/state_management/user.dart';

class StateManagement extends StatelessWidget{
  StateManagement({super.key});
  // final user=Rx<User>(User());
  final user=User().obs;
  void addUser(username,email,first_name,last_name,role){
    // user.update((usr) { 
    //   usr!.userName=username;
    //   usr!.email=email;
    //   usr?.first_name=first_name;
    //   usr?.last_name=last_name;
    //   usr!.role=role;
    // });

    user(User(userName: username,email: email,first_name: first_name,last_name: last_name,role: role));
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Controller extends GetxController{
  
}