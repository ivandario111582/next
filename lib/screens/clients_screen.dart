import 'package:flutter/material.dart';
//import 'package:next_project/model/cliente.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/search/search.dart';
import 'package:next_project/providers/providers.dart';
class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final multipleProviders = new MultipleProviders();
  String? nombre = '';
  String? ruc = '';
  String? saldo = '';
  String? codigo = '';

  //para relacionar con la caja de texto
  //TextEditingController _inputFieldDateController = new TextEditingController();

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
              ClienteDetalleWidget()
            ],
          ),
        ));
  }

  Widget _crearEtiqueta() {
    return Container(
        padding: EdgeInsets.all(5.0),
        width: 100,
        decoration: new BoxDecoration(
          color: Colors.grey,
        ),
        child: Row(children: <Widget>[
          Text(' CLIENTES', style: TextStyle(color: Colors.white)),
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
                width: 33,
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
                    final clienteSeleccionado = await showSearch(
                        context: context, delegate: ClientSearchDelegate());
                    if (clienteSeleccionado != null) {
                      final cadena = clienteSeleccionado.toString();
                      var arr = cadena.split('-');
                      setState(() {
                        codigo = arr[0];
                        nombre = arr[1];
                        ruc = arr[2];
                        saldo = arr[3];
                      });
                      detailsClients(codigo);
                    }
                  }),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(' Nombre',
                  textAlign: TextAlign.right,
                  style: StyleApp.getStyleTitle(15)),
              SizedBox(
                width: 30,
              ),
              Container(
                width: 250,
                decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(nombre ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(15)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(' RUC',
                  textAlign: TextAlign.right,
                  style: StyleApp.getStyleTitle(15)),
              SizedBox(
                width: 55,
              ),
              Container(
                width: 150,
                decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(ruc ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(15)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(' Saldo',
                  textAlign: TextAlign.right,
                  style: StyleApp.getStyleTitle(15)),
              SizedBox(
                width: 46,
              ),
              Container(
                width: 150,
                decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(saldo ?? '',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(15)),
              ),
            ],
          ),
        ],
      ),
    );
  }
  detailsClients(String ? codigoCliente){
    return FutureBuilder(
        //llamo los datos del provider
        future: multipleProviders.getDetalleCliente(codigoCliente ?? ''),
        //cargo los datos del future el la variable snapshot
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            //envio cada item del listado para que se forme un objeto en este caso un cart
            print(snapshot.data);
            //return ChurchCarousel(churchs: snapshot.data);
            return Text('hola');
          } else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}


class ClienteDetalleWidget extends StatelessWidget {
  ClienteDetalleWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
        child: SingleChildScrollView(
            child: DataTable(
              decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
              headingRowColor: MaterialStateColor.resolveWith((states) => Color(Constants.colorBlue)),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Documento',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Emisión',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Vence',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Valor',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Opción',
                style: TextStyle( color: Colors.white),
              ),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Mohit')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Akshay')),
                DataCell(Text('25')),
                DataCell(Text('Software Developer')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Akshay')),
                DataCell(Text('25')),
                DataCell(Text('Software Developer')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
              ],
            ),

          ],
        ))
        );
  }
}
