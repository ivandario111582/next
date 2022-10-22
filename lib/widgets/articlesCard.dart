import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
//import 'package:next_project/screens/screens.dart';
import 'package:next_project/utils/utils.dart';

class ArticleCarousel extends StatelessWidget {
  final List<dynamic> articles;
  ArticleCarousel({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          Articulo articulo = articles[index];
          int estado = Constants.colorOrange;
          return GestureDetector(
             /*
              onTap: () {
                _mostrarAlert(context, route);
              },*/
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
                                  articulo.codigo.toString() +
                                      ' - ' +
                                      articulo.descripcion.toString() +
                                      ' - ' +
                                      articulo.total.toString(),
                                  textAlign: TextAlign.left,
                                  style: StyleApp.getStyleTitle(15),
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
      ),
    );
  }
}
