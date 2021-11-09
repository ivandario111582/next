import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:next_project/helpers/debouncer.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:next_project/utils/utils.dart';

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

  Future<List<Cliente>> searchMovies(String query) async {
    var server =
        User.server + UrlServices.urlClientes + User.idEmpresa + '/' + query;
    final url = Uri.parse(server);
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + User.token});
    final searchResponse = SearchClienteResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchMovies(value);
      this._suggestionStreamContoller.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  Future<List<ClienteDetalle>> searchDetail(String query) async {
    var server = User.server +
        UrlServices.urlClienteDetalle +
        User.idEmpresa +
        '/' +
        query;
    final url = Uri.parse(server);
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + User.token});
    final resp = SearchClienteDetailResponse.fromJson(response.body);
    return resp.results.toList();
  }
}
