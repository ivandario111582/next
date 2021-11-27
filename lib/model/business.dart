class BusinessS {
  List<Business> items = [];
  BusinessS();
  BusinessS.fromJsonList(List<dynamic> jsonList) {
    //if (jsonList == null) return;

    for (var item in jsonList) {
      final church = new Business.fromJsonMap(item);
      items.add(church);
    }
  }
}

class Business {
  String ? codigo;
  String ? nombre;
  Business({
    this.codigo,
    this.nombre,
  });
  Business.fromJsonMap(Map<String, dynamic> json) {
    codigo = json['codigo'];
    nombre = json['nombre'];
  }
}
