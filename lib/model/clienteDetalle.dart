import 'dart:convert';

class ClienteDetalles {
  List<ClienteDetalle> items = [];

  ClienteDetalles();

  ClienteDetalles.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final clienteDetalle = new ClienteDetalle.fromMap(item);
      items.add(clienteDetalle);
    }
  }
}

class ClienteDetalle {
  ClienteDetalle({
    required this.codigo,
    required this.documento,
    required this.emision,
    required this.vence,
    required this.valor,
  });

  String? codigo;
  String? documento;
  String? emision;
  String? vence = '';
  double? valor = 0;

  factory ClienteDetalle.fromJson(String str) =>
      ClienteDetalle.fromMap(json.decode(str));

  factory ClienteDetalle.fromMap(Map<String, dynamic> json) => ClienteDetalle(
        codigo: json["codigo"],
        documento: json["documento"],
        emision: json["emision"],
        vence: json["vence"],
        valor: json["valor"].toDouble(),
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
        '$valor';
  }
}
