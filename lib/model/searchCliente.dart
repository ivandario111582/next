// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchClienteResponse {
    SearchClienteResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Cliente> results;
    int totalPages;
    int totalResults;

    factory SearchClienteResponse.fromJson(String str) => SearchClienteResponse.fromMap(json.decode(str));

    factory SearchClienteResponse.fromMap(Map<String, dynamic> json) => SearchClienteResponse(
        page: json["page"],
        results: List<Cliente>.from(json["results"].map((x) => Cliente.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}
