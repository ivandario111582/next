import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';

class SearchArticleScreen extends StatefulWidget {
  /*final Map<String, dynamic> receivedMap;
  SearchArticleScreen({required this.receivedMap}); */
  @override
  _SearchArticleScreenState createState() => _SearchArticleScreenState();
}

class _SearchArticleScreenState extends State<SearchArticleScreen> {
  final tipoDocumentoProvider = new TipoDocumentoProvider();
  final articlesProvider = new ArticlesProvider();
  TextEditingController query = new TextEditingController();
  late List<Articulo>? articulos = [];
  String selectValue = 'FACTURA';
  List<DropdownMenuItem<String>> lista = [];
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 10), onPrimary: Colors.green);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final ancho = width - 20;
    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: PageBackground(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              crearOrganization(context),
              SizedBox(height: 10),
              _crearEtiqueta(),
              SizedBox(height: 5),
              Row(children: [
                Container(
                  width: ancho,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(Constants
                          .colorBlue), //                   <--- border color
                      width: 1.0,
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(' Articulo',
                              textAlign: TextAlign.right,
                              style: StyleApp.getStyleTitle(14)),
                          SizedBox(
                            width: 37,
                          ),
                          new Flexible(
                              child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                                controller: query,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration()),
                          )),
                          _botonIcono(),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
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
          Text(' Buscar Articulo ', style: TextStyle(color: Colors.white)),
        ]));
  }
/*
  Widget _buttonSend() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color(Constants.colorOrange),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      onPressed: () {},
      child: const Text('Enviar'),
    );
  }
  */

  Widget _botonIcono() {
    return IconButton(
        icon: Icon(Icons.search),
        color: Color(Constants.colorBlue),
        onPressed: () async {
          var coment = query.text.trim();
          if(coment!=''){
            articulos=await articlesProvider.searchArticle( coment,context);

            _swiperArticles(articulos);
              setState(() {});
          }
        });
  }

  Widget _swiperArticles(articulos)  {
    return ArticleCarousel(articles: articulos??[]);
   /* return FutureBuilder(
        //llamo los datos del provider
        future: articlesProvider.searchArticle( coment,context),
        //cargo los datos del future el la variable snapshot
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            //envio cada item del listado para que se forme un objeto en este caso un cart
            setState(() {});
            return ArticleCarousel(articles: snapshot.data??[]);
          } else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });*/
  }
}
