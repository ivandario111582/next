// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchBusinessResponse {
    SearchBusinessResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Business> results;
    int totalPages;
    int totalResults;

    factory SearchBusinessResponse.fromJson(String str) => SearchBusinessResponse.fromMap(json.decode(str));

    factory SearchBusinessResponse.fromMap(Map<String, dynamic> json) => SearchBusinessResponse(
        page: json["page"],
        results: List<Business>.from(json["results"].map((x) => Business.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
