import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/services/services.dart';
import 'package:provider/provider.dart';

class StyleApp{
    static getAppBarSimple(BuildContext context){
      final authService=Provider.of<AuthService>(context, listen: false);
          return AppBar(
          elevation: 0.1,
          backgroundColor: Color(Constants.colorBlue),
          title: new Text("Next ERP"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authService.logout();
                //llamada a la pantalla de inicio
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
        ]
      );
    }

    static getStyleTitle(double fontSize){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      //fontStyle: FontStyle.normal,
      fontStyle: FontStyle.normal,
      color: Color(Constants.colorBlue)
    );
  }
}
