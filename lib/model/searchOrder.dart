// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchOrderResponse {
    SearchOrderResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Order> results;
    int totalPages;
    int totalResults;

    factory SearchOrderResponse.fromJson(String str) => SearchOrderResponse.fromMap(json.decode(str));

    factory SearchOrderResponse.fromMap(Map<String, dynamic> json) => SearchOrderResponse(
        page: json["page"],
        results: List<Order>.from(json["results"].map((x) => Order.fromMap(x))),
        totalPages: 1,
        totalResults: json["total_results"],
    );

}
