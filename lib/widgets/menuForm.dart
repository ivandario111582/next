import 'package:flutter/material.dart';
import 'package:next_project/model/MenuModel.dart';

class MenuForm extends StatelessWidget {
  const MenuForm(this.menuModel);
  @required
  final MenuModel menuModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:Hero(
                        tag: "image${menuModel.ordenMenu}",
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100.0,
                          child: Image.asset("${menuModel.icono}"),
                        ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}