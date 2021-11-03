
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
        codigo  : json["codigo"],
        descripcion  : json["descripcion"],
        total   : json["total"].toDouble(),
    );
      @override
  String toString() {
    return '$codigo'+'-'+'$descripcion'+'-'+'$total' ;
  }
}
