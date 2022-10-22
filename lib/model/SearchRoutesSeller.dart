// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchRoutesSellerResponse {
    SearchRoutesSellerResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<RoutesSeller> results;
    int totalPages;
    int totalResults;

    factory SearchRoutesSellerResponse.fromJson(String str) => SearchRoutesSellerResponse.fromMap(json.decode(str));

    factory SearchRoutesSellerResponse.fromMap(Map<String, dynamic> json) => SearchRoutesSellerResponse(
        page: json["page"],
        results: List<RoutesSeller>.from(json["results"].map((x) => RoutesSeller.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
