class MenuModel {
  String ? nombreMenu;
  String ? form;
  String ? icono;
  int? ordenMenu;
  
 
  MenuModel({this.nombreMenu,  this.icono, this.form , this.ordenMenu});
 
  // Return object from JSON //
  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
        nombreMenu: json['nombreMenu'] as String,
        form      : json['url'] as String,
        icono     : json['icono'] as String,
        ordenMenu : json['ordenMenu'] as int
    );
  }
}



