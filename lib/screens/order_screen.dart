import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';
//import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderProvider = new OrderProvider();
  late List<ClienteDetalle>? clienteDetalles = [];

  //para relacionar con la caja de texto
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: PageBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              crearOrganization(context),
              SizedBox(height: 10),
              _crearEtiqueta(),
              SizedBox(height: 5),
              _swiperMinistery()

            ],
          ),
        ));
  }

  Widget _crearEtiqueta() {
    return Container(
        padding: EdgeInsets.all(5.0),
        width: 200,
        decoration: new BoxDecoration(
          color: Color(Constants.colorGreyInf),
        ),
        child: Row(children: <Widget>[
          Text(' PEDIDOS POR AUTORIZAR', style: TextStyle(color: Colors.white)),
        ]));
  }


  Widget _swiperMinistery() {
    return FutureBuilder(
        //llamo los datos del provider
        future: orderProvider.getListOrders(context),
        //cargo los datos del future el la variable snapshot
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            //envio cada item del listado para que se forme un objeto en este caso un cart
            return OrdersCardCarousel(orders: snapshot.data ?? []);
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
