
import 'dart:convert';
class Business {
    Business({
        required this.codigo,
        required this.nombre,
        required this.direcc,
        required this.tele,        
    });

    int ? codigo;
    String ? nombre;
    String ? direcc;
    String ? tele;
    
    factory Business.fromJson(String str) => Business.fromMap(json.decode(str));

    factory Business.fromMap(Map<String, dynamic> json) => Business(
        codigo  : json["codigo"],
        nombre  : json["nombre"],
        direcc  : json["direcc"],
        tele    : json["tele"],
    );
      @override
  String toString() {
    return '$codigo'+'---'+'$nombre';
  }
}
