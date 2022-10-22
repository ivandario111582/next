// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:next_project/model/models.dart';

class SearchArticuloPedidoResponse {
    SearchArticuloPedidoResponse({
        required this.page,
        required this.results,
        required this.totalResults,
    });

    int page;
    List<ArticuloPedido> results;
    int totalResults;

    factory SearchArticuloPedidoResponse.fromJson(String str) => SearchArticuloPedidoResponse.fromMap(json.decode(str));

    factory SearchArticuloPedidoResponse.fromMap(Map<String, dynamic> json) => SearchArticuloPedidoResponse(
        page: json["page"],
        results: List<ArticuloPedido>.from(json["results"].map((x) => ArticuloPedido.fromMap(x))),
        totalResults: json["total_results"],
    );

}
