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
                //llamada a la pantalla de inicio
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___)=>CheckAuthScreen(storage: CounterStorage()),
                  transitionDuration: Duration( seconds: 0)
                ));
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
}
