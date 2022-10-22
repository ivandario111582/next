import 'package:flutter/material.dart';

class MultipleProviders extends ChangeNotifier {
  String _empresa           = '';
  String _direccion         = '';
  String _telefono          = '';
  String _tocken            = '';
  String _idEmpresa         = '';
  String _urlServer         = '';
  String _cambiar           = '';
  String _aprobar           = '';
  String _codUsu            = '';
  String _codVdd            = '';
  String _codDocumento      = '';
  String _codAlm            = '';
  String _codCliente        = '';
  double _descTot           = 0;
  String _cambDesc          = '';
  String _btoClientes       = '';
  String _btoInventarios    = '';
  String _btoAutorizaciones = '';
  String _btoRutas          = '';
  String _btoDocumentos     = '';
  String _btoCobros         = '';
  String _btoReportes       = '';

  //varible para identificar el cliente
  String get empresa {
    return this._empresa;
  }
  String get direccion {
    return this._direccion;
  }

  String get telefono {
    return this._telefono;
  }

  String get tocken {
    return this._tocken;
  }

  String get idEmpresa {
    return this._idEmpresa;
  }

  String get urlServer {
    return this._urlServer;
  }

  String get cambiar {
    return this._cambiar;
  }

  String get aprobar {
    return this._aprobar;
  }

  String get codUsu {
    return this._codUsu;
  }

  String get codVdd {
    return this._codVdd;
  }

  String get codDocumento {
    return this._codDocumento;
  }

  String get codAlm {
    return this._codAlm;
  }
  String get codCliente {
    return this._codCliente;
  }
  double get descTot {
    return this._descTot;
  }
  String get cambDesc {
    return this._cambDesc;
  }
  String get btoClientes{
    return this._btoClientes;
  }
  String get btoInventarios{
    return this._btoInventarios;
  }
  String get btoAutorizaciones{
    return this._btoAutorizaciones;
  }
  String get btoRutas{
    return this._btoRutas;
  }
  String get btoDocumentos{
    return this._btoDocumentos;
  }
  String get btoCobros{
    return this._btoCobros;
  }
  String get btoReportes{
    return this._btoReportes;
  }
  set empresa(String empresa) {
    this._empresa = empresa;
    notifyListeners();
  }

  set descTot(double descTot) {
    this._descTot = descTot;
    notifyListeners();
  }

  set direccion(String direccion) {
    this._direccion = direccion;
    notifyListeners();
  }

  set telefono(String telefono) {
    this._telefono = telefono;
    notifyListeners();
  }

  set tocken(String tocken) {
    this._tocken = tocken;
    notifyListeners();
  }

  set idEmpresa(String idEmpresa) {
    this._idEmpresa = idEmpresa;
    notifyListeners();
  }

  set urlServer(String urlServer) {
    this._urlServer = urlServer;
    notifyListeners();
  }

  set cambiar(String cambiar) {
    this._cambiar = cambiar;
    notifyListeners();
  }

  set aprobar(String aprobar) {
    this._aprobar = aprobar;
    notifyListeners();
  }

  set codUsu(String codUsu) {
    this._codUsu = codUsu;
    notifyListeners();
  }

  set codVdd(String codVdd) {
    this._codVdd = codVdd;
    notifyListeners();
  }

  set codDocumento(String codDocumento) {
    this._codDocumento = codDocumento;
    notifyListeners();
  }

  set codAlm(String codAlm) {
    this._codAlm = codAlm;
    notifyListeners();
  }
  set  codCliente(String  codCliente) {
    this._codCliente = codCliente;
    notifyListeners();
  }
  set  cambDesc(String  cambDesc) {
    this._cambDesc = cambDesc;
    notifyListeners();
  }
  set  btoClientes(String  btoClientes){
    this._btoClientes = btoClientes;
    notifyListeners();
  }
  set  btoInventarios(String  btoInventarios){
    this._btoInventarios = btoInventarios;
    notifyListeners();
  }
  set  btoAutorizaciones(String  btoAutorizaciones) {
    this._btoAutorizaciones = btoAutorizaciones;
    notifyListeners();
  }
  set  btoRutas(String  btoRutas) {
    this._btoRutas = btoRutas;
    notifyListeners();
  }
  set  btoDocumentos(String  btoDocumentos) {
    this._btoDocumentos = btoDocumentos;
    notifyListeners();
  }
  set  btoCobros(String  btoCobros) {
    this._btoCobros = btoCobros;
    notifyListeners();
  }
  set  btoReportes(String  btoReportes) {
    this._btoReportes = btoReportes;
    notifyListeners();
  }
}
