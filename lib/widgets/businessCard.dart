   import 'package:flutter/material.dart';
   Widget businessCard(){
     return Card(
       //tamaño de la sombra
       elevation: 10.0,
       //redondeado de las esquinas
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
       child: Column(
         children: <Widget>[
           ListTile(
             leading: Icon(Icons.photo_album,color:Colors.blue),
             title: Text('titulo'),
           )
         ],
       ),
     );
   }