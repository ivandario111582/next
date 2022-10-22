
import 'dart:convert';

/// Clase para cargar el combo de tipo de documentos
 
class TipoDocumento {
    TipoDocumento({
        required this.codDocumento,
        required this.nomDocumento,
    });

    String ? codDocumento;
    String ? nomDocumento;
    
    factory TipoDocumento.fromJson(String str) => TipoDocumento.fromMap(json.decode(str));

    factory TipoDocumento.fromMap(Map<String, dynamic> json) => TipoDocumento(
        codDocumento  : json["codDocumento"],
        nomDocumento  : json["nomDocumento"],
        
    );
  /*    @override
  String toString() {
    return '$codDocumento'+'---'+'$nomDocumento' ;
  }*/
}
