import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final organization = Provider.of<MultipleProviders>(context);
    List data = [];
    if (organization.aprobar == '1' || organization.aprobar == '2') {
      data = [
        {
          "imagen": "assets/clients.png",
          "title": "Clientes",
          "form": "clientForm"
        },
        {
          "imagen": "assets/articles.png",
          "title": "Articulos",
          "form": "articlesForm"
        },
        {"imagen": "assets/orders.png", "title": "Pedidos", "form": "order"}
      ];
    } else {
      data = [
        {
          "imagen": "assets/clients.png",
          "title": "Clientes",
          "form": "clientForm"
        },
        {
          "imagen": "assets/articles.png",
          "title": "Articulos",
          "form": "articlesForm"
        }
      ];
    }

    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Container(
                // color: Colors.red,
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Constants.backGrountImage),
                      fit: BoxFit.cover),
                )),
            Center(
                child: Container(
                    child: Column(children: <Widget>[
              SizedBox(height: 20),
              crearOrganization(context),
              SizedBox(height: 30),
            ]))),
            Container(
                //padding: EdgeInsets.symmetric(horizontal: 60),
                padding: EdgeInsets.fromLTRB(40.0, 80.0, 40.0, 1.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  semanticChildCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.0,
                  scrollDirection: Axis.vertical,
                  children: data.map((option) {
                    return GestureDetector(
                        child: Container(
                          width: 200,
                          height: 200,
                          // padding: EdgeInsets.all(20.0),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: AssetImage(option['imagen']),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20),
                              shape: BoxShape.rectangle),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, option['form']);
                        });
                  }).toList(),
                )),//fin container
          ]),
        )));
  }
}
