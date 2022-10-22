// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchDocumentoEstadoResponse {
    SearchDocumentoEstadoResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<DocumentoEstado> results;
    int totalPages;
    int totalResults;

    factory SearchDocumentoEstadoResponse.fromJson(String str) => SearchDocumentoEstadoResponse.fromMap(json.decode(str));

    factory SearchDocumentoEstadoResponse.fromMap(Map<String, dynamic> json) => SearchDocumentoEstadoResponse(
        page: json["page"],
        results: List<DocumentoEstado>.from(json["results"].map((x) => DocumentoEstado.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
