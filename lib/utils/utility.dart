//import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:next_project/utils/utils.dart';
//import 'package:intl/intl.dart';
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
      timeInSecForIosWeb: 3,
    );
  }

  static showToastMoreTime(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static String formatNumber(double dec, double numero) {
    String cadena = numero.toString();
    String cero = '';
    if (cadena.contains('.')) {
      cadena = formatString(dec, numero, '.');
    } else if (cadena.contains(',')) {
      cadena = formatString(dec, numero, ',');
    } else {
      for (int i = 1; i > dec; i++) {
        cero += '0';
      }
      cadena = cadena + '.' + cero;
    }
    return cadena;
  }

  static String formatString(double dec, double numero, String separador) {
    String cadena = numero.toString();
    var arrayCadena = cadena.split(separador);
    int numDec = arrayCadena[1].length;
    String subString = '';
    if (numDec < dec) {
      subString = arrayCadena[1].padRight(dec.toInt(), '0');
    } else {
      subString = arrayCadena[1].substring(0, dec.toInt());
    }
    cadena = arrayCadena[0] + '.' + subString;
    return cadena;
  }

  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static String getDateTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
    final DateFormat formatterHour = DateFormat('HH:mm:ss');
    final String formatted =
        formatterDate.format(now) + 'T' + formatterHour.format(now);
    return formatted;
  }

  static String setDateTimeFormat(String date) {
    final arrayDate=date.split('T');
    final arrayFecha=arrayDate[0].split('-');
    String fecha=arrayFecha[2]+'-'+arrayFecha[1]+'-'+arrayFecha[0]+' '+arrayDate[1];
    return fecha;
  }
  static int setColorlabel(String estado){
    int color=Constants.colorWhite;
    switch(estado) { 
      case "PENDIENTE": color=Constants.colorRed;
      break;
      case "PROCESO": color=Constants.colorOrange;
      break; 
      case "TERMINADO": color=Constants.colorGreen;
      break; 
   }
    return color;
  }
  static String stringCut(String cadena){
    cadena=cadena.trim();
    return (cadena.length>70)?cadena.substring(0,70):cadena;
  }
}
