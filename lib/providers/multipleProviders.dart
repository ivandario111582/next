import 'package:flutter/material.dart';
class MultipleProviders extends ChangeNotifier {
  String _empresa  ='';
  String _direccion='';
  String _telefono ='';
  String _tocken   ='';
  String _idEmpresa   ='';
  String _urlServer   ='';
  String get empresa{
    return this._empresa;
  }
  String get direccion{
    return this._direccion;
  }
  String get telefono{
    return this._telefono;
  }
  String get tocken{
    return this._tocken;
  }
  String get idEmpresa{
    return this._idEmpresa;
  }
  String get urlServer{
    return this._urlServer;
  }
  set empresa(String empresa){
    this._empresa=empresa;
    notifyListeners();
  }
    set direccion(String direccion){
    this._direccion=direccion;
    notifyListeners();
  }
    set telefono(String telefono){
    this._telefono=telefono;
    notifyListeners();
  }
    set tocken(String tocken){
    this._tocken=tocken;
    notifyListeners();
  }
    set idEmpresa(String idEmpresa){
    this._idEmpresa=idEmpresa;
    notifyListeners();
  }
    set urlServer(String urlServer){
    this._urlServer=urlServer;
    notifyListeners();
  }
}