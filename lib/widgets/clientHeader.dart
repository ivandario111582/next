import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';


  Widget clientHeader(BuildContext context,String cliente,String razonSocial,String ruc, String direccion) {
    final width = MediaQuery.of(context).size.width * 1;
    final Responsive responsive = Responsive.of(context);
      return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              Color(Constants.colorBlue), //                   <--- border color
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:
                Text(' Código',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(14))),
              Container(
                width: responsive.wp(64),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(cliente ,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:              
              Text(' Nombre',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(14))),
              Container(
                width: responsive.wp(64),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(razonSocial ,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:              
              Text(' R.U.C.',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(14))),
              Container(
                width: responsive.wp(64),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(ruc,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: responsive.wp(25),
                child:              
              Text(' Dirección',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))),
              Container(
                width: responsive.wp(64),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text( direccion ,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
        ],
      ),
    );
  }

    Widget clientHeaderAbstrac(BuildContext context,String cliente,String razonSocial,String ruc, String direccion,String documento,String bodega) {
    final width = MediaQuery.of(context).size.width * 1;
      return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              Color(Constants.colorBlue), //                   <--- border color
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: width / 4,
                child:
                Text(' Código',
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleTitle(14))),
              Container(
                width: width / 1.6,
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(cliente ,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: width / 4,
                child:              
              Text(' Nombre',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(14))),
              Container(
                width: width / 1.6,
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(razonSocial ,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: width / 4,
                child:              
              Text(' R.U.C.',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(14))),
              Container(
                width: width / 1.6,
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(ruc,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: width / 4,
                child:              
              Text(' Dirección',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))),
              Container(
                width: width / 1.6,
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text( direccion ,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: width / 4,
                child:              
              Text(' Documento',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))),
              Container(
                width: width / 1.6,
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text( documento ,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: width / 4,
                child:              
              Text(' Bodega',
                  textAlign: TextAlign.left,
                  style: StyleApp.getStyleTitle(15))),
              Container(
                width: width / 1.6,
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Text( bodega,
                    textAlign: TextAlign.left,
                    style: StyleApp.getStyleInfo(14)),
              ),
            ],
          ),                    
        ],
      ),
    );
  }
