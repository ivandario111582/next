import 'package:flutter/material.dart';
import 'package:next_project/search/search.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final articlesProvider = new ArticlesProvider();
  late List<ArticuloDetalle>? articuloDetalle = [];
  String? codigo = '';
  String? descripcion = '';
  String? total = '';

  //para relacionar con la caja de texto
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: PageBackground(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              crearOrganization(),
              SizedBox(height: 30),
              _crearEtiqueta(),
              _crearEncabezado(),
              SizedBox(height: 5),
              detailsClients(codigo)
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
          Text(' Inventario', style: TextStyle(color: Colors.white)),
        ]));
  }

  Widget _crearEncabezado() {
    final width = MediaQuery.of(context).size.width * 1;
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
              Text(' Código',
                  textAlign: TextAlign.right,
                  style: StyleApp.getStyleTitle(15)),
              SizedBox(
                width: 37,
              ),
              Container(
                width: 150,
                decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(codigo ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(15)),
              ),
              IconButton(
                  icon: Icon(Icons.search),
                  color: Color(Constants.colorBlue),
                  onPressed: () async {
                    final articuloSeleccionado = await showSearch(
                        context: context, delegate: ArticlesSearchDelegate());
                    if (articuloSeleccionado != null) {
                      final cadena = articuloSeleccionado.toString();
                      var arr = cadena.split('-');
                      setState(() {
                        codigo      = arr[0];
                        descripcion = arr[1];
                        total       = arr[2];
                      });
                      articuloDetalle = await articlesProvider.searchDetail(codigo ?? '');
                      setState(() {
                        articuloDetalle = articuloDetalle;
                      });
                    }
                  }),
            ],
          ),
          SizedBox(height: 1),
          Row(
            children: [
              Text(' Nombre',
                  textAlign: TextAlign.right,
                  style: StyleApp.getStyleTitle(15)),
              SizedBox(
                width: 32,
              ),
              Container(
                width: 250,
                decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(descripcion ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(15)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(' Total',
                  textAlign: TextAlign.right,
                  style: StyleApp.getStyleTitle(15)),
              SizedBox(
                width: 52,
              ),
              Container(
                width: 150,
                decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(total ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(15)),
              ),
            ],
          ),
        ],
      ),
    );
  }

    detailsClients(String? codigoCliente) {
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
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Bodega',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Cantidad',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          rows: articuloDetalle!
              .map((data) =>
                  DataRow(
                      cells: [
                        DataCell(Text(data.bodega ?? '')),
                        DataCell(Text(data.cantidad.toString())),
                      ]))
              .toList(),
        )));
  }
}
