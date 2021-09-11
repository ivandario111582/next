import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';

class OrderScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleApp.getAppBarSimple(context),
      body: PageBackground(
                child: ListView(
          //children: Column(
            children: [
              SizedBox( height: 100 ),
                 Column(
                   
                  children: [
                    SizedBox( height: 30 ),
                    //_LoginForm()
                    Text('AQUI teléfono 1'),
                    SizedBox( height: 30 ),

                  ],
                )
            ],
          ),
        )
     // ),
   );
  }
}