

import 'utility.dart';

class User {
  
  static String userName='';
  static String direcc='';
  static String tele='';
  static String token='';
  static Future<void> setInfoFromLocalStorage() async {
    //final storage = new FlutterSecureStorage();
    userName  = await Utility.getLocalStorage('userName');
    direcc    = await Utility.getLocalStorage('direcc');
    tele      = await Utility.getLocalStorage('tele');
    token      = await Utility.getLocalStorage('token');

  }
  static Future<Null> login(userName, direcc, tele,token ) async {
    await Utility.setLocalStorage('userName', userName);
    await Utility.setLocalStorage('direcc', direcc);
    await Utility.setLocalStorage('tele', tele);
    await Utility.setLocalStorage('token', token);
    User.userName = userName;
    User.direcc   = direcc;
    User.tele     = tele;
    User.token    = token;
  }

  static Future<Null> logout() async {
    userName  = '';
    direcc    = '';
    tele      = '';
    token     ='';
    await Utility.setLocalStorage('userName', '');
    await Utility.setLocalStorage('direcc', '');
    await Utility.setLocalStorage('tele', '');
    await Utility.setLocalStorage('token', '');
  }


}
