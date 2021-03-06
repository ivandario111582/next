import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  Future<List<Order>> getListOrders(BuildContext context) async {
    try {
      final organization =
          Provider.of<MultipleProviders>(context, listen: false);
      var server = organization.urlServer +
          UrlServices.urlOrder +
          organization.idEmpresa;
      final url = Uri.parse(server);
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken
      });
      final resp = SearchOrderResponse.fromJson(response.body);
      return resp.results.toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<String> approveOrder(
      BuildContext context, String comentario, String numeroPedido) async {
    String respuesta = '';
    try {
      final organization =
          Provider.of<MultipleProviders>(context, listen: false);
      var server = organization.urlServer +
          UrlServices.urlAutorizar +
          organization.idEmpresa +
          '/' +
          numeroPedido +
          '/' +
          organization.codUsu +
          '/' +
          comentario;
      final url = Uri.parse(server);
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken
      });
      final resp = SearchAuthorizationResponse.fromJson(response.body);
      String success= resp.results[0].success.toString();
      return success;
    } catch (e) {
      print(e.toString());
    }
    return respuesta;
  }
}
