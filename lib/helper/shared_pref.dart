

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String sharedPrefUserLoginKey = "ISLOGEDDIN";
  static String sharedPreUsernameKey = "usernamekey";
  static String sharedPreUserEmailKey = "emailkey";

  //saving data to shared preferences....

  static Future <void> saveUserLoggedInShared(bool isUserLogIn)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(sharedPrefUserLoginKey, isUserLogIn);


  }
  static Future <void> saveUserNameShared(String userName)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(sharedPreUsernameKey, userName);


  }
  static Future <void> saveUserEmailShared(String userEmail)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(sharedPreUserEmailKey, userEmail);


  }
 static saveSharedPreferences(String email)async{
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString('email',email);
    // sharedpref.setString(,);
    print(" shared saved");

  }

  //get the data from sharedPreferences

  static Future <String> getUserEmailShared()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(sharedPreUserEmailKey);


  }static Future <String> getUserNameShared()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(sharedPreUsernameKey);


  }
  static Future <bool> getUserLoggedIn()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getBool(sharedPrefUserLoginKey);


  }

}