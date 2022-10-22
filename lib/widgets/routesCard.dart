import 'package:flutter/material.dart';
//import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
//import 'package:next_project/providers/providers.dart';
import 'package:next_project/screens/screens.dart';
import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

class RoutesCarousel extends StatelessWidget {
  final List<dynamic> routes;
  RoutesCarousel({required this.routes});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[ 
        ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: routes.length,
        itemBuilder: (BuildContext context, int index) {
          RoutesSeller route = routes[index];
          int estado = (route.visitado == 'S')
              ? Constants.colorBlue
              : Constants.colorOrange;
          return GestureDetector(
              onTap: () {
                _mostrarAlert(context, route);
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                    height: 150.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(
                            estado), //                   <--- border color
                        width: 4.0,
                      ),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                //width: 120.0,
                                child: Text(
                                  route.ruc.toString() +
                                      ' - ' +
                                      route.razonSocial.toString() +
                                      ' - ' +
                                      route.nombre.toString(),
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleTitle(15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //width: 120.0,
                                child: Text(
                                  route.direccion.toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //width: 120.0,
                                child: Text(
                                  'Saldo Vencido : ' +
                                      route.saldoVencido.toString(),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //width: 120.0,
                                child: Text(
                                  'Saldo Vencer : ' +
                                      route.saldoVencer.toString(),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color:Color(Constants.colorRed)
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //width: 120.0,
                                child: Text(
                                  'Saldo Disponible : ' +
                                      route.disponible.toString(),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //width: 120.0,
                                child: Text(
                                  'Cupo : ' + route.cupo.toString(),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color:Color(Constants.colorRed)
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )); //fin stack
        },
      )],
    );
  }

  void _mostrarAlert(BuildContext context, RoutesSeller route) {
    final organization = Provider.of<MultipleProviders>(context,listen: false);
    Map<String, String> mapCliente = {
      "codCliente"  : route.cliente.toString(),
      "razonSocial" : route.razonSocial.toString(),
      "ruc"         : route.ruc.toString(),
      "direccion"   : route.direccion.toString(),
      "telefonos"   : route.telefonos.toString(),
      "contacto"    : route.contacto.toString(),
      "descuento"   : route.descuento.toString(),
      "cambDesc"    : route.cambDesc.toString()
    };
    organization.descTot=route.descuento!.toDouble();
    organization.cambDesc=route.cambDesc.toString();
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            //contorno circular del cuadro de alerta
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              '¿Que desea hacer?',
              style: StyleApp.getStyleTitle(16),
            ),
            content: Column(
                //definicion de tamaño de alerta, que se acople solo al contenido
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Para ingresar un Nuevo Documento escoja la opción INGRESAR DOCUMENTO. De lo contrario escoja JUSTIFICAR la visita',
                    maxLines: 4,
                    style: StyleApp.getStyleTitle(14),
                    textAlign: TextAlign.center,
                  ),
                ]),
            actions: <Widget>[
            /*  Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(Constants.colorBlue)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 14))),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    JustificationScreen(
                                        receivedMap: mapCliente),
                                transitionDuration: Duration(seconds: 0)));
                      },
                      child: const Text('Justificar'),
                    ),
                  ],
                ),
              ),*/
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   // const SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(Constants.colorBlue)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 14))),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    PedidoScreen(receivedMap: mapCliente),
                                transitionDuration: Duration(seconds: 0)));
                      },
                      child: const Text('Ingresar Documento'),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
