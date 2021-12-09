import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:next_project/services/UrlServices.dart';
import 'package:next_project/utils/utils.dart';

class AuthService extends ChangeNotifier {
    bool validURL=false;
  

  Future<String?> login(String email, String password, String urlServer) async {
    urlServer=urlServer.trim();
    String urlWebservive = urlServer + UrlServices.urlLogin;
        validURL = Uri.parse(urlWebservive).isAbsolute;

    if(!validURL){
      return 'Ingrese la dirección del servidor';
    }
      var servidor=Uri.parse(urlWebservive);
      final resp = await http.post(
      servidor,
      body:jsonEncode({"userAccount": email, "userPassword":password}),
      headers: {'Content-Type': 'application/json'},
    ).timeout(
      Duration(seconds: 30),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('Error', 2000); // Replace 500 with your http code.
      },
    );

    if(resp.body=='Error'){
      return 'El servidor ingresado no responde';
    }
    try{
      final Map<String, dynamic> decodeResp = json.decode(resp.body);
      String cadena="";
      if (decodeResp['acceso'] == true) {
        //almaceno en shared preferences
          cadena="ok*"+decodeResp['name']+"*"+decodeResp['direcc']+"*"+decodeResp['tele']+"*"+decodeResp['token']+"*"+decodeResp['id_Empresa'].toString()+"*"+urlServer;
          User.login(decodeResp['name'], decodeResp['direcc'], decodeResp['tele'],decodeResp['token'],urlServer,decodeResp['id_Empresa'].toString()).then((_) { 
        });
        return cadena;
      } else {
        return 'Usuario o contraseña no Validos';
      }
    }catch(e){
      return 'El sitio ingresado en configuración no es correcto';
    }


  }

  // para cerrar aplicación
     Future<String> readToken() async {
    return ''; // await storage.read(key: 'token') ?? '';
  }

}
