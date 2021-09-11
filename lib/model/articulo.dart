
import 'dart:convert';

class Articulo {
    Articulo({
        required this.codigo,
        required this.descripcion,
        required this.total,

    });

    String ? codigo;
    String ? descripcion;
    double ? total=0;

    factory Articulo.fromJson(String str) => Articulo.fromMap(json.decode(str));

    factory Articulo.fromMap(Map<String, dynamic> json) => Articulo(
        codigo  : json["backdrop_path"],
        descripcion  : json["title"],
        total   : json["popularity"].toDouble(),
    );
      @override
  String toString() {
    return '$codigo'+'-'+'$descripcion'+'-'+'$total' ;
  }
}

/** para revisar json */
/*
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.codigo,
        this.descripcion,
        this.total,
        this.resultado,
    });

    String codigo;
    String descripcion;
    String total;
    List<Resultado> resultado;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        total: json["total"],
        resultado: List<Resultado>.from(json["resultado"].map((x) => Resultado.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "total": total,
        "resultado": List<dynamic>.from(resultado.map((x) => x.toJson())),
    };
}

class Resultado {
    Resultado({
        this.bodega,
        this.cantidad,
    });

    String bodega;
    int cantidad;

    factory Resultado.fromJson(Map<String, dynamic> json) => Resultado(
        bodega: json["bodega"],
        cantidad: json["cantidad"],
    );

    Map<String, dynamic> toJson() => {
        "bodega": bodega,
        "cantidad": cantidad,
    };
}

*/