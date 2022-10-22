// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchEstadoDocumentoResponse {
    SearchEstadoDocumentoResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<EstadoDocumento> results;
    int totalPages;
    int totalResults;

    factory SearchEstadoDocumentoResponse.fromJson(String str) => SearchEstadoDocumentoResponse.fromMap(json.decode(str));

    factory SearchEstadoDocumentoResponse.fromMap(Map<String, dynamic> json) => SearchEstadoDocumentoResponse(
        page: json["page"],
        results: List<EstadoDocumento>.from(json["results"].map((x) => EstadoDocumento.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
