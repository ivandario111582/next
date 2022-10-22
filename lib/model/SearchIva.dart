// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchIvaResponse {
    SearchIvaResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Iva> results;
    int totalPages;
    int totalResults;

    factory SearchIvaResponse.fromJson(String str) => SearchIvaResponse.fromMap(json.decode(str));

    factory SearchIvaResponse.fromMap(Map<String, dynamic> json) => SearchIvaResponse(
        page: json["page"],
        results: List<Iva>.from(json["results"].map((x) => Iva.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
