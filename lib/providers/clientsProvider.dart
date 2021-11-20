import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:next_project/helpers/debouncer.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/services/UrlServices.dart';
//import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';

class ClientsProvider extends ChangeNotifier {
  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Cliente>> _suggestionStreamContoller =
      new StreamController.broadcast();
  Stream<List<Cliente>> get suggestionStream =>
      this._suggestionStreamContoller.stream;
  void disposeStreams() {
    _suggestionStreamContoller.close();
  }

  Future<List<Cliente>> searchMovies(String query,BuildContext context) async {
    final organization = Provider.of<MultipleProviders>(context,listen: false);
    var server =
        organization.urlServer + UrlServices.urlClientes + organization.idEmpresa + '/' + query;
    final url = Uri.parse(server);
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken});
    final searchResponse = SearchClienteResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm,BuildContext context) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchMovies(value,context);
      this._suggestionStreamContoller.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  Future<List<ClienteDetalle>> searchDetail(String query,BuildContext context) async {
    final organization = Provider.of<MultipleProviders>(context,listen: false);
    var server = organization.urlServer +
        UrlServices.urlClienteDetalle +
        organization.idEmpresa +
        '/' +
        query;
    final url = Uri.parse(server);
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken});
    final resp = SearchClienteDetailResponse.fromJson(response.body);
    return resp.results.toList();
  }
}
