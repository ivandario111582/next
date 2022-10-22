import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/screens/screens.dart';
import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';

class BusinessCarousel extends StatelessWidget {
  final List<dynamic> businessS;
  BusinessCarousel({ required this.businessS });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        itemCount: businessS.length,
        itemBuilder: (BuildContext context, int index) {
          Business business = businessS[index];
          return GestureDetector(
              onTap: () {
                print(businessS[index].codigo);
                cambiarEmpresa(context,businessS[index].nombre,businessS[index].codigo,businessS[index].direcc,businessS[index].tele);
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___)=>HomeScreen(),
                  transitionDuration: Duration( seconds: 0)
                ));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin:EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    height: 100.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            Color(Constants.colorBlue), //                   <--- border color
                        width: 1.0,
                      ),
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //width: 120.0,
                                child: Text(
                                  business.nombre.toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(Constants.colorBlue)
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Text(
                                 'Dirección : '+ business.direcc.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                          Text(
                                 'Teléfono : '+ business.tele.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )                                
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
  cambiarEmpresa(BuildContext context,String nombre,int id,String direccion,String telefono){
    final organization = Provider.of<MultipleProviders>(context,listen: false);
    organization.empresa    = nombre;
    organization.idEmpresa  = id.toString();
    organization.direccion  = direccion;
    organization.telefono   = telefono;
  }
}
