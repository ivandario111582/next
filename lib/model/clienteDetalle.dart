
import 'dart:convert';

class ClienteDetalle {
    ClienteDetalle({
        required this.codigo,
        required this.emision,
        required this.vence,
        required this.valor,
    });

    String ? codigo;
    String ? emision;
    String ? vence='';
    double ? valor=0;

    factory ClienteDetalle.fromJson(String str) => ClienteDetalle.fromMap(json.decode(str));

    factory ClienteDetalle.fromMap(Map<String, dynamic> json) => ClienteDetalle(
        codigo    : json["backdrop_path"],
        emision   : json["title"],
        vence     : json["title"],
        valor     : json["popularity"].toDouble(),
    );
      @override
  String toString() {
    return '$codigo'+'-'+'$emision'+'-'+'$vence'+'-'+'$valor' ;
  }
}

