import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:next_project/providers/login_form_provider.dart';
import 'package:next_project/services/services.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/ui/input_decorations.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/screens/screens.dart';

//class LoginScreen extends StatelessWidget {
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            elevation: 0.1,
            backgroundColor: Color(Constants.colorBlue),
            title: new Text(Constants.tituloApp)),
        body: AuthBackground(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              Column(
                children: [
                  SizedBox(height: 30),
                  ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(), child: LoginForm(storage: CounterStorage()))
                ],
              )
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(Constants.colorBlue),
          child: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        ConfigScreen(storage: CounterStorage()),
                    transitionDuration: Duration(seconds: 0)));
          },
        ));
  }
}

class LoginForm extends StatefulWidget {
  final CounterStorage storage;
  LoginForm({Key? key, required this.storage}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _dataDisp = '';
  String counter = '0';
  String urlServer = '';
  String portServer = '';
  String tocken='';
  TextEditingController _controller = new TextEditingController();
  String user = '';
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
            urlServer = arrayData[0]+':'+arrayData[1];
            user = arrayData[2];
          });
        }
        //llama a la funcion que verifica el estado de usuario y la versión de la app
          readUsert(user);
      });
    } catch (ex) {
      print('Something really unknown: $ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Constants.whitOpacity,
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  readOnly: true,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'usuario', prefixIcon: Icons.account_circle),
                  //initialValue: user,
                  controller: _controller,
                  onChanged: (value) => loginForm.email = value,
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  color: Constants.whitOpacity,
                  borderRadius: BorderRadius.circular(30)),
              child: TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Contraseña', prefixIcon: Icons.lock_outline),
                onChanged: (value) => loginForm.password = value,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  disabledColor: Colors.amber[400],
                  elevation: 0,
                  color: Color(Constants.colorOrange),
                  //child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  // padding: EdgeInsets.all(24.0),
                  child: Text(
                    loginForm.isLoading ? 'Verificando Usuario' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                  ),
                  //),
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          //String userLocal =(Config.user != '') ? Config.user : '';
                          FocusScope.of(context).unfocus();
                          final authService =
                              Provider.of<AuthService>(context, listen: false);
                          if (!loginForm.isValidForm()) return;
                          loginForm.isLoading = true;
                          loginForm.email = _controller.text;
                          final String errorMessage = await authService.login(
                                  user, loginForm.password,urlServer) ??
                              '';
                          String mensaje='';
                          var arrayData = errorMessage.split('*');
                          tocken = User.token;
                          setState(() {
                            mensaje = arrayData[0];
                            tocken = User.token;
                          });
                          if (mensaje == 'ok') {
                          setState(() {
                            tocken = User.token;
                          });
                            //print('deberia ingresar');
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        CheckAuthScreen(
                                            storage: CounterStorage()),
                                    transitionDuration: Duration(seconds: 0)));
                          } else {
                            NotificationsService.showSnackBar(errorMessage);
                            loginForm.isLoading = false;
                          }
                        }),
            )
          ],
        ),
      ),
    );
  }

  //lectura del usuario almacanado en secure storge y colocado el valor en el text del usuario este es que se deberia mostrar en la pantalla
  void readUsert(String userLocal) async {
    setState(() {
      _controller.text = userLocal;
    });
  }
}
