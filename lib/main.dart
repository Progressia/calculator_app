import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(alignment: Alignment.topCenter, child: NumKeyboard()));
  }
}

class NumKeyboard extends StatefulWidget {
  NumKeyboard({
    super.key,
  });

  @override
  State<NumKeyboard> createState() => _NumKeyboardState();
}

class _NumKeyboardState extends State<NumKeyboard> {
  String pressed_sign = '';
  var userInput = '';
  var actionSign = '';
  var answer = '';
  List history_userInput = [''];
  List history_answer = [''];

  void getBtnSign(sign) {
    print("Pressed:" + sign);
    setState(() {
      pressed_sign = sign;

      switch (sign) {
        case 'C':
          pressed_sign = '';
          userInput = '';
          answer = '';
          break;

        case '0':
          if (answer != '') answer = userInput;
          if (userInput != '0') userInput += '0';
          actionSign = '';
          break;
        case '1':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '1';
          actionSign = '';
          break;
        case '2':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '2';
          actionSign = '';
          break;
        case '3':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '3';
          actionSign = '';
          break;
        case '4':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '4';
          actionSign = '';
          break;
        case '5':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '5';
          actionSign = '';
          break;
        case '6':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '6';
          actionSign = '';
          break;
        case '7':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '7';
          actionSign = '';
          break;
        case '8':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '8';
          actionSign = '';
          break;
        case '9':
          if (answer != '') answer = userInput;
          if (userInput == '0') userInput = '';
          userInput += '9';
          actionSign = '';
          break;

        case '÷':
          if (userInput == '') {
            if (answer == '')
              userInput += '0';
            else {
              userInput += answer;
              answer = '';
            }
          }
          if (actionSign == '') {
            userInput += sign;
            actionSign = sign;
          } else if (actionSign != sign) {
            userInput = userInput.substring(0, userInput.length - 1);
            userInput += sign;
            actionSign = sign;
          }
          break;
        case '×':
          if (userInput == '') {
            if (answer == '')
              userInput += '0';
            else {
              userInput += answer;
              answer = '';
            }
          }
          if (actionSign == '') {
            userInput += sign;
            actionSign = sign;
          } else if (actionSign != sign) {
            userInput = userInput.substring(0, userInput.length - 1);
            userInput += sign;
            actionSign = sign;
          }
          break;
        case '−':
          if (userInput == '') {
            if (answer == '')
              userInput += '0';
            else {
              userInput += answer;
              answer = '';
            }
          }
          if (actionSign == '') {
            userInput += sign;
            actionSign = sign;
          } else if (actionSign != sign) {
            userInput = userInput.substring(0, userInput.length - 1);
            userInput += sign;
            actionSign = sign;
          }
          break;
        case '+':
          if (userInput == '') {
            if (answer == '')
              userInput += '0';
            else {
              userInput += answer;
              answer = '';
            }
          }
          if (actionSign == '') {
            userInput += sign;
            actionSign = sign;
          } else if (actionSign != sign) {
            userInput = userInput.substring(0, userInput.length - 1);
            userInput += sign;
            actionSign = sign;
          }
          break;
        case '=':
          if (userInput != '') {
            equalPressed();
            // history_answer += '\n' + userInput + ' = ' + answer;
            history_userInput.insert(0, userInput.replaceAll('.', ',') + ' = ');
            history_answer.insert(0, answer);
          }
          userInput = '';
          break;
        case ',':
          if (userInput != '') {
            if (!getLastNumber(userInput).contains(',')) userInput += ',';
          }
          break;
        case '⁺∕₋':
          if (userInput == '') {
            if (answer == '')
              userInput += '0';
            else {
              userInput += answer;
              answer = '';
            }
          }
          String lastNum = getLastNumber(userInput);
          double val = (double.parse(getLastNumber(lastNum.replaceAll(',', '.'))) * (-1));
          userInput = delLastNumber(userInput) + '(' + val.toStringAsFixed(2).replaceAll('-', '−') + ')';
          userInput = userInput.replaceAll('.', ',');
          break;
        case '%':
          if (userInput == '') {
            if (answer == '')
              userInput += '0';
            else {
              userInput += answer;
              answer = '';
            }
          }
          print(userInput);
          String lastNum = getLastNumber(userInput);
          if (lastNum.contains(')')) {
            lastNum = lastNum.substring(0, lastNum.length - 1);
            print(lastNum);
            double val = (double.parse(getLastNumber(lastNum.replaceAll(',', '.'))) * 0.01);
            removeDecimalZeroFormat(val);
            userInput = delLastNumber(userInput) + val.toStringAsFixed(2) + ')';
          } else {
            // lastNum = lastNum.substring(0, lastNum.length - 1);
            double val = (double.parse(getLastNumber(lastNum.replaceAll(',', '.'))) * 0.01);
            removeDecimalZeroFormat(val);
            userInput = delLastNumber(userInput) + val.toStringAsFixed(4);
          }
          break;
        default:
      }
    });
  }

  String getLastNumber(String data) {
    String result;

    result = data.split(RegExp(r'[÷×−+ ]')).last;

    return result;
  }

  String delLastNumber(String data) {
    String result = '';
    String lastNum = '';

    lastNum = data.split(RegExp(r'[÷×−+ ]')).last;
    result = data.substring(0, userInput.length - lastNum.length);

    return result;
  }

  // function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('×', '*');
    finaluserinput = finaluserinput.replaceAll('÷', '/');
    finaluserinput = finaluserinput.replaceAll('−', '-');
    finaluserinput = finaluserinput.replaceAll('+', '+');
    finaluserinput = finaluserinput.replaceAll(',', '.');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = removeDecimalZeroFormat(eval);
    answer = answer.replaceAll('.', ',');
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 4);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Container(
        width: 300,
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.topRight,
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: history_answer.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        text: history_userInput[index],
                        style: TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(text: history_answer[index], style: TextStyle(color: Colors.amber)),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.bottomRight,
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  (answer == '') ? userInput.toString() : answer.toString(),
                  style: TextStyle(fontSize: 80.0),
                ),
              ),
            ),
          ),
          Container(
            // alignment: Alignment.center,
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: [
                CalcBtnWidget(
                  sg_color: Colors.black,
                  bg_color: Colors.grey,
                  label: "C",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  sg_color: Colors.black,
                  bg_color: Colors.grey,
                  label: "\u207A\u2215\u208B",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  sg_color: Colors.black,
                  bg_color: Colors.grey,
                  label: "%",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '÷' ? Colors.white : Colors.orange,
                  sg_color: pressed_sign == '÷' ? Colors.orange : Colors.white,
                  label: "\u00F7",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '7' ? Colors.grey : Colors.white24,
                  label: "7",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '8' ? Colors.grey : Colors.white24,
                  label: "8",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '9' ? Colors.grey : Colors.white24,
                  label: "9",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '×' ? Colors.white : Colors.orange,
                  sg_color: pressed_sign == '×' ? Colors.orange : Colors.white,
                  label: "\u00D7",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '4' ? Colors.grey : Colors.white24,
                  label: "4",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '5' ? Colors.grey : Colors.white24,
                  label: "5",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '6' ? Colors.grey : Colors.white24,
                  label: "6",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '−' ? Colors.white : Colors.orange,
                  sg_color: pressed_sign == '−' ? Colors.orange : Colors.white,
                  label: "\u2212",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '1' ? Colors.grey : Colors.white24,
                  label: "1",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '2' ? Colors.grey : Colors.white24,
                  label: "2",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '3' ? Colors.grey : Colors.white24,
                  label: "3",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '+' ? Colors.white : Colors.orange,
                  sg_color: pressed_sign == '+' ? Colors.orange : Colors.white,
                  label: "\u002B",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '0' ? Colors.grey : Colors.white24,
                  width: 140,
                  label: "0",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == ',' ? Colors.grey : Colors.white24,
                  label: ",",
                  fcn: getBtnSign,
                ),
                CalcBtnWidget(
                  bg_color: pressed_sign == '=' ? Colors.white : Colors.orange,
                  sg_color: pressed_sign == '=' ? Colors.orange : Colors.white,
                  label: "\u003D",
                  fcn: getBtnSign,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class CalcBtnWidget extends StatelessWidget {
  String label;
  Color bg_color;
  Color sg_color;
  double width;
  double height;
  final fcn;

  CalcBtnWidget({
    required this.label,
    this.bg_color = Colors.white24,
    this.sg_color = Colors.white,
    this.width = 65,
    this.height = 65,
    required this.fcn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(2.0),
        width: width,
        height: height,
        decoration: BoxDecoration(color: bg_color, borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Text(
          label,
          style: TextStyle(fontSize: 18.0, color: sg_color),
        ),
      ),
      onTapUp: (_) => {
        fcn(label),
      },
    );
  }
}
