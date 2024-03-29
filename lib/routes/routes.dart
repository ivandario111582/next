import 'package:next_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:next_project/screens/screens.dart';
//import 'package:next_project/model/models.dart';
Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
        'login'         : ( _ ) => LoginScreen(),
        'home'          : ( _ ) => HomeScreen(),
        'checking'      : ( _ ) => CheckAuthScreen(storage: CounterStorage()),
  //      'orderForm'     : ( _ ) => OrderScreen(),
        'clientForm'    : ( _ ) => ClientsScreen(),
        'articlesForm'  : ( _ ) => ArticleScreen(),
        'reportForm'    : ( _ ) => ReportsScreen(),
        'configForm'    : ( _ ) => ConfigScreen(storage: CounterStorage()),
        'business'      : ( _ ) => BusinessScreen(),
        'order'         : ( _ ) => OrderScreen(),
        'routesForm'    : ( _ ) => RoutesScreen(),
        //'justificationForm': ( _ ) => JustificationScreen(routesSeller:RoutesSeller()),
        'searchArticle' : ( _ ) => SearchArticleScreen(),
        'abstract'      : ( _ ) => AbstractScreen(receivedMap: {},selectedValues:{}, articuloPedidos: [],),
  };
}
