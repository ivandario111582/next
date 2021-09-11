import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
  Widget crearOrganization() {
    return Center(
          child: Container(
              child: Column(children: <Widget>[
        SizedBox(height: 30),
        Text(User.userName,
            textAlign: TextAlign.right, style: StyleApp.getStyleTitle(20)),
        SizedBox(height: 10),
        Text(User.direcc,
            textAlign: TextAlign.right, style: StyleApp.getStyleTitle(15)),
        SizedBox(height: 10),
        Text(User.tele,
            textAlign: TextAlign.right, style: StyleApp.getStyleTitle(15)),
      ])));
  }