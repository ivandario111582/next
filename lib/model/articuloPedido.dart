
import 'dart:convert';

class ArticuloPedido {
    ArticuloPedido({
        required this.codigo,
        required this.descripcion,
        required this.unidad,
        required this.precio,
        required this.precEdit,
        required this.precDecim,
        required this.descmaximo,
        required this.saldo,
        required this.resPedidos,
        required this.resProducc,
        required this.prodCan,
        required this.iva,
        required this.vendeSinSld,
        required this.disponible,
        required this.prodFisi,
        this.subTotal,
        this.estado,
        this.mensaje,
        this.descuentoItem
    });

    String ? codigo;
    String ? descripcion;
    String ? unidad;
    double ? precio=0;
    String ? precEdit;
    double ? precDecim=0;
    double ? descmaximo=0;
    double ? saldo=0;
    double ? resPedidos=0;
    double ? resProducc=0;
    int ? prodCan=0;
    String ? iva;
    String ? vendeSinSld;
    double ? subTotal=0;
    int    ? estado=1;
    String ? mensaje;
    double ? disponible=0;
    double ? descuentoItem=0;
    int    ? prodFisi=0;
    factory ArticuloPedido.fromJson(String str) => ArticuloPedido.fromMap(json.decode(str));

    factory ArticuloPedido.fromMap(Map<String, dynamic> json) => ArticuloPedido(
        codigo        : json["codigo"],
        descripcion   : json["descripcion"],
        unidad        : json["unidad"],
        precio        : json["precio"].toDouble(),
        precEdit      : json["precEdit"],
        precDecim     : json["precDecim"].toDouble(),
        descmaximo    : json["descmaximo"].toDouble(),
        saldo         : json["saldo"].toDouble(),
        resPedidos    : json["resPedidos"].toDouble(),
        resProducc    : json["resProducc"].toDouble(),
        prodCan       : 1,//json["prod_Can"].toDouble(),
        iva           : json["iva"],
        vendeSinSld   : json["vendeSinSld"],
        subTotal      : json["precio"].toDouble(),
        mensaje       : '',
        disponible    : json["disponible"].toDouble(),
        descuentoItem : 0,
        prodFisi     : json["prod_Fisi"]
    );
}
