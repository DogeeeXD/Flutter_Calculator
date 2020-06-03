import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String _value;

  Display(this._value);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[100],
      padding: EdgeInsets.all(20),
      alignment: Alignment.bottomRight,
      child: Text(
        _value,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}
