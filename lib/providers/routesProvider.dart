
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:provider/provider.dart';

class RoutesProvider extends ChangeNotifier {

  Future<List<RoutesSeller>> getListRoutes(BuildContext context ) async {
    try{
      final organization = Provider.of<MultipleProviders>(context,listen: false);
      final DateTime now = DateTime.now();
      final DateFormat formatter =DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      var server = organization.urlServer +
          UrlServices.urlRutas +
          organization.idEmpresa+'/001/T/'+formatted+'/'+formatted;
      final url = Uri.parse(server);
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken});
      final resp = SearchRoutesSellerResponse.fromJson(response.body);
      return resp.results.toList();
    }catch(e){
      print(e.toString());
      return[];
    }
  }


}