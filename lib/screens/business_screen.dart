import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';


  class BusinessScreen extends StatefulWidget {
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
void initState(){
  super.initState();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
}


  @override
  Widget build(BuildContext context) {

 // final authService=Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar:StyleApp.getAppBarSimple(context),  
      body:
      SafeArea(
      child:Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            children: [
        Container(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        image:DecorationImage(
              image: AssetImage(Constants.backGrountImage),fit:BoxFit.cover),
        )
        ),
        Center(child:
        Container(
        child: Column(
          children: <Widget>[
            SizedBox( height: 20 ),
            crearOrganization(context),
            SizedBox( height: 30 ),
          ]))),

     ]),
      )
   ));
  }

  @override
dispose(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  super.dispose();
}
}



