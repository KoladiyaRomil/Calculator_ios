import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calculator(),
    );
  }
}

// ignore: camel_case_types
class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorstste();
}

// ignore: camel_case_types
class _calculatorstste extends State<calculator> {
  bool hasInput = false;

  Widget calcbutton(String btntext, Color btncolor, Color textcolor) {
    return Container(
      child: ElevatedButton(
          onPressed: (() {
            handleButtonPress(btntext);
          }),
          child: Text(
            btntext,
            style: TextStyle(fontSize: 35, color: textcolor),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: btncolor,
              fixedSize: const Size(87, 87),
              shape: CircleBorder(),
              padding: EdgeInsets.all(20))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 88, 9),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CALCULATOR'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 121, 161, 140),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 100),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //heare we will put the functioning buttons
              calcbutton(hasInput ? 'C' : 'AC', Colors.grey.shade700,
                  const Color.fromARGB(255, 240, 98, 38)),
              calcbutton('⌫', Colors.grey.shade700,
                  const Color.fromARGB(255, 231, 96, 38)),
              calcbutton('%', Colors.grey.shade700,
                  const Color.fromARGB(255, 228, 95, 38)),
              calcbutton('/', Colors.grey.shade700,
                  const Color.fromARGB(255, 233, 96, 38)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //heare we will put the functioning buttons
              calcbutton('7', Colors.grey.shade800, Colors.white),
              calcbutton('8', Colors.grey.shade800, Colors.white),
              calcbutton('9', Colors.grey.shade800, Colors.white),
              calcbutton('*', Colors.grey.shade700,
                  const Color.fromARGB(255, 230, 96, 38)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //heare we will put the functioning buttons
              calcbutton('4', Colors.grey.shade800, Colors.white),
              calcbutton('5', Colors.grey.shade800, Colors.white),
              calcbutton('6', Colors.grey.shade800, Colors.white),
              calcbutton('-', Colors.grey.shade700,
                  const Color.fromARGB(255, 228, 95, 38)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //heare we will put the functioning buttons
              calcbutton('1', Colors.grey.shade800, Colors.white),
              calcbutton('2', Colors.grey.shade800, Colors.white),
              calcbutton('3', Colors.grey.shade800, Colors.white),
              calcbutton('+', Colors.grey.shade700,
                  const Color.fromARGB(255, 240, 98, 38)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (() {
                  handleButtonPress("0");
                }),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.grey.shade800,
                    padding: EdgeInsets.fromLTRB(
                      34,
                      20,
                      128,
                      20,
                    )),
              ),
              calcbutton('.', Colors.grey.shade800, Colors.white),
              calcbutton('=', Colors.grey.shade700,
                  const Color.fromARGB(255, 214, 91, 38)),
            ],
          )
        ]),
      ),
    );
  }

  //logic for the calculator

  dynamic text = '0';
  double numone = 0;
  double numtwo = 0;

  dynamic result = '';
  dynamic finalresult = '';
  dynamic Operator = '';
  dynamic preperator = '';

  void handleButtonPress(btntext) {
    if (btntext == 'AC' || btntext == 'C') {
      if (hasInput) {
        result = '';
        finalresult = '0';
        hasInput = false;
      } else {
        text = '0';
        numone = 0;
        numtwo = 0;
        result = '';
        finalresult = '0';
        Operator = '';
        preperator = '';
      }
    } else if (btntext == '+' ||
        btntext == '-' ||
        btntext == '*' ||
        btntext == '/' ||
        btntext == '%' ||
        btntext == '=') {
      if (numone == 0) {
        numone = double.parse(result);
      } else {
        numtwo = double.parse(result);
      }
      if (Operator == '+') {
        finalresult = add();
      }
      if (Operator == '-') {
        finalresult = sub();
      }
      if (Operator == '*') {
        finalresult = mul();
      }
      if (Operator == '/') {
        finalresult = div();
      }
      preperator = Operator;
      Operator = btntext;
      result = '';
    } else if (btntext == '%') {
      result = numone / 100;
      finalresult = containDecimal(result);
    } else if (btntext == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalresult = result;
    } else if (btntext == '⌫') {
      if (result.isNotEmpty) {
        result = result.substring(0, result.length - 1);
        finalresult = result.isEmpty ? '0' : result;
        hasInput = result.isNotEmpty;
      }
    } else {
      result = result + btntext;
      finalresult = result;
      hasInput = true;
    }

    setState(() {
      text = finalresult;
    });
  }

  String add() {
    result = (numone + numtwo).toString();
    numone = double.parse(result);
    return containDecimal(result);
  }

  String sub() {
    result = (numone - numtwo).toString();
    numone = double.parse(result);
    return containDecimal(result);
  }

  String mul() {
    result = (numone * numtwo).toString();
    numone = double.parse(result);
    return containDecimal(result);
  }

  String div() {
    result = (numone / numtwo).toString();
    numone = double.parse(result);
    return containDecimal(result);
  }

  String containDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
