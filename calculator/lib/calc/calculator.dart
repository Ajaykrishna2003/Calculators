import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '';

  void _buttonPressed(String text) {
    setState(() {
      if (text == 'C') {
        _output = '';
      } else if (text == '=') {
        _calculate();
      } else {
        _output += text;
      }
    });
  }

  void _calculate() {
  Parser p = Parser();
  Expression exp = p.parse(_output);
  ContextModel cm = ContextModel();
  double result = exp.evaluate(EvaluationType.REAL, cm);
  setState(() {
    _output = '$_output = $result';
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.count(
                crossAxisCount: 4,
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return InkWell(
      onTap: () => _buttonPressed(text),
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}