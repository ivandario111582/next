// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchBodegaResponse {
    SearchBodegaResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Bodega> results;
    int totalPages;
    int totalResults;

    factory SearchBodegaResponse.fromJson(String str) => SearchBodegaResponse.fromMap(json.decode(str));

    factory SearchBodegaResponse.fromMap(Map<String, dynamic> json) => SearchBodegaResponse(
        page: json["page"],
        results: List<Bodega>.from(json["results"].map((x) => Bodega.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
