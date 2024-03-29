import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/search/search.dart';
import 'package:next_project/providers/providers.dart';
//import 'package:provider/provider.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final clientsProvider = new ClientsProvider();
  late List<ClienteDetalle>? clienteDetalles = [];
  
  String? nombre       = '';
  String? ruc          = '';
  String? saldo        = '';
  String? codigo       = '';
  String? postFechados = '';

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
              detailsClients()
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
          Text(' Información Clientes', style: TextStyle(color: Colors.white)),
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
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child: Text(' Código',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))
              ),
              Container(
                width: responsive.wp(50),
                decoration: new BoxDecoration(
                  color: Color(Constants.colorWhite),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(codigo ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(15)),
              ),
              IconButton(
                  icon: Icon(Icons.search),
                  color: Color(Constants.colorBlue),
                  onPressed: () async {
                    final clienteSeleccionado = await showSearch(
                        context: context, delegate: ClientSearchDelegate());
                    if (clienteSeleccionado != null) {
                      final cadena = clienteSeleccionado.toString();
                      var arr = cadena.split('-');
                      setState(() {
                        codigo        = arr[0];
                        nombre        = arr[1];
                        ruc           = arr[2];
                        saldo         = arr[3];
                        postFechados  = arr[4];
                      });
                      clienteDetalles =
                          await clientsProvider.searchDetail(codigo ?? '',context);
                      setState(() {
                        clienteDetalles = clienteDetalles;
                      });
                    }
                  }),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:
              Text(' Nombre',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))
              ),
              Container(
                width: responsive.wp(64),
                decoration: new BoxDecoration(
                  color: Color(Constants.colorWhite),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(nombre ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(15)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:
              Text(' Chq. Postf.',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))),
              Container(
                width: responsive.wp(64),
                decoration: new BoxDecoration(
                  color: Color(Constants.colorWhite),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(postFechados ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(18)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:              
              Text(' Saldo',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))),
              Container(
                width: responsive.wp(64),
                decoration: new BoxDecoration(
                  color: Color(Constants.colorWhite),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(saldo ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(18)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  detailsClients() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
        child: SingleChildScrollView(
            child: DataTable(
          decoration: new BoxDecoration(
            color: Color(Constants.colorGrey),
          ),
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => Color(Constants.colorBlue)),
          columnSpacing: 20.0,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Documento',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Vence',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Saldo',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Chq. Postf.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          rows: clienteDetalles!
              .map((data) =>
                  // we return a DataRow every time
                  DataRow(
                      // List<DataCell> cells is required in every row
                      cells: [
                        // I want to display a green color icon when user is verified and red when unverified
                        DataCell(Text(data.documento ?? '')),
                        DataCell(Text(data.vence ?? '')),
                        DataCell(Text(data.valor.toString())),
                        DataCell(Text(data.postFechados.toString())),
                      ]))
              .toList(),
        )));
  }
}
