import 'dart:convert';

class ArticuloDetalle {
  ArticuloDetalle({
    required this.codigo,
    required this.bodega,
    required this.cantidad,
  });

  String? codigo;
  String? bodega;
  double? cantidad=0;

  factory ArticuloDetalle.fromJson(String str) =>
      ArticuloDetalle.fromMap(json.decode(str));

  factory ArticuloDetalle.fromMap(Map<String, dynamic> json) => ArticuloDetalle(
        codigo: json["codigo"],
        bodega: json["bodega"],
        cantidad: json["cantidad"].toDouble()
      );

  @override
  String toString() {
    return '$codigo' +
        '-' +
        '$bodega' +
        '-' +
        '$cantidad';
  }
}
