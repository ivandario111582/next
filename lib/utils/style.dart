import 'package:flutter/material.dart';
import 'package:next_project/providers/multipleProviders.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/screens/screens.dart';
import 'package:provider/provider.dart';

class StyleApp{
    static getAppBarSimple(BuildContext context){
      //final authService=Provider.of<AuthService>(context, listen: false);
      final organization=Provider.of<MultipleProviders>(context);
          return AppBar(
          elevation: 0.1,
          backgroundColor: Color(Constants.colorBlue),
          title: new Text(Constants.tituloApp),
          actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
              }
            ),
          if (organization.cambiar=='true')
            IconButton(
              icon: Icon(Icons.autorenew_sharp),
              onPressed: () {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_, __, ___)=>BusinessScreen(),
                    transitionDuration: Duration( seconds: 0)
                  ));
              }
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                User.logout(context);
                Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                pageBuilder: (_, __, ___)=>LoginScreen(),
                            transitionDuration: Duration( seconds: 0)
                          ), (route) => false);
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
    static getStyleInfo(double fontSize){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      //fontStyle: FontStyle.normal,
      fontStyle: FontStyle.normal,
    );
  }
    static getStyleWarning(double fontSize){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      //fontStyle: FontStyle.normal,
      fontStyle: FontStyle.normal,
      color: Colors.red
    );
  }
    static getStyleBlack(double fontSize){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: Colors.black
    );
  }
}
