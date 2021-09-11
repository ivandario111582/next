
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:next_project/helpers/debouncer.dart';

import 'package:next_project/model/models.dart';


class ArticlesProvider extends ChangeNotifier {

  String _apiKey   = '1865f43a0549ca50d341dd9ab8b29f49';
  String _baseUrl  = 'api.themoviedb.org';
  String _language = 'es-ES';

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 500 ),
  );

  final StreamController<List<Articulo>> _suggestionStreamContoller = new StreamController.broadcast();
  Stream<List<Articulo>> get suggestionStream => this._suggestionStreamContoller.stream;
  void disposeStreams() {
    _suggestionStreamContoller.close();
  }
  Future<List<Articulo>> searchMovies( String query ) async {
    final url = Uri.https( _baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });
    final response = await http.get(url);
    final searchResponse = SearchArticuloResponse.fromJson( response.body );
    return searchResponse.results;
  }

  void getSuggestionsByQuery( String searchTerm ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final results = await this.searchMovies(value);
      this._suggestionStreamContoller.add( results );
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration( milliseconds: 301)).then(( _ ) => timer.cancel());
  }


}