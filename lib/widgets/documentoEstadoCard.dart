import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';

class DocumentoEstadoCarousel extends StatelessWidget {
  final List<dynamic> documentoEstados;
  DocumentoEstadoCarousel({required this.documentoEstados});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Column(children: <Widget>[
      ListView.builder(
        // padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: documentoEstados.length,
        itemBuilder: (BuildContext context, int index) {
          DocumentoEstado order = documentoEstados[index];
          Color red = Colors.black;
          int color = Utility.setColorlabel(order.estado.toString());
          String fecha=Utility.setDateTimeFormat(order.fecDocumento.toString());
          return GestureDetector(
              onTap: () {},
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(Constants.colorGrey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 1.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  width: responsive.wp(90),
                                  decoration: BoxDecoration(
                                    color: Color(Constants.colorGrey),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                order.razonSocial.toString(),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Row(children: [
                                          Container(
                                              // width: 150,
                                              child: Text(
                                                  'Fecha: ' +
                                                      fecha
                                                          .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                  ))),
                                        ]),
                                        Row(children: [
                                          Container(
                                              width: 150,
                                              child: Text(
                                                  'Bodega: ' +
                                                      order.nomBodega
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                  ))),
                                        ]),
                                        Row(children: [
                                          Container(
                                              width: 150.0,
                                              child: Row(children: [
                                                Text('Total: ',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                Text(
                                                    order.totalDocumento
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: red,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ))
                                              ])),
                                              Text('Estado: ',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )), //fin container principal
                                          Container(
                                              width: responsive.wp(25) ,
                                              padding:EdgeInsets.all(5) ,
                                              decoration: BoxDecoration(
                                                color: Color(color),
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child:Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                                  order.estado.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(Constants.colorWhite)
                                                  )))),
                                        ]),
                                        Divider(
                                          height: 10,
                                          color: Color(Constants.colorWhite),
                                          thickness: 2,
                                        ),
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
    ]);
  }
}
