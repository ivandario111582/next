
import 'dart:convert';
class Order {
    Order({
        required this.codigo,
        required this.nombre,
        required this.cupo,
        required this.utilizado,
        required this.diferencia,
        required this.valorPedido,
        required this.numeroPedido,
        required this.nombreVendedor,
    });

    String ? codigo;
    String ? nombre;
    int ? cupo;
    double ? utilizado;
    double ? diferencia;
    double ? valorPedido;
    int ? numeroPedido;
    String ? nombreVendedor;
    
    factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

    factory Order.fromMap(Map<String, dynamic> json) => Order(
        codigo        : json["codigo"],
        nombre        : json["nombre"].trim(),
        cupo          : json["cupo"],
        utilizado     : json["utilizado"].toDouble(),
        diferencia    : json["diferencia"].toDouble(),
        valorPedido   : json["valorPedido"].toDouble(),
        numeroPedido  : json["numeroPedido"],
        nombreVendedor: json["nombreVendedor"].trim(),
    );
     /* @override
  String toString() {
    return '$codigo'+'---'+'$nombre';
  } */
}
