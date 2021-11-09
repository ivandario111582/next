import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';

Widget crearOrganization() {
  return Center(
      child: Container(
          child: Column(children: <Widget>[
    SizedBox(height: 2),
    Text(User.userName,
        textAlign: TextAlign.right, style: StyleApp.getStyleTitle(20)),
    
    Text(User.direcc,
        textAlign: TextAlign.right, style: StyleApp.getStyleTitle(15)),
    
    Text(User.tele,
        textAlign: TextAlign.right, style: StyleApp.getStyleTitle(15)),
  ])));
}
