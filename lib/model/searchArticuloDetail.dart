// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchArticuloDetailResponse {
    SearchArticuloDetailResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<ArticuloDetalle> results;
    int totalPages;
    int totalResults;

    factory SearchArticuloDetailResponse.fromJson(String str) => SearchArticuloDetailResponse.fromMap(json.decode(str));

    factory SearchArticuloDetailResponse.fromMap(Map<String, dynamic> json) => SearchArticuloDetailResponse(
        page: json["page"],
        results: List<ArticuloDetalle>.from(json["results"].map((x) => ArticuloDetalle.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
