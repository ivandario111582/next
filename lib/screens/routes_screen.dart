import 'package:flutter/material.dart';
import 'package:next_project/model/routesSeller.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';

class RoutesScreen extends StatefulWidget {
  @override
  _RoutesScreenState createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  final routesProvider = new RoutesProvider();
  // ignore: non_constant_identifier_names
  late Future<List<RoutesSeller>> listaRutas =
      routesProvider.getListRoutes(context);
  late List<RoutesSeller> _filterList;
  late List<RoutesSeller> _listCast;
  bool _firstSearch = true;
  String _query = "";
  var _searchview = new TextEditingController();

  _RoutesScreenState() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    castFunction();
  }

  @override
  Widget build(BuildContext context) {
    // final authService=Provider.of<AuthService>(context, listen: false);
    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: PageBackground(
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: <Widget>[
              crearOrganization(context),
              SizedBox(height: 10),
              _createSearchView(),
              SizedBox(height: 10),
              _firstSearch ? _swiperRoutes() : _performSearch(),
            ])));
  }

  Widget _swiperRoutes() {
    return FutureBuilder(
        //llamo los datos del provider
        future: listaRutas,
        //cargo los datos del future el la variable snapshot
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            //envio cada item del listado para que se forme un objeto en este caso un cart
            return RoutesCarousel(routes: snapshot.data ?? []);
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

  Widget _createFilteredListView() {
    return Column(children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: RoutesCarousel(routes: _filterList),
            );
          })
    ]);
  }

  //Create a SearchView
  Widget _createSearchView() {
    return new Container(
      decoration: BoxDecoration(
          border: Border.all(
        color:
            Color(Constants.colorBlue), //                   <--- border color
        width: 3.0,
      )),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          hintText: "Buscar",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  //Perform actual search

  Widget _performSearch() {
    _filterList = [];
    for (RoutesSeller ruta in _listCast) {
      if (ruta.razonSocial!.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(ruta);
      }
    }
    return _createFilteredListView();
  }

  castFunction() async {
    _listCast = await listaRutas;
    setState(() {
      _listCast = _listCast;
    });
  }
}
