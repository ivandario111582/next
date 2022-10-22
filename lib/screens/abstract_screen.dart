import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import 'screens.dart';

class AbstractScreen extends StatefulWidget {
  final Map<String, dynamic> receivedMap;
  final Map<String, dynamic> selectedValues;
  final List<ArticuloPedido> articuloPedidos;
  AbstractScreen(
      {required this.receivedMap,
      required this.selectedValues,
      required this.articuloPedidos});
  @override
  _AbstractScreenState createState() => _AbstractScreenState();
}

class _AbstractScreenState extends State<AbstractScreen> {
  final enviarDocumentoProvider = new EnviarDocumentoProvider();

  String selectValue = '1',
      selectBodega = '1',
      selectIva = '1',
      codigo = '',
      descripcion = '',
      selectDocumento = '';
  double? total = 1,
      precio = 0,
      descuento = 0,
      subtotal = 0,
      descTotal = 0,
      sumaBaseCero = 0,
      baseCero = 0,
      baseIva = 0,
      sumaBaseIva = 0,
      valorIva = 0,
      totalDocumento = 0;
  int stock = 0;
  String? unidad = 'caja';
  double? cantiDefauld = 0.0, preciDefauld = 0.0, descuDefauld = 0.0;
  List<ArticuloPedido> articuloPedidos = [];

  String observaciones = '';
  bool buscar = false;
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 10), onPrimary: Colors.green);
// variables de locator
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});
  String? latitud = '';
  String? longitud = '';

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: PageBackground(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              crearOrganization(context),
              SizedBox(height: 10),
              _crearEtiqueta(),
              SizedBox(height: 5),
              clientHeaderAbstrac(
                  context,
                  widget.receivedMap["codCliente"],
                  widget.receivedMap["razonSocial"],
                  widget.receivedMap["ruc"],
                  widget.receivedMap["direccion"],
                  widget.selectedValues["documentoText"],
                  widget.selectedValues["bodegaText"]),
              SizedBox(height: 5),
              _listaArticulos(),
              SizedBox(height: 5),
              _subtotales(),
              SizedBox(height: 5),
              _observaciones(),
              SizedBox(height: 5),
              _buttonSend()
            ],
          ),
        ));
  }

  Widget _crearEtiqueta() {
    return Container(
        padding: EdgeInsets.all(5.0),
        width: 100,
        decoration: new BoxDecoration(
          color: Color(Constants.colorGreyInf),
        ),
        child: Row(children: <Widget>[
          Text(' Resumen Documento ', style: TextStyle(color: Colors.white)),
        ]));
  }

  Widget _buttonSend() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color(Constants.colorOrange),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      onPressed: () {
        enviarPedido();
      },
      child: const Text('Enviar'),
    );
  }

  _listaArticulos() {
    articuloPedidos = widget.articuloPedidos;
    try {
      if (articuloPedidos.length != 0) {
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
            child: SingleChildScrollView(
                child: DataTable(
              decoration: new BoxDecoration(
                color: Color(Constants.colorWhite),
              ),
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Color(Constants.colorBlue)),
              columnSpacing: 20.0,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Producto',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Cantidad',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Precio',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Subtotal',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: articuloPedidos
                  .map((data) => DataRow(cells: [
                        DataCell(Container(
                            width: 145,
                            child: Text(data.descripcion.toString()))),
                        DataCell(Text(data.prodCan.toString())),
                        DataCell(Text(
                            Utility.formatNumber(
                                double.parse(data.precDecim.toString()),
                                double.parse(data.precio.toString())),
                            textAlign: TextAlign.right)),
                        DataCell(Text(
                            Utility.formatNumber(
                                2, double.parse(data.subTotal.toString())),
                            textAlign: TextAlign.right)),
                      ]))
                  .toList(),
            )));
      } else {
        return Text('');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Widget _observaciones() {
    final width = MediaQuery.of(context).size.width * 1;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 1.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(Constants.colorWhite),
        ),
        child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(children: [
              Container(
                  width: width,
                  child: Text(' Observaciones',
                      textAlign: TextAlign.left,
                      style: StyleApp.getStyleTitle(14))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(),
                  onChanged: (text) {
                    if (text != '') {
                      setState(() {
                        observaciones = text;
                      });
                    }
                  },
                ),
              )
            ])));
  }

  Widget _subtotales() {
    final width = MediaQuery.of(context).size.width * 1;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 1.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(Constants.colorGrey),
        ),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        width: (width * 35) / 100,
                        child: Text(' TOTAL',
                            textAlign: TextAlign.left,
                            style: StyleApp.getStyleTitle(16))),
                    Container(
                      width: (width * 55) / 100,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorGrey),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                          Utility.formatNumber(
                              2,
                              double.parse(
                                  widget.selectedValues["totalDocumento"])),
                          textAlign: TextAlign.right,
                          style: StyleApp.getStyleWarning(16)),
                    )
                  ]),
            ])));
  }

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      latitud = _locationData.latitude.toString();
      longitud = _locationData.longitude.toString();
    });
  }

  enviarPedido() async {
    final organization = Provider.of<MultipleProviders>(context, listen: false);
    String stringJson = '';
    String fecha = Utility.getDateTime();

    stringJson += '{"CodUsu":"' + organization.codUsu + '",';
    stringJson += '"CodEmpresa":"' + widget.receivedMap["codCliente"] + '",';
    stringJson += '"CodVendedor":"' + organization.codVdd + '",';
    stringJson += '"CodBodega":"' + widget.selectedValues["bodegaValue"] + '",';
    stringJson +=
        '"CodDocumento":"' + widget.selectedValues["documenValue"] + '",';
    stringJson += '"FecDocumento":"' + fecha + '",';
    stringJson += '"Longitud":"' + longitud.toString() + '",';
    stringJson += '"Latitud":"' + latitud.toString() + '",';
    stringJson += '"Subtotal":' + widget.selectedValues["Subtotal"] + ',';
    stringJson += '"Tot_baseSI":' + widget.selectedValues["baseCero"] + ',';
    stringJson += '"Tot_baseCI":' + widget.selectedValues["baseIva"] + ',';
    stringJson += '"Descuento":' + organization.descTot.toString() + ',';
    stringJson += '"Tot_dscto":' + widget.selectedValues["descTotal"] + ',';
    stringJson += '"Impuesto":' + widget.selectedValues["ivaText"] + ',';
    stringJson += '"CodigoIVA":' + widget.selectedValues["ivaValue"] + ',';
    stringJson += '"Tot_impto":' + widget.selectedValues["valorIva"] + ',';
    stringJson += '"Total":' +Utility.formatNumber(
                                2, double.parse(widget.selectedValues["totalDocumento"]))   + ',';
    stringJson += '"Estado":"PEN",';
    observaciones = observaciones.replaceAll('"', '').replaceAll(":", "");
    stringJson += '"Observaciones": "' + observaciones + '",';
    stringJson += '"Detalles": [';
    widget.articuloPedidos.forEach((subject) {
      int prodDecim = subject.precDecim!.round();
      stringJson += '{"Cod_item": "' + subject.codigo.toString() + '",';
      stringJson += '"Des_item": "' + subject.descripcion.toString() + '",';
      stringJson += '"Unidad": "' + subject.unidad.toString() + '",';
      stringJson += '"Cantidad": ' + subject.prodCan.toString() + ',';
      stringJson += '"Prod_can": ' + subject.prodCan.toString() + ',';
      stringJson += '"Prod_decim": ' + prodDecim.toString() + ',';
      stringJson += '"Precio": ' + subject.precio.toString() + ',';
      stringJson += '"Por_des": ' + subject.descuentoItem.toString() + ',';
      stringJson += '"Subtotal": ' + subject.subTotal.toString() + '},';
    });
    stringJson = stringJson.substring(0, stringJson.length - 1);
    stringJson += ']}';

    Map<String, dynamic> result = jsonDecode(stringJson);
    final enviarDocumento = await enviarDocumentoProvider.sendDocument(context, result);
    if(enviarDocumento=='1'){
      Utility.showToast('El documento fue enviado Satisfactoriamente');
      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
      pageBuilder: (_, __, ___)=>RoutesScreen(),
                  transitionDuration: Duration( seconds: 0)
                ), (route) => false);
    }else{
      Utility.showToast('Hubo un problema al enviar el documento, por favor enviar nuevamente ');
    }
    print(enviarDocumento);
  }
}
