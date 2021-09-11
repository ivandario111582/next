import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'package:next_project/providers/login_form_provider.dart';
import 'package:next_project/services/services.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/ui/input_decorations.dart';
import 'package:next_project/widgets/widgets.dart';

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
            title: new Text("Next ERP")),
        body: AuthBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 250),
                  Column(
                    children: [
                      SizedBox(height: 30),
                      ChangeNotifierProvider(
                          create: (_) => LoginFormProvider(), child: LoginForm())
                    ],
                  )
                ],
              ),
            )
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(Constants.colorBlue),
          child: Icon(Icons.settings),
          onPressed:() {
            Navigator.pushNamed(context, 'configForm');
          },
        )
        );
  }


}

//class _LoginForm extends StatelessWidget   {
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final storage = new FlutterSecureStorage();
  TextEditingController _controller = new TextEditingController();
  String user='';
  @override
  void initState() { 
    super.initState();
    readUsert();
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
                color:Constants.whitOpacity,
                borderRadius: BorderRadius.circular(30)
              ),
              child:

            TextFormField(
              readOnly: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'usuario',
                   prefixIcon: Icons.account_circle
                  ),
              //initialValue: user,
              controller: _controller,
              onChanged: (value) => loginForm.email = value,
              style: TextStyle(color: Colors.white),
            )
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color:Constants.whitOpacity,
                borderRadius: BorderRadius.circular(30)
              ),
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
                          FocusScope.of(context).unfocus();
                          final authService =
                              Provider.of<AuthService>(context, listen: false);
                          if (!loginForm.isValidForm()) return;
                          loginForm.isLoading = true;
                          loginForm.email=_controller.text;
                          final String? errorMessage = await authService.login(
                              loginForm.email, loginForm.password);
                          if (errorMessage == null) {
                            Navigator.pushReplacementNamed(context, 'home');
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
  void readUsert() async {
    String userLocal=await storage.read(key: 'user') ?? '';
    setState(() {
       _controller.text = userLocal;
    });
  }

}
