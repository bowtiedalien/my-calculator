import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

int isNumberPressed = 0;
var firstNumberPressed;
var secondNumberPressed;
double res = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = '0';
  String _output = '0';
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = '';

  buttonPressed(String buttonText) {
    if (buttonText == 'Clear') {
      _output = '0';
      num1 = 0.0;
      num2 = 0.0;
      operand = '';
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "x") {
      num1 = double.parse(output);

      operand = buttonText;

      _output = '0';
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already conatains a decimal point");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == 'x') {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    print(_output);

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButtonBox(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        // expanded widget to remove all spaces between each container
        child: Container(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(15),
          child: Center(
            // to center out the button title inside its container
            child: Text(
              buttonText,
              style:
                  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DisplayPane(text: output),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButtonBox('7'),
                buildButtonBox('8'),
                buildButtonBox('9'),
                buildButtonBox('/')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButtonBox('4'),
                buildButtonBox('5'),
                buildButtonBox('6'),
                buildButtonBox('x')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButtonBox('1'),
                buildButtonBox('2'),
                buildButtonBox('3'),
                buildButtonBox('-')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButtonBox('.'),
                buildButtonBox('0'),
                buildButtonBox('00'),
                buildButtonBox('+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[buildButtonBox('Clear'), buildButtonBox('=')],
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayPane extends StatefulWidget {
  const DisplayPane({super.key, required this.text});

  final String text;

  @override
  State<DisplayPane> createState() => _DisplayPaneState();
}

class _DisplayPaneState extends State<DisplayPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 10),
      child: Text(
        widget.text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.centerRight,
    );
  }
}
