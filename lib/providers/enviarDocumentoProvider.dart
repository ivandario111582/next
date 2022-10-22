import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_project/providers/providers.dart';
import 'dart:convert';
import 'package:next_project/services/UrlServices.dart';
import 'package:provider/provider.dart';

class EnviarDocumentoProvider extends ChangeNotifier {
  Future<String?> sendDocument(
      BuildContext context, Map<String, dynamic> document) async {
        
    try {
      final organization =
          Provider.of<MultipleProviders>(context, listen: false);
      var server = organization.urlServer +
          UrlServices.urlEnviarPedido +
          organization.idEmpresa;
      var servidor = Uri.parse(server);

      final resp = await http.post(
        servidor,
        body: jsonEncode(document),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken
        },
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(
              'Error', 2000); // Replace 500 with your http code.
        },
      );
      final Map<String, dynamic> decodeResp = json.decode(resp.body);
      String cadena="";
      if (decodeResp['results'] == 200) {
        cadena='1';
        return cadena;
      } else {
        cadena='0';
        return cadena;
      }
    } catch (e) {
      print(e.toString());
      return 'El sitio ingresado en configuración no es correcto';
    }
    //return retorno;
  }
}
