import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/services/services.dart';
import 'package:next_project/utils/utils.dart';

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
          Color red = Colors.black;
          if (order.diferencia! <= 0) red = Colors.red;
          return GestureDetector(
              onTap: () {
                //print(orders[index].codigo);
                _showSimpleModalDialog(context, order.nombre.toString(),
                    order.numeroPedido.toString());
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    //height: 85.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(Constants.colorGrey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 1.0, 5.0, 1.0),
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
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold))),
                                    Row(children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                              'Pedido: ' +
                                                  order.numeroPedido.toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                      Text(
                                          'Vendedor: ' +
                                              order.nombreVendedor.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ]),
                                    Row(children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                              'Cupo: ' + order.cupo.toString(),
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
                                          width: 150.0,
                                          child: Row(children: [
                                            Text('Diferencia: ',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            Text(order.diferencia.toString(),
                                                style: TextStyle(
                                                  color: red,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                ))
                                          ])), //fin container principal
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
                          Divider(
                            height: 20,
                            color: Color(Constants.colorWhite),
                            thickness: 2,
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

  _showSimpleModalDialog(context, String nombre, String numeroPedido) {
    final orderProvider = new OrderProvider();
    TextEditingController comentario = new TextEditingController();
    showDialog(
        context: context,
        barrierDismissible:false,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                  constraints: BoxConstraints(maxHeight: 320),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Utility.stringCut(nombre.toString()),
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        TextField(
                          controller: comentario,
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                              hintText: "Ingrese comentario para autorizar"),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(Constants.colorBlue)),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(fontSize: 14))),
                                      onPressed: () async {
                                        var coment = comentario.text.trim();
                                        if (coment != '') {
                                          String respuesta =
                                              await orderProvider.approveOrder(
                                                  context,
                                                  coment,
                                                  numeroPedido);
                                          if (respuesta == 'TRUE') {
                                            Navigator.pop(context, true);
                                            NotificationsService.showSnackBar(
                                                'La autorización se realizó con éxito');
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    'order',
                                                    (Route<dynamic> route) =>
                                                        false);
                                          } else {
                                            NotificationsService.showSnackBar(
                                                'Se produjo un error al autorizar el pedido');
                                            Navigator.pop(context, false);
                                          }
                                        } else {
                                          NotificationsService.showSnackBar(
                                              'Es necesario escribir un comentario');
                                        }
                                      },
                                      child: const Text('Aceptar'),
                                    ),
                                  ])),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
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
                  )));
        });
  }
}
