import 'package:flutter/material.dart';
import 'package:next_project/screens/screens.dart';
import 'package:next_project/services/services.dart';
import 'package:next_project/utils/user.dart';
import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    final authService = Provider.of<AuthService>(context, listen:false );
    return Scaffold(
      body:Center(
        child: FutureBuilder(
          //verificando si existe el tocken para enviar a la pantalla de menu o a la pantala de inicio
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
           if(!snapshot.hasData)
            return Text('espere');

            if(User.token==''){
              Future.microtask((){
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___)=>LoginScreen(),
                  transitionDuration: Duration( seconds: 0)
                )
              );
              }
              );
            }else{
              Future.microtask((){
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___)=>HomeScreen(),
                  transitionDuration: Duration( seconds: 0)
                )
              );
              }
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}