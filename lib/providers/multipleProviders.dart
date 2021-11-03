import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:next_project/model/models.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:next_project/utils/utils.dart';



class MultipleProviders {
  
  Future<List<ClienteDetalle>> getDetalleCliente(String codigo) async {
    var server=User.server+UrlServices.urlClienteDetalle + User.idEmpresa + '/'+codigo;
    final url = Uri.parse(server);
    final response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ User.token
      });
        final searchResponse = SearchClienteDetailResponse.fromJson( response.body );
        print(searchResponse.results);
    return searchResponse.results;




  }



}