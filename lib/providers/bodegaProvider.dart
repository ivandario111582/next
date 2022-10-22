import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:provider/provider.dart';

class BodegaProvider extends ChangeNotifier {
  Future<List<Bodega>> getListBodega(BuildContext context,String tipoDoc) async {
    try {
      final organization =
          Provider.of<MultipleProviders>(context, listen: false);
      var server = organization.urlServer +
          UrlServices.urlbodegas +
          organization.idEmpresa +
          '/VEN02/'+tipoDoc+'/VEN';
      final url = Uri.parse(server);
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken
      });
      final resp = SearchBodegaResponse.fromJson(response.body);
      return resp.results.toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
