import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
  final Widget child;

  const AuthBackground({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [

           // _PurpleBox(),

            _HeaderIcon(),

            this.child,

          ],
        ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image:DecorationImage(
                image: AssetImage('assets/logo.jpg'),fit:BoxFit.cover
            ),
        ),
      ),
    );
  }
}

