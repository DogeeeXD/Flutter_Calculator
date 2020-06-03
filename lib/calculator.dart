import 'package:calculator/process.dart';
import 'package:calculator/widgets/button.dart';
import 'package:calculator/widgets/display.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  final String value;

  Calculator(this.value);

  @override
  _CalculatorState createState() => _CalculatorState(this.value);
}

class _CalculatorState extends State<Calculator> {
  String _value;

  _CalculatorState(this._value);

  void update(String val) {
    Process.add(val);
    setState(() {
      this._value = Process.str;
    });
  }

  void clear() {
    setState(() {
      Process.clear();
      this._value = Process.str;
    });
  }

  void delete() {
    setState(() {
      Process.delete();
      this._value = Process.str;
    });
  }

  void compute() {
    if (Process.str.compareTo('0') != 0) {
      setState(() {
        this._value = Process.compute();
        Process.str = this._value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Display(_value),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button('Clear', () => clear(), 2),
                  Button('DEL', () => delete(), 2),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button('7', () => update('7'), 3),
                  Button('8', () => update('8'), 3),
                  Button('9', () => update('9'), 3),
                  Button('/', () => update('/'), 3),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button('4', () => update('4'), 3),
                  Button('5', () => update('5'), 3),
                  Button('6', () => update('6'), 3),
                  Button('*', () => update('*'), 3),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button('1', () => update('1'), 3),
                  Button('2', () => update('2'), 3),
                  Button('3', () => update('3'), 3),
                  Button('-', () => update('-'), 3),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button('.', () => update('.'), 3),
                  Button('0', () => update('0'), 3),
                  Button('=', () => compute(), 3),
                  Button('+', () => update('+'), 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
