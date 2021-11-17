import 'package:flutter/material.dart';
class MultipleProviders extends ChangeNotifier {
  String _empresa  ='';
  String _direccion='';
  String _telefono ='';
  String _tocken   ='';

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
}