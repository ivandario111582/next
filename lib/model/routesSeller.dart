
import 'dart:convert';
class RoutesSeller {
    RoutesSeller({
        required this.vendedor,
        required this.nombre,
        required this.cliente,
        required this.razonSocial,
        required this.ruc,
        required this.direccion,
        required this.telefonos,
        required this.contacto,
        required this.saldoVencido,
        required this.saldoVencer,
        required this.postFec,
        required this.cupo,
        required this.disponible,
        required this.visitado,
        required this.descuento,
        required this.cambDesc,
    });

    String ? vendedor;
    String ? nombre;
    String ? cliente;
    String ? razonSocial;
    String ? ruc;
    String ? direccion;
    String ? telefonos;
    String ? contacto;
    double ? saldoVencido=0;
    double ? saldoVencer=0;
    double ? postFec=0;
    double ? cupo=0;
    double ? disponible=0;
    String ? visitado;
    int    ? descuento;
    String ? cambDesc;
    factory RoutesSeller.fromJson(String str) => RoutesSeller.fromMap(json.decode(str));

    factory RoutesSeller.fromMap(Map<String, dynamic> json) => RoutesSeller(
      vendedor:     json["vendedor"],
      nombre:       json["nombre"],
      cliente:      json["cliente"],
      razonSocial:  json["razonSocial"],
      ruc:          json["ruc"],
      direccion:    json["direccion"],
      telefonos:    json["telefonos"],
      contacto:     json["contacto"],
      saldoVencido: json["saldoVencido"].toDouble(),
      saldoVencer:  json["saldoVencer"].toDouble(),
      postFec:      json["postFec"].toDouble(),
      cupo:         json["cupo"].toDouble(),
      disponible:   json["disponible"].toDouble(),
      visitado:     json["visitado"],
      descuento:     json["descuento"],
      cambDesc:     json["cambDesc"]
    );
    
  /*  @override
  String toString() {
    return '$codigo'+'---'+'$nombre';
  }
  */
}
