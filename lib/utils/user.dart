
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'utility.dart';

class User {
  final storage = new FlutterSecureStorage();
  static String userName='';
  static String direcc='';
  static String tele='';
  static Future<Null> setInfoFromLocalStorage() async {
    final storage = new FlutterSecureStorage();
    /*userName  = await Utility.getLocalStorage('userName');
    direcc    = await Utility.getLocalStorage('direcc');
    tele      = await Utility.getLocalStorage('tele');
    */
    userName  =await storage.read(key: 'name') ?? '';
    direcc    =await storage.read(key: 'direcc') ?? '';
    tele      =await storage.read(key: 'tele') ?? '';
  }
  static Future<Null> login(userName, direcc, tele ) async {
    await Utility.setLocalStorage('userName', userName);
    await Utility.setLocalStorage('direcc', direcc);
    await Utility.setLocalStorage('tele', tele);
    User.userName = userName;
    User.direcc = direcc;
    User.tele = tele;
  }

  static Future<Null> logout() async {
    /*userName = '';
    direcc = '';
    tele = '';*/
    await Utility.setLocalStorage('userName', '');
    await Utility.setLocalStorage('direcc', '');
    await Utility.setLocalStorage('tele', '');
  }


}
