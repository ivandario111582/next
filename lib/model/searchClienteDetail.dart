// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchClienteDetailResponse {
    SearchClienteDetailResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<ClienteDetalle> results;
    int totalPages;
    int totalResults;

    factory SearchClienteDetailResponse.fromJson(String str) => SearchClienteDetailResponse.fromMap(json.decode(str));

    factory SearchClienteDetailResponse.fromMap(Map<String, dynamic> json) => SearchClienteDetailResponse(
        page: json["page"],
        results: List<ClienteDetalle>.from(json["results"].map((x) => ClienteDetalle.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
