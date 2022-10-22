
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_project/helpers/debouncer.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
//import 'package:next_project/utils/utils.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:provider/provider.dart';

class ArticlesProvider extends ChangeNotifier {


  final debouncer = Debouncer(
    duration: Duration( milliseconds: 500 ),
  );

  final StreamController<List<Articulo>> _suggestionStreamContoller = new StreamController.broadcast();
  Stream<List<Articulo>> get suggestionStream => this._suggestionStreamContoller.stream;
  void disposeStreams() {
    _suggestionStreamContoller.close();
  }
  Future<List<Articulo>> searchMovies( String query,BuildContext context) async {
    final organization = Provider.of<MultipleProviders>(context,listen: false);
    var server =
        organization.urlServer + UrlServices.urlArticulos + organization.idEmpresa + '/' + query;
    final url = Uri.parse(server);
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken});
    final searchResponse = SearchArticuloResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery( String searchTerm, BuildContext context ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final results = await this.searchMovies(value,context);
      this._suggestionStreamContoller.add( results );
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration( milliseconds: 301)).then(( _ ) => timer.cancel());
  }
  Future<List<ArticuloDetalle>> searchDetail(String query,BuildContext context ) async {
    final organization = Provider.of<MultipleProviders>(context,listen: false);
    var server = organization.urlServer +
        UrlServices.urlArticulosDetalle +
        organization.idEmpresa +
        '/' +
        query;
    final url = Uri.parse(server);
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken});
    final resp = SearchArticuloDetailResponse.fromJson(response.body);
        return resp.results.toList();
  }
  Future<List<Articulo>> searchArticle( String query,BuildContext context) async {
    try{
      final organization = Provider.of<MultipleProviders>(context,listen: false);
      var server =
          organization.urlServer + UrlServices.urlArticulos + organization.idEmpresa + '/' + query;
      final url = Uri.parse(server);
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken});
      final searchResponse = SearchArticuloResponse.fromJson(response.body);
      print(response.body.toString());
      return searchResponse.results.toList();
    }catch(e){
      print(e.toString());
      return[];
    }
  }
}