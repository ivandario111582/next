// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchAuthorizationResponse {
    SearchAuthorizationResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<AuthorizationResponse> results;
    int totalPages;
    int totalResults;

    factory SearchAuthorizationResponse.fromJson(String str) => SearchAuthorizationResponse.fromMap(json.decode(str));

    factory SearchAuthorizationResponse.fromMap(Map<String, dynamic> json) => SearchAuthorizationResponse(
        page: json["page"],
        results: List<AuthorizationResponse>.from(json["results"].map((x) => AuthorizationResponse.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
