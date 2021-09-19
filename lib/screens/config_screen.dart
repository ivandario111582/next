import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/ui/input_decorations.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/services/services.dart';
import 'package:flutter/services.dart';
class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String urlServer  ='';
  String portServer ='';
  bool validURL     =false;
  String user       ='';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color(Constants.colorBlue),
          title: new Text("Next ERP")),
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
          children: [
            SizedBox(height: 250),
            Column(
              children: [
                SizedBox(height: 30),
                _serverWidget(),
                SizedBox(height: 30),
                _portWidget(),
                SizedBox(height: 30),
                _userWidget(),
                SizedBox(height: 30),
                _buttonWidget(context)
              ],
            )
          ]),
        ),
      )),
    );
  }
  Widget _serverWidget() {
    return Container(
        decoration: BoxDecoration(
            color: Constants.whitOpacity,
            borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'IP servidor / Dominio',
              prefixIcon: Icons.settings_input_antenna),
          onChanged: (valorUrl) {
        setState(() {
          urlServer = valorUrl;
        });
      },
          style: TextStyle(color: Colors.white),
        ));
  }
    Widget _portWidget() {
    return Container(
        decoration: BoxDecoration(
            color: Constants.whitOpacity,
            borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'Puerto',
              prefixIcon: Icons.settings_input_composite),
          onChanged: (valorPort) {
        setState(() {
          portServer = valorPort;
        });
      },
          style: TextStyle(color: Colors.white),
        ));
  }
      Widget _userWidget() {
    return Container(
        decoration: BoxDecoration(
            color: Constants.whitOpacity,
            borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'Usuario',
              prefixIcon: Icons.account_circle),
          onChanged: (valorUser) {
        setState(() {
          user = valorUser;
        });
      },
          style: TextStyle(color: Colors.white),
        ));
  }
  Widget _buttonWidget(BuildContext context) {
    return             Container(
              width: double.infinity,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  disabledColor: Colors.amber[400],
                  elevation: 0,
                  color: Color(Constants.colorOrange),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed:()=>{
                    validURL = Uri.parse(urlServer).isAbsolute,
                    if(validURL){
                      Config.configura(urlServer,portServer,user).then((_) {}),
                      Navigator.pushReplacementNamed(context, 'checking')
                     // SystemNavigator.pop()
                    }else{
                      NotificationsService.showSnackBar('La dirección URL no es válida')
                    }
                  }
                        ),
            );
  }
  
}


