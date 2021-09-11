import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:next_project/services/UrlServices.dart';
import 'package:next_project/utils/utils.dart';

class AuthService extends ChangeNotifier {
  //final String _baseUrl = UrlServices.urlLogin;
  bool validURL=false;
  final storage = new FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    // Read value 
    print(email);
    String  urlServer = await storage.read(key: 'url') ?? '';
    String urlWebservive = urlServer   + UrlServices.urlLogin + email + "&clave=" + password;
    validURL = Uri.parse(urlWebservive).isAbsolute;

    if(!validURL){
      return 'Ingrese la dirección del servidor';
    }
    final resp = await http.get(
      Uri.parse(urlWebservive),
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
        //almacenado para controlar secure storage
        await storage.write(key: 'token', value: decodeResp['token']);
        await storage.write(key: 'name', value: decodeResp['name']);
        await storage.write(key: 'direcc', value: decodeResp['direcc']);
        await storage.write(key: 'tele', value: decodeResp['tele']);
        //almaceno en shared preferences
        User.login(decodeResp['name'], decodeResp['direcc'], decodeResp['tele'])
            .then((_) {});
        //TODO: aui se deberia almacenar el user id para las consultas
        return null;
      } else {
        return 'Usuario o contraseña no Validos';
      }
    }catch(e){
      return 'El sitio ingresado en configuración no es correcto';
    }


  }

  // para cerrar aplicación
  Future logout() async {
    await storage.delete(key: 'token');
  }

  //para comprobar si el tocket existe
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
