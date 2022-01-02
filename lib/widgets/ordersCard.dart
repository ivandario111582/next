import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/screens/screens.dart';
import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';

class OrdersCardCarousel extends StatelessWidget {
  final List<dynamic> orders;
  OrdersCardCarousel({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
       // padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          Order order = orders[index];
          return GestureDetector(
              onTap: () {
                print(orders[index].codigo);
                //cambiarEmpresa(context,businessS[index].nombre,businessS[index].codigo,businessS[index].direcc,businessS[index].tele);
                /*Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(seconds: 0)));*/
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    // margin:EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(Constants
                            .colorBlue), //                   <--- border color
                        width: 1.0,
                      ),
                      color:  Color(Constants.colorGrey),
                      //borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  //width: 250.0,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(order.nombre.toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold
                                                ))),
                                        Row(children: [
                                          Container(
                                            width: 150,
                                            child:
                                          Text(
                                              'Pedido: ' +
                                                  order.numeroPedido.toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                          Text(
                                              'Vendedor: ' +
                                                  order.nombreVendedor
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ]),
                                        Row(children: [
                                          Container(
                                            width: 150,
                                            child:                                          
                                          Text('Cupo: ' + order.cupo.toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                          Text(
                                              'Utilizado: ' +
                                                  order.utilizado.toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ]),
                                        Row(children: [
                                          Container(
                                            width: 150,
                                            child:                                          
                                          Text(
                                              'Diferencia: ' +
                                                  order.diferencia.toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                          Text(
                                              'Valor Pedido: ' +
                                                  order.valorPedido.toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ))
                                        ]),
                                      ])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )); //fin stack
        },
      ),
    );
  }

  cambiarEmpresa(BuildContext context, String nombre, int id, String direccion,
      String telefono) {
    final organization = Provider.of<MultipleProviders>(context, listen: false);
    organization.empresa = nombre;
    organization.idEmpresa = id.toString();
    organization.direccion = direccion;
    organization.telefono = telefono;
  }
}
