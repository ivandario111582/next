// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchTipoDocumentoResponse {
    SearchTipoDocumentoResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<TipoDocumento> results;
    int totalPages;
    int totalResults;

    factory SearchTipoDocumentoResponse.fromJson(String str) => SearchTipoDocumentoResponse.fromMap(json.decode(str));

    factory SearchTipoDocumentoResponse.fromMap(Map<String, dynamic> json) => SearchTipoDocumentoResponse(
        page: json["page"],
        results: List<TipoDocumento>.from(json["results"].map((x) => TipoDocumento.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
