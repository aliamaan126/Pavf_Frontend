import 'package:get/get.dart';
import 'package:PAVF/state_management/user.dart';
class GController extends GetxController{
  final user=User().obs;
   void updateUser(username,email,first_name,last_name,role)async{
    print("Update Function Called");
    print(username);
    // user.value.userName=username;
    user(User(userName: username,email: email,first_name: first_name,last_name: last_name,role: role));
    
  }
}



// var  userName = ''.obs;
//   var  Email = ''.obs;
//   var  First_Name = ''.obs;
//   var  Last_Name = ''.obs;
//   var  Role = ''.obs;

//   void updateUser(String username,email,first_name,last_name,role){
//     userName.value=username;
//     Email.value=email.obs;
//     First_Name.value=first_name.obs;
//     Last_Name.value=last_name.obs;
//     Role.value=role.obs;
//   }