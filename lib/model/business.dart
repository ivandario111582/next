
import 'dart:convert';
class Business {
    Business({
        required this.codigo,
        required this.nombre,
    });

    int ? codigo;
    String ? nombre;
    
    factory Business.fromJson(String str) => Business.fromMap(json.decode(str));

    factory Business.fromMap(Map<String, dynamic> json) => Business(
        codigo  : json["codigo"],
        nombre  : json["nombre"],
        
    );
      @override
  String toString() {
    return '$codigo'+'---'+'$nombre';
  }
}
