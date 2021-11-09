import 'dart:convert';

class ClienteDetalle {
  ClienteDetalle({
    required this.codigo,
    required this.documento,
    required this.emision,
    required this.vence,
    required this.valor,
    required this.postFechados,
  });

  String? codigo;
  String? documento;
  String? emision;
  String? vence = '';
  double? valor = 0;
  double? postFechados = 0;

  factory ClienteDetalle.fromJson(String str) =>
      ClienteDetalle.fromMap(json.decode(str));

  factory ClienteDetalle.fromMap(Map<String, dynamic> json) => ClienteDetalle(
        codigo      : json["codigo"],
        documento   : json["documento"],
        emision     : json["emision"],
        vence       : json["vence"],
        valor       : json["valor"].toDouble(),
        postFechados: json["postFechados"].toDouble(),
      );

  @override
  String toString() {
    return '$codigo' +
        '-' +
        '$documento' +
        '-' +
        '$emision' +
        '-' +
        '$vence' +
        '-' +
        '$valor' +
        '-' +
        '$postFechados';
  }
}
