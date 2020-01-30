import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {

  Future<bool> authenticateUser(String emailID, String password) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    sharedUser.setString('isUserRegisterd', "true");
    return true;
  }

  Future<bool> isUserAuthenticated() async {
    try{
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      var isRegistered = jsonDecode(sharedUser.getString('isUserRegisterd'));
      return false;
    }catch(e){
      return false;
    }
  }
}
