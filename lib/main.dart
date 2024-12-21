import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double _firstOperand = 0;

  void _onNumberPress(String number) {
    setState(() {
      _currentInput += number;
      _output = _currentInput;
    });
  }

  void _onOperatorPress(String operator) {
    if (_currentInput.isNotEmpty) {
      _firstOperand = double.parse(_currentInput);
      _currentInput = "";
      _operator = operator;
    }
  }

  void _calculateResult() {
    if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
      double secondOperand = double.parse(_currentInput);
      double result;

      switch (_operator) {
        case "+":
          result = _firstOperand + secondOperand;
          break;
        case "-":
          result = _firstOperand - secondOperand;
          break;
        case "*":
          result = _firstOperand * secondOperand;
          break;
        case "/":
          result = secondOperand != 0 ? _firstOperand / secondOperand : double.nan;
          break;
        case "mod":
          result = _firstOperand % secondOperand;
          break;
        case "%":
          result = (_firstOperand * secondOperand) / 100;
          break;
        default:
          result = 0;
      }

      setState(() {
        _output = result.toString();
        _currentInput = "";
        _operator = "";
      });
    }
  }

  void _clear() {
    setState(() {
      _output = "0";
      _currentInput = "";
      _operator = "";
      _firstOperand = 0;
    });
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          // Display
          Expanded(
            child: Container(
              color: Colors.black,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Buttons
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7", Colors.blue, () => _onNumberPress("7")),
                  _buildButton("8", Colors.blue, () => _onNumberPress("8")),
                  _buildButton("9", Colors.blue, () => _onNumberPress("9")),
                  _buildButton("/", Colors.orange, () => _onOperatorPress("/")),
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.blue, () => _onNumberPress("4")),
                  _buildButton("5", Colors.blue, () => _onNumberPress("5")),
                  _buildButton("6", Colors.blue, () => _onNumberPress("6")),
                  _buildButton("*", Colors.orange, () => _onOperatorPress("*")),
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.blue, () => _onNumberPress("1")),
                  _buildButton("2", Colors.blue, () => _onNumberPress("2")),
                  _buildButton("3", Colors.blue, () => _onNumberPress("3")),
                  _buildButton("-", Colors.orange, () => _onOperatorPress("-")),
                ],
              ),
              Row(
                children: [
                  _buildButton("0", Colors.blue, () => _onNumberPress("0")),
                  _buildButton("C", Colors.red, _clear),
                  _buildButton("mod", Colors.orange, () => _onOperatorPress("mod")),
                  _buildButton("+", Colors.orange, () => _onOperatorPress("+")),
                ],
              ),
              Row(
                children: [
                  _buildButton("%", Colors.orange, () => _onOperatorPress("%")),
                  _buildButton("=", Colors.green, _calculateResult),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
