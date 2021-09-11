import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
class NotificationsService{
  //notificaciones globales
  static GlobalKey<ScaffoldMessengerState>messengerKey= new GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String message){
    final snackBar=new SnackBar(
      backgroundColor:Constants.whitOpacity,
      content:Text(message,style: TextStyle(color:Colors.white, fontSize: 20),)
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}