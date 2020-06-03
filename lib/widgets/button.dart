import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String _value;
  final Function _btnPressed;
  final int _flex;

  Button(this._value, this._btnPressed, this._flex);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: _flex,
      child: Container(
        child: _value == 'Clear' || _value == 'DEL'
            ? FlatButton(
                color: Colors.blueGrey[50],
                child: Text(
                  _value,
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: _btnPressed,
              )
            : FlatButton(
                child: Text(
                  _value,
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: _btnPressed,
              ),
      ),
    );
  }
}
