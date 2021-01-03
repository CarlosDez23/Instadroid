import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {

  final Color color;
  final double size;

  const AppTitle({@required this.color, @required this.size});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Instadroid',
          style: TextStyle(
            fontFamily: 'Dancing Script',
            color: this.color,
            fontSize: this.size,
            fontWeight: FontWeight.bold,
          )  
        ),
      ]
    );
  }
}
