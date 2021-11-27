
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:provider/provider.dart';

class BusinessProvider extends ChangeNotifier {

  Future<List<Business>> getChurchHome(String church,BuildContext context) async {
    final organization = Provider.of<MultipleProviders>(context,listen: false);
    var server = organization.urlServer + UrlServices.urlEmpresas + organization.idEmpresa;
    return await _procesarRespuestaChurchHome(server,organization.tocken);
  }

  Future<List<Business>> _procesarRespuestaChurchHome(String server,String tocken) async {
    //consumo del web service
    final url = Uri.parse(server);
    final resp = await http.get(url,headers: {HttpHeaders.authorizationHeader: 'Bearer ' + tocken});
    //extraigo el contenido del web service
    final decodedData = json.decode(resp.body);
    //creo un arreglo del tipo Churches pasando a la fucion que transforma el Json a un listado tipo churches
    final churHome = new BusinessS.fromJsonList(decodedData);
    //retorna el listado del iglesias
    return churHome.items;
    //return [];
  }

}