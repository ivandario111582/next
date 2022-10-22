
import 'dart:convert';

/// Clase para cargar el combo de tipo de documentos
 
class Iva {

    Iva({
        required this.prioridad,
        required this.porcentaje,
        required this.codigoPorcentaje,
        required this.predeterminado,
        required this.utilizaVentas,
        required this.utilizaCompras,
        });

    String ? prioridad;
    String ? porcentaje;
    String ? codigoPorcentaje;
    String ? predeterminado;
    String ? utilizaVentas;
    String ? utilizaCompras;

    factory Iva.fromJson(String str) => Iva.fromMap(json.decode(str));

    factory Iva.fromMap(Map<String, dynamic> json) => Iva(
        prioridad         : json["Prioridad"].toString(),
        porcentaje        : json["Porcentaje"].toString(),
        codigoPorcentaje  : json["CodigoPorcentaje"].toString(),
        predeterminado    : json["Predeterminado"].toString(),
        utilizaVentas     : json["UtilizaVentas"].toString(),
        utilizaCompras    : json["UtilizaCompras"].toString(),
    );

}
