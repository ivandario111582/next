import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class Utility {
  static Future<dynamic> loadConfig(String path) async {
    String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  static Future<String> getLocalStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<Null> setLocalStorage(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }


  static navTo(context, Widget w) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => w),
    );
  }

  static navBack(context) {
    Navigator.pop(context);
  }
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static showToastMoreTime(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      
    );
  }



}
