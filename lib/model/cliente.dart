
import 'dart:convert';

class Cliente {
    Cliente({
        required this.codigo,
        required this.nombre,
        required this.ruc,
        required this.saldo,
        required this.postFechados,
    });

    String ? codigo;
    String ? nombre;
    String ? ruc='';
    double ? saldo=0;
    double ? postFechados=0;

    factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

    factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        codigo  : json["codigo"],
        nombre  : json["nombre"],
        ruc     : json["ruc"],
        saldo   : json["saldo"].toDouble(),
        postFechados   : json["postFechados"].toDouble(),
    );
      @override
  String toString() {
    return '$codigo'+'-'+'$nombre'+'-'+'$ruc'+'-'+'$saldo'+'-'+'$postFechados';
  }
}

