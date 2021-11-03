// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchArticuloResponse {
    SearchArticuloResponse({
        required this.page,
        required this.results,
        required this.totalResults,
    });

    int page;
    List<Articulo> results;
    int totalResults;

    factory SearchArticuloResponse.fromJson(String str) => SearchArticuloResponse.fromMap(json.decode(str));

    factory SearchArticuloResponse.fromMap(Map<String, dynamic> json) => SearchArticuloResponse(
        page: json["page"],
        results: List<Articulo>.from(json["results"].map((x) => Articulo.fromMap(x))),
            totalResults: json["total_results"],
    );

}
