
import 'dart:convert';

/// Clase para cargar el combo de tipo de documentos
 
class Bodega {

    Bodega({
        required this.codAlm,
        required this.nomAlm,
        required this.direccionAlm,
        required this.tipoAlm,
        required this.impresionAlm,
        required this.encargadoAlm,
        required this.emailAlm,
    });

    String ? codAlm;
    String ? nomAlm;
    String ? direccionAlm;
    String ? tipoAlm;
    String ? impresionAlm;
    String ? encargadoAlm;
    String ? emailAlm;
    
    factory Bodega.fromJson(String str) => Bodega.fromMap(json.decode(str));

    factory Bodega.fromMap(Map<String, dynamic> json) => Bodega(
        codAlm        : json["codAlm"],
        nomAlm        : json["nomAlm"],
        direccionAlm  : json["direccionAlm"],
        tipoAlm       : json["tipoAlm"],
        impresionAlm  : json["impresionAlm"],
        encargadoAlm  : json["encargadoAlm"],
        emailAlm      : json["emailAlm"],
    );

}
