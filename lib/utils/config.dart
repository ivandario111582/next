
import 'utility.dart';

class Config {

  static String urlServer='';
  static String portServer='';
  static Future<Null> setInfoFromLocalStorage() async {
    urlServer   = await Utility.getLocalStorage('urlServer');
    portServer  = await Utility.getLocalStorage('portServer');
  }
  static Future<Null> login(urlServer, portServer ) async {
    await Utility.setLocalStorage('urlServer', urlServer);
    await Utility.setLocalStorage('portServer', portServer);
    Config.urlServer  = urlServer;
    Config.portServer = portServer;
    
  }

  static Future<Null> logout() async {
    urlServer   = '';
    portServer  = '';
    await Utility.setLocalStorage('urlServer', '');
    await Utility.setLocalStorage('portServer', '');
  }


}
