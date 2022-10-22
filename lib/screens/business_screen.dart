import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';

  class BusinessScreen extends StatefulWidget {
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  final businessProvider = new BusinessProvider();
  @override
void initState(){
  super.initState();

}


  @override
  Widget build(BuildContext context) {

 // final authService=Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar:StyleApp.getAppBarSimple(context),  
      body:
      SafeArea(
      child:Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            children: [
        Container(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        image:DecorationImage(
              image: AssetImage(Constants.backGrountImage),fit:BoxFit.cover),
        )
        ),
        Center(child:
        Container(
        child: Column(
          children: <Widget>[
            SizedBox( height: 20 ),
            crearOrganization(context),
            SizedBox( height: 10 ),
            _swiperMinistery()
          ]))),

     ]),
      )
   ));
  }
Widget _swiperMinistery() {
    return FutureBuilder(
        //llamo los datos del provider
        future: businessProvider.getListBusiness(context),
        //cargo los datos del future el la variable snapshot
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            //envio cada item del listado para que se forme un objeto en este caso un cart
            return BusinessCarousel(businessS: snapshot.data??[]);
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



