import 'package:flutter/material.dart';


class InputDecorations {

  static InputDecoration authInputDecoration({
     String ? hintText,
     String ? labelText,
    IconData ? prefixIcon
  }) {
    return InputDecoration(
        fillColor: Colors.white,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.white
        ),
        prefixIcon: prefixIcon != null 
          ? Icon( prefixIcon, color: Colors.white )
          : null
      );
  }  

}