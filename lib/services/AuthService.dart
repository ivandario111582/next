import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:next_project/services/UrlServices.dart';
import 'package:next_project/utils/utils.dart';

class AuthService extends ChangeNotifier {
  //final String _baseUrl = UrlServices.urlLogin;
  bool validURL=false;
  

  Future<String?> login(String email, String password, String urlServer) async {
    urlServer=urlServer.trim();
    String urlWebservive = urlServer + UrlServices.urlLogin;
    //String urlWebservive="http://192.95.6.210:8085/api/login/login";
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
      Duration(seconds: 5),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('Error', 500); // Replace 500 with your http code.
      },
    );

    print(resp.body);
    if(resp.body=='Error'){
      return 'El servidor ingresado no responde';
    }
    try{
      final Map<String, dynamic> decodeResp = json.decode(resp.body);
      if (decodeResp['acceso'] == true) {
        String nombre= decodeResp['name'] ;
        //almaceno en shared preferences
        User.login(nombre, decodeResp['direcc'], decodeResp['tele'],decodeResp['token'])
            .then((_) {
              
            });
        //TODO: aui se deberia almacenar el user id para las consultas
        return '';
      } else {
        return 'Usuario o contraseña no Validos';
      }
    }catch(e){
      return 'El sitio ingresado en configuración no es correcto';
    }


  }

  // para cerrar aplicación
  //TODO: VEN ACA
  /*Future logout() async {
    await storage.delete(key: 'token');
  }*/
  //para comprobar si el tocket existe
  
  Future<String> readToken() async {
    return ''; // await storage.read(key: 'token') ?? '';
  }

}
