import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/screens/screens.dart';
import 'package:next_project/search/search.dart';
import 'package:next_project/search/searchArticlesOrders.dart';
//import 'package:next_project/services/services.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class PedidoScreen extends StatefulWidget {
  final Map<String, dynamic> receivedMap;
  PedidoScreen({required this.receivedMap});
  @override
  _PedidoScreenState createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  final tipoDocumentoProvider = new TipoDocumentoProvider();
  final bodegaProvider = new BodegaProvider();
  final ivaProvider = new IvaProvider();
  String selectValue = '1',
      selectBodega = '1',
      selectIva = '1',
      codigo = '',
      descripcion = '',
      selectDocumento = '',
      selectDocumentoText = '';
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
  List<DropdownMenuItem<String>> lista = [];
  List<DropdownMenuItem<String>> listaBodega = [];
  List<DropdownMenuItem<String>> listaIva = [];
  List<ArticuloPedido> articuloPedidos = [];
  //late ArticuloPedido articuloPedido;
  TextEditingController cantidCard = new TextEditingController(text: "0.0");
  TextEditingController precioCard =
      new TextEditingController(text: 'Initial value');
  TextEditingController descueCard = new TextEditingController();
  TextEditingController descTot = new TextEditingController();
  bool buscar = false, enabledControl=true;
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 10), onPrimary: Colors.green);
// variables de locator
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});
  String? latitud = '';
  String? longitud = '';
// map de combos
  List listDocumentos = [];
  List listBodegas = [];
  List listIva = [];
  @override
  void initState() {
    super.initState();
    getOpcionesDropdwon();
    getOpcionesDropdwonIva();
    cantidCard = new TextEditingController(text: "${cantiDefauld.toString()}");
    precioCard = new TextEditingController(text: "${preciDefauld.toString()}");
    descueCard = new TextEditingController(text: "${descuDefauld.toString()}");
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: PageBackground(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              crearOrganization(context),
              SizedBox(height: 10),
              _crearEtiqueta(),
              //SizedBox(height: 5),
              clientHeader(
                  context,
                  widget.receivedMap["codCliente"],
                  widget.receivedMap["razonSocial"],
                  widget.receivedMap["ruc"],
                  widget.receivedMap["direccion"]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: width * 0.04),
                _crearDropdown(responsive.wp(40)),
                _crearDropdownBodega(responsive.wp(35)),
                SizedBox(width: width * 0.03),
                _botonIcono()
              ]),
              // SizedBox(height: 5),
              //_crearDropdownBodega(),
              SizedBox(height: 5),
              _listaArticulos(),
              SizedBox(height: 5),
              _subtotales(),
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
          Text(' Información del Cliente ',
              style: TextStyle(color: Colors.white)),
        ]));
  }

  Widget _crearDropdown(double ancho) {
    if(enabledControl)
      return Container(
          width: ancho,
          child: DropdownButton(
            isExpanded: true,
            value: selectDocumento,
            items: lista,
            style: StyleApp.getStyleTitle(14),
            onChanged: (opt) {
              setState(() {
                selectDocumento = opt.toString();
                selectBodega = '1';
                getOpcionesDropdwonBodega();
              });
            },
          ));
      else{
        var documento;
        listDocumentos.forEach((subject) {
          if (subject["id"] == selectDocumento) {
             documento = subject["documento"];
          }
        });
        return Container(
          width: ancho,
          decoration: new BoxDecoration(
                        color: Color(Constants.colorGrey),
                      ),
          padding: EdgeInsets.all(5.0),
          child:Text(documento,
            textAlign: TextAlign.left,
            style: StyleApp.getStyleTitle(14)));
      }
        
  }

  Widget _crearDropdownBodega(double ancho) {
    if(enabledControl)
      return Container(
          width: ancho,
          child: DropdownButton(
            isExpanded: true,
            value: selectBodega,
            items: listaBodega,
            style: StyleApp.getStyleTitle(14),
            isDense: true,
            onChanged: (opt) {
              setState(() {
                selectBodega = opt.toString();
                final organization =
                    Provider.of<MultipleProviders>(context, listen: false);
                organization.codAlm = selectBodega;
                organization.codCliente = widget.receivedMap["codCliente"];
                buscar = true;
              });
            },
          ));
      else{
        var bodega;
          listBodegas.forEach((subject) {
            if (subject["id"] == selectBodega) {
              bodega = subject["bodega"];
            }
          });
        return Container(
          width: ancho,
          decoration: new BoxDecoration(
                        color: Color(Constants.colorGrey),
                      ),
          padding: EdgeInsets.all(5.0),
          child:Text(bodega,
            textAlign: TextAlign.left,
            style: StyleApp.getStyleTitle(14)));
      }
  }

  Widget _crearDropdownIva() {
    final width = MediaQuery.of(context).size.width * 1;
    return Container(
        width: width * 0.2,
        child: DropdownButton(
          isExpanded: true,
          value: selectIva,
          items: listaIva,
          style: StyleApp.getStyleTitle(14),
          onChanged: (opt) {
            setState(() {
              selectIva = opt.toString();
            });
            calculo();
          },
        )
    );
  }

  Widget _buttonSend() {
    String documentoText = '';
    String bodegaText = '';
    String ivaText = '';
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color(Constants.colorOrange),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      onPressed: () {
        if (articuloPedidos.length != 0) {
          listDocumentos.forEach((subject) {
            if (subject["id"] == selectDocumento) {
              documentoText = subject["documento"];
            }
          });
          listBodegas.forEach((subject) {
            if (subject["id"] == selectBodega) {
              bodegaText = subject["bodega"];
            }
          });
          listIva.forEach((subject) {
            if (subject["id"] == selectIva) {
              ivaText = subject["iva"];
            }
          });
          Map<String, String> selectedValues = {
            "documenValue": selectDocumento,
            "documentoText": documentoText,
            "bodegaValue": selectBodega,
            "bodegaText": bodegaText,
            "ivaValue": selectIva,
            "ivaText": ivaText,
            "Subtotal": subtotal.toString(),
            "baseCero": baseCero.toString(),
            "baseIva": baseIva.toString(),
            "descTotal": descTotal.toString(),
            "valorIva": valorIva.toString(),
            "totalDocumento": totalDocumento.toString(),
          };
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => AbstractScreen(
                      receivedMap: widget.receivedMap,
                      selectedValues: selectedValues,
                      articuloPedidos: articuloPedidos),
                  transitionDuration: Duration(seconds: 0)));
        } else {
          Utility.showToast('Seleccione productos para continuar');
        }
      },
      child: const Text('Continuar'),
    );
  }

  void getOpcionesDropdwon() async {
    List<TipoDocumento> _estadoDocumentos =
        await tipoDocumentoProvider.getListTipoDocumento(context);
    _estadoDocumentos.forEach((poder) {
      if (poder.nomDocumento.toString().trim() != '') {
        lista.add(DropdownMenuItem(
          child: Text(poder.nomDocumento.toString().trim()),
          value: poder.codDocumento.toString().trim(),
        ));
        selectDocumento = poder.codDocumento.toString().trim();
      }
      listDocumentos
          .add({"id": poder.codDocumento, "documento": poder.nomDocumento});
    });
    setState(() {
      lista = lista;
      listDocumentos = listDocumentos;
    });
  }

  void getOpcionesDropdwonBodega() async {
    listaBodega.clear();
    List<Bodega> _estadoBodega =
        await bodegaProvider.getListBodega(context, selectValue);
    _estadoBodega.forEach((poder) {
      if (poder.nomAlm.toString().trim() != '') {
        listaBodega.add(DropdownMenuItem(
          child: Text(poder.nomAlm.toString().trim()),
          value: poder.codAlm.toString().trim(),
        ));
        selectBodega = poder.codAlm.toString().trim();
        listBodegas.add({"id": poder.codAlm, "bodega": poder.nomAlm});
      }
    });
    setState(() {
      listaBodega = listaBodega;
      listBodegas = listBodegas;
    });
  }

  void getOpcionesDropdwonIva() async {
    List<Iva> _ivas = await ivaProvider.getListIva(context);
    _ivas.forEach((poder) {
      if (poder.porcentaje.toString().trim() != '') {
        if (poder.prioridad.toString() == '1') {
          selectIva = poder.codigoPorcentaje.toString();
        }
        if (poder.utilizaVentas.toString() == 'true') {
          listaIva.add(DropdownMenuItem(
            child: Text(poder.porcentaje.toString().trim()),
            value: poder.codigoPorcentaje.toString().trim(),
          ));
        }
        listIva.add({"id": poder.codigoPorcentaje, "iva": poder.porcentaje});
      }
    });
    setState(() {
      listaIva = listaIva;
      selectIva = selectIva;
      listIva = listIva;
    });
  }

  Widget _botonIcono() {
    return IconButton(
        icon: Icon(Icons.search),
        color: Color(Constants.colorBlue),
        enableFeedback: false,
        onPressed: () async {
          if (buscar == true) {
            final articuloPedido = await showSearch(
                context: context, delegate: ArticlesOrdersSearchDelegate());
            if (articuloPedido != null) {
              articuloPedido.precio = Utility.roundDouble(
                  articuloPedido.precio!, articuloPedido.precDecim!.round());
              articuloPedidos.add(articuloPedido);
              setState(() {
                articuloPedidos = articuloPedidos;
                enabledControl=false;
              });
              calculo();
            }
          }
        });
  }

  _listaArticulos() {
    final width = MediaQuery.of(context).size.width * 1;
    final Responsive responsive = Responsive.of(context);
    try {
      if (articuloPedidos.length != 0) {
        return Column(children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: articuloPedidos.length,
              itemBuilder: (context, index) {
                ArticuloPedido articuloPedido = articuloPedidos[index];
                int color = (articuloPedido.mensaje == '')
                    ? Constants.colorBlue
                    : Constants.colorRed;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    articuloPedido.codigo.toString() +
                                        ' - ' +
                                        Utility.stringCut(articuloPedido.descripcion.toString()),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                  width: width * 0.27,
                                  child: Text('Stock',
                                      textAlign: TextAlign.left,
                                      style: StyleApp.getStyleTitle(14))),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                  width: width * 0.27,
                                  child: Text('Unidad',
                                      textAlign: TextAlign.left,
                                      style: StyleApp.getStyleTitle(14))),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                  width: width * 0.27,
                                  child: Text('Cantidad',
                                      textAlign: TextAlign.left,
                                      style: StyleApp.getStyleTitle(14)))
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                width: width * 0.27,
                                decoration: new BoxDecoration(
                                  color: Color(Constants.colorGrey),
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                    articuloPedido.disponible.toString(),
                                    textAlign: TextAlign.right,
                                    style: StyleApp.getStyleInfo(14)),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                width: width * 0.27,
                                decoration: new BoxDecoration(
                                  color: Color(Constants.colorGrey),
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Text(articuloPedido.unidad.toString(),
                                    textAlign: TextAlign.left,
                                    style: StyleApp.getStyleInfo(14)),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                width: width * 0.27,
                                decoration: new BoxDecoration(
                                  color: Color(Constants.colorGrey),
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Text(articuloPedido.prodCan.toString(),
                                    textAlign: TextAlign.right,
                                    style: StyleApp.getStyleInfo(14)),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                  width: width * 0.27,
                                  child: Text('Precio',
                                      textAlign: TextAlign.left,
                                      style: StyleApp.getStyleTitle(14))),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                  width: width * 0.27,
                                  child: Text('Desc',
                                      textAlign: TextAlign.left,
                                      style: StyleApp.getStyleTitle(14))),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                  width: width * 0.27,
                                  child: Text('Sub Total',
                                      textAlign: TextAlign.left,
                                      style: StyleApp.getStyleTitle(14))),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                width: width * 0.27,
                                decoration: new BoxDecoration(
                                  color: Color(Constants.colorGrey),
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                    Utility.formatNumber(
                                        double.parse(articuloPedido.precDecim
                                            .toString()),
                                        double.parse(
                                            articuloPedido.precio.toString())),
                                    textAlign: TextAlign.right,
                                    style: StyleApp.getStyleInfo(14)),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                width: width * 0.27,
                                decoration: new BoxDecoration(
                                  color: Color(Constants.colorGrey),
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                    Utility.roundDouble(
                                                articuloPedido.descuentoItem!
                                                    .toDouble(),
                                                3)
                                            .toString() +
                                        ' %',
                                    textAlign: TextAlign.right,
                                    style: StyleApp.getStyleInfo(14)),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                width: width * 0.27,
                                decoration: new BoxDecoration(
                                  color: Color(Constants.colorGrey),
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                    Utility.formatNumber(
                                        2,
                                        double.parse(articuloPedido.subTotal
                                            .toString())),
                                    textAlign: TextAlign.right,
                                    style: StyleApp.getStyleInfo(14)),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  width: responsive.wp(65),
                                  child: Text(articuloPedido.mensaje.toString(),
                                      textAlign: TextAlign.left,
                                      style: StyleApp.getStyleWarning(12))),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                  onTap: () {},
                                  child: IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Color(color),
                                      onPressed: () {
                                        _showEditDialog(
                                            context, articuloPedido, index);
                                      }),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: IconButton(
                                      icon: Icon(Icons.delete_outline),
                                      color: Color(Constants.colorBlue),
                                      onPressed: () {
                                        _removeTodoItem(index);
                                      }),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                );
              })
        ]);
      } else {
        return Text('');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  _showEditDialog(context, ArticuloPedido articuloPedido, int index) {
    final Responsive responsive = Responsive.of(context);
    cantidCard =
        new TextEditingController(text: articuloPedido.prodCan.toString());
    precioCard =
        new TextEditingController(text: articuloPedido.precio.toString());
    descueCard = new TextEditingController(
        text: articuloPedido.descuentoItem.toString());
    showDialog(
        context: context,
        barrierDismissible:false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: responsive.hp(40)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Container(
                              width: responsive.wp(70),
                              child:
                    Text(
                        Utility.stringCut(articuloPedido.descripcion.toString()),
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold))),
                    SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              width: responsive.wp(20),
                              child: Text('Stock',
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleTitle(14))),
                          Container(
                            width: responsive.wp(35),
                            decoration: new BoxDecoration(
                              color: Color(Constants.colorGrey),
                            ),
                            padding: EdgeInsets.all(5.0),
                            child: Text(articuloPedido.disponible.toString(),
                                textAlign: TextAlign.left,
                                style: StyleApp.getStyleInfo(14)),
                          )
                        ]),
                    SizedBox(height: 3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              width: responsive.wp(20),
                              child: Text('Unidad',
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleTitle(14))),
                          Container(
                            width: responsive.wp(35),
                            decoration: new BoxDecoration(
                              color: Color(Constants.colorGrey),
                            ),
                            padding: EdgeInsets.all(5.0),
                            child: Text(articuloPedido.unidad.toString(),
                                textAlign: TextAlign.left,
                                style: StyleApp.getStyleInfo(14)),
                          )
                        ]),
                    SizedBox(height: 3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              width: responsive.wp(20),
                              child: Text('Cantidad',
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleTitle(14))),
                          Container(
                            width: responsive.wp(35),
                            decoration: new BoxDecoration(
                              color: Color(Constants.colorGrey),
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: TextField(
                                keyboardType: TextInputType.number,
                                controller: cantidCard,
                                maxLines: 1,
                                decoration:
                                    InputDecoration.collapsed(hintText: "")),
                          )
                        ]),
                    SizedBox(height: 3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              width: responsive.wp(20),
                              child: Text('Precio',
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleTitle(14))),
                          Container(
                              width: responsive.wp(35),
                              decoration: new BoxDecoration(
                                color: Color(Constants.colorGrey),
                              ),
                              padding: EdgeInsets.all(1.0),
                              child: _precioFlotante(articuloPedido))
                        ]),
                    SizedBox(height: 3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              width: responsive.wp(20),
                              child: Text('% Desc',
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleTitle(14))),
                          Container(
                            width: responsive.wp(35),
                            decoration: new BoxDecoration(
                              color: Color(Constants.colorGrey),
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: descueCard,
                              maxLines: 1,
                              decoration:
                                  InputDecoration.collapsed(hintText: ""),
                            ),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(width: responsive.wp(20)),
                          Container(
                              width: responsive.wp(35),
                              child: Text(
                                  'Desc no mayor a ' +
                                      articuloPedido.descmaximo.toString() +
                                      '%',
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleWarning(12)))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(Constants.colorBlue)),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(fontSize: 14))),
                                  onPressed: () async {
                                    _editToDoItem(
                                        index,
                                        cantidCard.text.toString(),
                                        precioCard.text.toString(),
                                        descueCard.text.toString());
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(Constants.colorBlue)),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(fontSize: 14))),
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancelar'),
                                ),
                              ],
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _precioFlotante(ArticuloPedido articuloPedido) {
    if (articuloPedido.precEdit.toString() == 'S') {
      return TextFormField(
        keyboardType: TextInputType.number,
        controller: precioCard,
        maxLines: 1,
        decoration: InputDecoration.collapsed(hintText: ""),
      );
    } else {
      Text(articuloPedido.precio.toString(),
          textAlign: TextAlign.left, style: StyleApp.getStyleInfo(14));
    }
    return Text(articuloPedido.precio.toString(),
        textAlign: TextAlign.left, style: StyleApp.getStyleInfo(14));
  }

  Widget _subtotales() {
    final organization = Provider.of<MultipleProviders>(context, listen: false);
    bool modDesc = (organization.cambDesc.toString() == 'S') ? true : false;
    final width = MediaQuery.of(context).size.width * 1;
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: width * 0.03),
                    Container(
                        width: width * 0.47,
                        child: Text('Subtotal',
                            textAlign: TextAlign.left,
                            style: StyleApp.getStyleTitle(14))),
                    Container(
                      width: width * 0.4,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorWhite),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(Utility.formatNumber(2, subtotal!).toString(),
                          textAlign: TextAlign.right,
                          style: StyleApp.getStyleInfo(14)),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: width * 0.03),
                    Container(
                        width: width * 0.27,
                        child: Text('Descuento',
                            textAlign: TextAlign.left,
                            style: StyleApp.getStyleTitle(14))),
                    Container(
                      width: width * 0.2,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorGrey),
                      ),
                      padding: EdgeInsets.all(1.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: organization.descTot.toString(),
                        enabled: modDesc,
                        maxLines: 1,
                        decoration: InputDecoration.collapsed(hintText: ""),
                        onChanged: (text) {
                          if (text != '') {
                            organization.descTot = double.parse(text);
                            calculo();
                          }
                        },
                      ),
                    ),
                    Container(
                      width: width * 0.4,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorWhite),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                          Utility.formatNumber(2, descTotal!).toString(),
                          textAlign: TextAlign.right,
                          style: StyleApp.getStyleInfo(14)),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: width * 0.03),
                    Container(
                        width: width * 0.47,
                        child: Text('Base Imponible 0%',
                            textAlign: TextAlign.left,
                            style: StyleApp.getStyleTitle(14))),
                    Container(
                      width: width * 0.4,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorWhite),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(Utility.formatNumber(2, baseCero!),
                          textAlign: TextAlign.right,
                          style: StyleApp.getStyleInfo(14)),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: width * 0.03),
                    Container(
                        width: width * 0.47,
                        child: Text('Base Imponible IVA%',
                            textAlign: TextAlign.left,
                            style: StyleApp.getStyleTitle(14))),
                    Container(
                      width: width * 0.4,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorWhite),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(Utility.formatNumber(2, baseIva!).toString(),
                          textAlign: TextAlign.right,
                          style: StyleApp.getStyleInfo(14)),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: width * 0.03),
                    Container(
                        width: width * 0.27,
                        child: Text('IVA %',
                            textAlign: TextAlign.left,
                            style: StyleApp.getStyleTitle(14))),
                    _crearDropdownIva(),
                    Container(
                      width: width * 0.4,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorWhite),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(Utility.formatNumber(2, valorIva!).toString(),
                          textAlign: TextAlign.right,
                          style: StyleApp.getStyleInfo(14)),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: width * 0.03),
                    Container(
                        width: width * 0.462,
                        child: Text('Total',
                            textAlign: TextAlign.left,
                            style: StyleApp.getStyleTitle(16))),
                    Container(
                      width: width * 0.4,
                      decoration: new BoxDecoration(
                        color: Color(Constants.colorWhite),
                      ),
                      padding: EdgeInsets.all(1.0),
                      child: Text(Utility.formatNumber(2, totalDocumento!),
                          textAlign: TextAlign.right,
                          style: StyleApp.getStyleWarning(16)),
                    )
                  ]),
            ])));
  }

  calculo() {
    final organization = Provider.of<MultipleProviders>(context, listen: false);
    subtotal = 0;
    descTotal = 0;
    baseCero = 0;
    sumaBaseCero = 0;
    sumaBaseIva = 0;
    baseIva = 0;
    totalDocumento = 0;
    valorIva = 0;
    for (ArticuloPedido articulo in articuloPedidos) {
      subtotal = subtotal!.toDouble() + articulo.subTotal!.toDouble();
    }
    //subtotal = double.parse(Utility.formatNumber(2,subtotal!)) ;
    subtotal = double.parse(subtotal!.toStringAsFixed(2));
    if (organization.descTot != 0) {
      descTotal = (subtotal! * organization.descTot) / 100;
      descTotal = double.parse(descTotal!.toStringAsFixed(2));
    }

    for (ArticuloPedido articulo in articuloPedidos) {
      if (articulo.iva == 'N') {
        sumaBaseCero = sumaBaseCero! + articulo.subTotal!.toDouble();
      } else {
        sumaBaseIva = sumaBaseIva! + articulo.subTotal!.toDouble();
      }
    }
    sumaBaseCero = double.parse(sumaBaseCero!.toStringAsFixed(3));
    sumaBaseIva = double.parse(sumaBaseIva!.toStringAsFixed(3));

    baseCero = (sumaBaseCero!.toDouble() > 0)
        ? ((sumaBaseCero!.toDouble() -
            ((organization.descTot / 100) * sumaBaseCero!)))
        : 0.0;
    baseIva = (sumaBaseIva!.toDouble() > 0)
        ? ((sumaBaseIva!.toDouble() -
            ((organization.descTot / 100) * sumaBaseIva!)))
        : 0.0;
    baseCero = double.parse(baseCero!.toStringAsFixed(2));
    baseIva = double.parse(baseIva!.toStringAsFixed(2));
    String ivaText = '';
    double ivaDouble = 0;
    listIva.forEach((subject) {
      if (subject["id"] == selectIva) {
        ivaText = subject["iva"];
      }
    });
    ivaDouble = double.parse(ivaText);
    if (sumaBaseIva! > 0) {
      valorIva = (baseIva! * ivaDouble) / 100;
      valorIva = double.parse(valorIva!.toStringAsFixed(2));
    }
    totalDocumento = baseCero! + baseIva! + valorIva!;
    totalDocumento = double.parse(totalDocumento!.toStringAsFixed(2));
    setState(() {
      subtotal = subtotal;
      descTotal = descTotal;
      sumaBaseCero = sumaBaseCero;
      sumaBaseIva = sumaBaseIva;
      baseCero = baseCero;
      baseIva = baseIva;
    });
  }

  _removeTodoItem(int index) {
    articuloPedidos.removeAt(index);
    var longitud=articuloPedidos.length;
    var estado=false;
    if(longitud==0){
      estado=true;
    }
    setState(() =>{
      articuloPedidos=articuloPedidos,
      enabledControl=estado,
      });
    calculo();
  }

  _editToDoItem(int index, String cantidad, String precio, String descuento) {
    double doble = double.parse(cantidad);
    int cantCast = doble.round();
    String mensaje = '';
    //validacion de la cantidad
    if ((selectDocumento == '02' || selectDocumento == '03') && articuloPedidos[index].prodFisi == 1) {
      if (articuloPedidos[index].vendeSinSld == 'N' && articuloPedidos[index].disponible! < cantCast) {
        mensaje = ' - La cantidad excede al saldo, dispone de ' + articuloPedidos[index].disponible.toString();
        cantCast=articuloPedidos[index].prodCan!.round();
      } else {
        articuloPedidos[index].prodCan = cantCast;
      }
    } else {
      articuloPedidos[index].prodCan = cantCast;
    }
    double prec = Utility.roundDouble(double.parse(precio), 3);
    if (double.parse(descuento) > articuloPedidos[index].descmaximo!) {
      mensaje = mensaje +
          ' - El descuento no debe superar el ' +
          articuloPedidos[index].descmaximo.toString() +
          '%';
    } else {
      articuloPedidos[index].descuentoItem = double.parse(descuento);
      articuloPedidos[index].mensaje = '';
      if (double.parse(descuento) != 0) {
        double sub =
            cantCast * (prec - ((prec * double.parse(descuento)) / 100));
        articuloPedidos[index].subTotal =
            double.parse(Utility.formatNumber(2, sub));
      } else {
        double sub = cantCast * prec;
        articuloPedidos[index].subTotal =
            double.parse(Utility.formatNumber(2, sub));
      }
    }
    setState(() {
      articuloPedidos[index].precio = prec;
      articuloPedidos = articuloPedidos;
      articuloPedidos[index].mensaje = mensaje;
    });
    calculo();
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
//print(_locationData.latitude.toString());
    setState(() {
      latitud = _locationData.latitude.toString();
      longitud = _locationData.longitude.toString();
    });
  }
}
