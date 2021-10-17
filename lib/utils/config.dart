
import 'utility.dart';

class Config {

  static String urlServer='';
  static String portServer='';
  static String user='';
  static Future<Null> setInfoFromLocalStorage() async {
    urlServer   = await Utility.getLocalStorage('urlServer');
    portServer  = await Utility.getLocalStorage('portServer');
    user        = await Utility.getLocalStorage('user');
  }
  static Future<Null> configura(urlServer, portServer,user ) async {
    await Utility.setLocalStorage('urlServer', urlServer);
    await Utility.setLocalStorage('portServer', portServer);
    await Utility.setLocalStorage('user', user);
    Config.urlServer  = urlServer;
    Config.portServer = portServer;
    Config.user       = user;
  }

  static Future<Null> logout() async {
    urlServer   = '';
    portServer  = '';
    user  = '';
    await Utility.setLocalStorage('urlServer', '');
    await Utility.setLocalStorage('portServer', '');
    await Utility.setLocalStorage('user', '');
  }
}
