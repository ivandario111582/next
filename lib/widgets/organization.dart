import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/providers/providers.dart';
import 'package:provider/provider.dart';
Widget crearOrganization(BuildContext context ) {
  final organization=Provider.of<MultipleProviders>(context);
    return Center(
      child: Container(
          child: Column(children: <Widget>[
    SizedBox(height: 2),
    Text(organization.empresa,
        textAlign: TextAlign.center, style: StyleApp.getStyleTitle(20)),
    /*
    Text(organization.direccion,
        textAlign: TextAlign.center, style: StyleApp.getStyleTitle(12)),
    
    Text(organization.telefono,
        textAlign: TextAlign.center, style: StyleApp.getStyleTitle(12)),
    */
  ])));
}
