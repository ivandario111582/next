

import 'package:flutter/cupertino.dart';
import 'package:next_project/providers/providers.dart';
import 'package:provider/provider.dart';

import 'utility.dart';

class User {
  
  static String userName='';
  static String direcc='';
  static String tele='';
  static String token='';
  static String server='';
  static String idEmpresa='';
  static Future<void> setInfoFromLocalStorage() async {
    //final storage = new FlutterSecureStorage();
    userName  = await Utility.getLocalStorage('userName');
    direcc    = await Utility.getLocalStorage('direcc');
    tele      = await Utility.getLocalStorage('tele');
    token     = await Utility.getLocalStorage('token');
    server    = await Utility.getLocalStorage('server');
    idEmpresa    = await Utility.getLocalStorage('idEmpresa');
  }
  static Future<Null> login(userName, direcc, tele,token,server,idEmpresa ) async {
    await Utility.setLocalStorage('userName', userName);
    await Utility.setLocalStorage('direcc', direcc);
    await Utility.setLocalStorage('tele', tele);
    await Utility.setLocalStorage('token', token);
    await Utility.setLocalStorage('server', server);
    await Utility.setLocalStorage('idEmpresa', idEmpresa);
    
    User.userName   = userName;
    User.direcc     = direcc;
    User.tele       = tele;
    User.token      = token;
    User.server     = server;
    User.idEmpresa  = idEmpresa;
  }

  static Future<Null> logout(BuildContext context)async {
    /*userName  = '';
    direcc    = '';
    tele      = '';
    token     = '';
    server    = '';
    idEmpresa = '';
    await Utility.setLocalStorage('userName', '');
    await Utility.setLocalStorage('direcc', '');
    await Utility.setLocalStorage('tele', '');
    await Utility.setLocalStorage('token', '');
    await Utility.setLocalStorage('server', '');
    await Utility.setLocalStorage('idEmpresa', '');*/

    final organization = Provider.of<MultipleProviders>(context,listen: false);
      organization.empresa    = '';
      organization.direccion  = '';
      organization.telefono   = '';
      organization.tocken     = '';
  }


}
