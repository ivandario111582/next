
import 'dart:convert';
class DocumentoEstado {
    DocumentoEstado({
        required this.idDocumento,
        required this.fecDocumento,
        required this.codDocumento,
        required this.nomDocumento,
        required this.codVendedor,
        required this.nomVendedor,
        required this.codBodega,
        required this.nomBodega,
        required this.codCliente,
        required this.razonSocial,
        required this.direccion,
        required this.estado,
        required this.totalDocumento,
    });
    String ? idDocumento;
    String ? fecDocumento;
    String ? codDocumento;
    String ? nomDocumento;
    String ? codVendedor;
    String ? nomVendedor;
    String ? codBodega;
    String ? nomBodega;
    String ? codCliente;
    String ? razonSocial;
    String ? direccion;
    String ? estado;
    String ? totalDocumento;
    factory DocumentoEstado.fromJson(String str) => DocumentoEstado.fromMap(json.decode(str));
    factory DocumentoEstado.fromMap(Map<String, dynamic> json) => DocumentoEstado(
        idDocumento     : json["IdDocumento"].toString(),
        fecDocumento    : json["FecDocumento"],
        codDocumento    : json["CodDocumento"],
        nomDocumento    : json["NomDocumento"],
        codVendedor     : json["CodVendedor"],
        nomVendedor     : json["NomVendedor"],
        codBodega       : json["CodBodega"],
        nomBodega       : json["NomBodega"],
        codCliente      : json["CodCliente"],
        razonSocial     : json["RazonSocial"],
        direccion       : json["Direccion"],
        estado          : json["Estado"],
        totalDocumento  : json["TotalDocumento"].toString(),
    );
}
