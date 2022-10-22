import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//import 'package:provider/provider.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final tipoDocumentoProvider = new TipoDocumentoProvider();
  final bodegaProvider = new BodegaProvider();
  final estadoDocumentoProvider = new EstadoDocumentoProvider();
  final documentoEstadoProvider = new DocumentoEstadoProvider();
  late List<ClienteDetalle>? clienteDetalles = [];
  List<DropdownMenuItem<String>> lista = [];
  List<DropdownMenuItem<String>> listaBodega=[];
  List<DropdownMenuItem<String>> listaEstado = [];
  List<DocumentoEstado> _documentoEstados=[];
  List listDocumentos = [];
  List listBodegas    = [];

  String selectDocumento ='',selectBodega = '1',selectEstado='1', selectValue = '1', fecIniSelected='',fecFinSelected='',selectValueEstado='';
  String selectedDateIni = '';
  String selectedDateFin = '';

  //para relacionar con la caja de texto
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
              _crearEncabezado(),
              SizedBox(height: 5),
             //_swiperMinistery()
             _listaArticulos()
            ],
          ),
        ));
  }
  @override
  void initState() {
    super.initState();
    getOpcionesDropdwon();
    getOpcionesDropdwonEstado();
  }
  Widget _crearEtiqueta() {
    return Container(
        padding: EdgeInsets.all(5.0),
        width: 100,
        decoration: new BoxDecoration(
          color: Color(Constants.colorGreyInf),
        ),
        child: Row(children: <Widget>[
          Text(' Reportes de Documentos', style: TextStyle(color: Colors.white)),
        ]));
  }

  Widget _crearEncabezado() {
    final width = MediaQuery.of(context).size.width * 1;
    final Responsive responsive = Responsive.of(context);
      return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              Color(Constants.colorBlue), //                   <--- border color
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
         // SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child: Text(' Filtro',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))
              ),
            _crearDropdown(responsive.wp(64))
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:
              Text(' Bodega',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))
              ),
              _crearDropdownBodega(responsive.wp(64)),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:
              Text(' Desde',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))),
              Container(
                width: responsive.wp(50),
                decoration: new BoxDecoration(
                  color: Color(Constants.colorWhite),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(selectedDateIni,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
              SizedBox(width: width * 0.03),
              _botonIcono(context,1,'SELECCIONE FICHA INICIAL')
            ],
          ),
        //  SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:
              Text(' Hasta',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(14))),
              Container(
                width: responsive.wp(50),
                decoration: new BoxDecoration(
                  color: Color(Constants.colorWhite),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(selectedDateFin,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(15)),
              ),
              SizedBox(width: width * 0.03),
              _botonIcono(context,2,'SELECCIONE FICHA FINAL')
            ],
          ),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child: Text(' Estado',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))
              ),
            _crearDropdownEstado(responsive.wp(50)),
            SizedBox(width: width * 0.03),
              _botonSearch(context,2,'SELECCIONE FICHA FINAL')
            ],
          ),
        ],
      ),
    );
  }
  Widget _crearDropdown(double ancho) {
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
      listDocumentos.add({"id":poder.codDocumento,"documento":poder.nomDocumento});
    });
    setState(() {
      lista = lista;
      listDocumentos=listDocumentos;
    });
  }
  Widget _crearDropdownBodega(double ancho) {
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
            });
          },
        ));
  }
  Widget _crearDropdownEstado(double ancho) {
    return Container(
        width: ancho,
        child: DropdownButton(
          isExpanded: true,
          value: selectEstado,
          items: listaEstado,
          style: StyleApp.getStyleTitle(14),
          isDense: true,
          onChanged: (opt) {
            setState(() {
              selectEstado = opt.toString();
            });
          },
        ));
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
        listBodegas.add({"id":poder.codAlm,"bodega":poder.nomAlm});
      }
    });
    setState(() {
      listaBodega   = listaBodega;
      listBodegas=listBodegas;
    });
  }
    void getOpcionesDropdwonEstado() async {
      
    List<EstadoDocumento> _estadoDocumentos =
        await estadoDocumentoProvider.getListEstadoDocumento(context,'1/EDI');
    _estadoDocumentos.forEach((poder) {
      if (poder.nomEstado.toString().trim() != '') {
        listaEstado.add(DropdownMenuItem(
          child: Text(poder.nomEstado.toString().trim()),
          value: poder.codEstado.toString().trim(),
        ));
      }
      selectEstado = poder.codEstado.toString().trim();
    });
    setState(() {
      listaEstado = listaEstado;
    });
    
  }
    Widget _botonIcono(BuildContext context,int origen,String mensaje) {
    return IconButton(
        icon: Icon(Icons.calendar_today),
        color: Color(Constants.colorBlue),
        enableFeedback: false,
        onPressed: () async {
    DateTime? picket = await showDatePicker(
      context: context,
          builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black),
          ),
          //: Colors.black,
          colorScheme: ColorScheme.light(
              primary: Color(Constants.colorBlue),
              primaryVariant: Colors.black,
              secondaryVariant: Colors.black,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black,
              secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );
    }
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime.now(),
      cancelText: "Cancelar",
      confirmText: "Seleccionar"
      helpText: mensaje,
    );
    if (picket != null) {
      setState(() {
        final DateFormat formatterDate =DateFormat('yyyy-MM-dd');
          String fecha=formatterDate.format(picket);
        if(origen==1)
          selectedDateIni=fecha;
        else
          selectedDateFin=fecha;
      });
    }
        });
  }
    Widget _botonSearch(BuildContext context,int origen,String mensaje) {
      try{
    return IconButton(
        icon: Icon(Icons.search),
        color: Color(Constants.colorBlue),
        enableFeedback: false,
        onPressed: () async {
          _documentoEstados = await documentoEstadoProvider.getListDocumentoEstado(context,selectDocumento,selectBodega,selectedDateIni,selectedDateFin,selectEstado);
          Utility.showToast(_documentoEstados.length.toString()+ ' Documentos');
          setState(() {
          _documentoEstados=_documentoEstados;
          });
        });
      }catch(e){
        print(e);
      }
      return(Text(''));
  }

  _listaArticulos() {
    if (_documentoEstados.length != 0) {
      return DocumentoEstadoCarousel(documentoEstados: _documentoEstados );
    }
    else{
      return Text('');
    }
  }
}
