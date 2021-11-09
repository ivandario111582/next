import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/ui/input_decorations.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/services/services.dart';
import 'package:next_project/screens/screens.dart';

class ConfigScreen extends StatefulWidget {
  final CounterStorage storage;
  ConfigScreen({Key? key, required this.storage}) : super(key: key);
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerServer = new TextEditingController();
  TextEditingController _controllerPort = new TextEditingController();
  String urlServer = '';
  String portServer = '';
  bool validURL = false;
  String user = '';
  String cadena = '';
  String _dataDisp = '';
  String counter = '0';
  String chekUsuario = '0';
  @override
  void initState() {
    super.initState();
    try {
      widget.storage.readCounter().then((String value) {
        setState(() {
          _dataDisp = value;
        });
        //retorna como 0 en el caso que es primer logeo o se presiono cerrar sesión para ir directamente a la pantalla de login
        if (_dataDisp == '0') {
          setState(() {
            counter = '0';
          });
        } else {
          //siginifica que ya ha ingresado antes, divide la cadena recueprada para tomar id del usuario y verificar el estado del usuario
          var arrayData = _dataDisp.split('@');
          setState(() {
            urlServer = arrayData[0];
            portServer = arrayData[1];
            user = arrayData[2];
          });

          chekUsuario = '1';
        }
        //llama a la funcion que verifica el estado de usuario y la versión de la app
        //  _check(userId);
        readUsert();
      });
    } catch (ex) {
      print('Something really unknown: $ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color(Constants.colorBlue),
          title: new Text(Constants.tituloApp)),
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(children: [
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
          controller: _controllerServer,
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
          controller: _controllerPort,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'Puerto', prefixIcon: Icons.settings_input_composite),
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
          controller: _controller,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'Usuario', prefixIcon: Icons.account_circle),
          onChanged: (valorUser) {
            setState(() {
              user = valorUser;
            });
          },
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buttonWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          disabledColor: Colors.amber[400],
          elevation: 0,
          color: Color(Constants.colorOrange),
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
          child: Text(
            'Aceptar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => {setConfig(context)}),
    );
  }

  //lectura del usuario almacanado en secure storge y colocado el valor en el text del usuario este es que se deberia mostrar en la pantalla
  void readUsert() async {
    setState(() {
      _controller.text = user;
      _controllerServer.text = urlServer;
      _controllerPort.text = portServer;
    });
  }

  void setConfig(BuildContext context) {
    String sever = '';
    String port = '';
    String use = '';
    String mensaje = '';
    if (urlServer == '' && Config.urlServer != '') {
      sever = Config.urlServer;
    } else if (urlServer != '') {
      sever = urlServer;
    } else {
      mensaje = 'Ingrese la dirección del servidor';
    }
    if (portServer == '' && Config.portServer != '') {
      port = Config.portServer;
    } else if (portServer != '') {
      port = portServer;
    } else {
      mensaje = 'Ingrese el puerto';
    }
    if (user == '' && Config.user != '') {
      use = Config.user;
    } else if (user != '') {
      use = user;
    } else {
      mensaje = 'Ingrese usuario';
    }

    if (mensaje == '') {
      validURL = Uri.parse(sever).isAbsolute;
      if (validURL) {
        //Config.configura(sever,port,use).then((_) {});
        String cadena = sever + '@' + port + '@' + user;
        widget.storage.writeCounter(cadena);
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    CheckAuthScreen(storage: CounterStorage()),
                transitionDuration: Duration(seconds: 0)));
      } else {
        NotificationsService.showSnackBar('La dirección URL no es válida');
      }
    } else {
      NotificationsService.showSnackBar(mensaje);
    }
  }
}
