
import 'dart:convert';

class EstadoDocumento {
    EstadoDocumento({
        required this.codEstado,
        required this.nomEstado,
    });

    String ? codEstado;
    String ? nomEstado;
    
    factory EstadoDocumento.fromJson(String str) => EstadoDocumento.fromMap(json.decode(str));

    factory EstadoDocumento.fromMap(Map<String, dynamic> json) => EstadoDocumento(
        codEstado  : json["codEstado"],
        nomEstado  : json["nomEstado"],
        
    );
      @override
  String toString() {
    return '$codEstado'+'---'+'$nomEstado' ;
  }
}
