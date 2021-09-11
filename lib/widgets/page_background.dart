import 'package:flutter/material.dart';
import 'package:next_project/utils/utils.dart';
class PageBackground extends StatelessWidget {
  final Widget child;

  const PageBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PageBackground(),
          this.child,
        ],
      ),
    );
  }
}

class _PageBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Constants.backGrountImage),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
