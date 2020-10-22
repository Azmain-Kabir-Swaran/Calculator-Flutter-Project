import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

import 'design/CalcButton.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF000000), // status bar color
    systemNavigationBarColor: Color(0xFF000000), // navigation bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<MyApp> {
  String input = '';
  String expression = '0';
  String result = '0';
  int c = 0;

  void numClick(String text) {
    c = 0;
    if(result == '' || result == "Error Value" && text != '+' && text != '–' && text != '×' && text != '÷' && text != '%'){
      if(result != "Error Value" ){
        input = expression;
      }
      else{
        setState(() {
          input = '0';
          result = '0';
        });
        input = '';
        result = '';
      }
    }
    else{
      if(text == '+' || text == '–' || text == '×' || text == '÷' || text == '%'){
        input = result;
        if(result == "Error Value"){
          setState(() {
            input = expression;
            result = '0';
          });
        }
        if(input != '0'){
          setState(() {
            result = '';
          });
        }
        else{
          if(text == '–'){
            setState(() {
              result = '';
              input = result;
            });
          }
          else{
            c = 1;
          }
        }
      }
      else{
        result = '';
        input = result;
      }
    }
    expression = input;
    if(c == 0) {
      setState(() => expression += text);
    }
  }

  void allClear(String text) {
    setState(() {
      expression = '0';
      result = '0';
    });
  }

  void clear(String text) {
    setState(() {
      result = '';
      expression = expression.substring(0, expression.length - 1);
      if(expression == ''){
        expression = '0';
        result = '0';
      }
    });
  }

  void evaluate(String text) {
    input = expression;
    if(input != '0' || input != '') {
      try {
        Parser p = Parser();
        input = input.replaceAll('–', '-');
        input = input.replaceAll('×', '*');
        input = input.replaceAll('÷', '/');
        input = input.replaceAll('%', '/100');
        Expression exp = p.parse(input);
        ContextModel cm = ContextModel();
        double d = exp.evaluate(EvaluationType.REAL, cm);
        double check = d - d.toInt();
        if(check == 0) {
          setState(() {
            result = d.toInt().toString();
          });
        }
        else{
          setState(() {
            double r = double.parse(d.toStringAsFixed(10));
            result = r.toString();
          });
        }
      } catch (e) {
        setState(() {
          result = "Error Value";
        });
      }
    }
    else {
      setState(() {
        result = '0';
      });
      result = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF000000),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 60.0, 12.0, 12.0),
                      child: Text(
                        expression,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    alignment: Alignment(1.0, 1.0),
                  ),

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 45,
                          color: Color(0xFFFAFBFF),
                        ),
                      ),
                    ),
                    alignment: Alignment(1.0, 1.0),
                  ),

                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CalcButton(
                        text: 'AC',
                        fillColor: 0xFF1990F4,
                        textColor: 0xFFFAFBFF,
                        textSize: 20,
                        callback: allClear,
                      ),
                      CalcButton(
                        text: '⌫',
                        fillColor: 0xFF1990F4,
                        textColor: 0xFFFAFBFF,
                        textSize: 24,
                        callback: clear,
                      ),
                      CalcButton(
                        text: '%',
                        fillColor: 0xFF374352,
                        textColor: 0xFF9CCC65,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '÷',
                        fillColor: 0xFF374352,
                        textColor: 0xFF9CCC65,
                        textSize: 40,
                        callback: numClick,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CalcButton(
                        text: '7',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '8',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '9',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '×',
                        fillColor: 0xFF374352,
                        textColor: 0xFF9CCC65,
                        textSize: 40,
                        callback: numClick,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CalcButton(
                        text: '4',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '5',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '6',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '–',
                        fillColor: 0xFF374352,
                        textColor: 0xFF9CCC65,
                        textSize: 40,
                        callback: numClick,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CalcButton(
                        text: '1',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '2',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '3',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '+',
                        fillColor: 0xFF374352,
                        textColor: 0xFF9CCC65,
                        textSize: 40,
                        callback: numClick,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CalcButton(
                        text: '.',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '0',
                        callback: numClick,
                        fillColor: 0xFF374352,
                      ),
                      CalcButton(
                        text: '00',
                        callback: numClick,
                        fillColor: 0xFF374352,
                        textSize: 20,
                      ),
                      CalcButton(
                        text: '=',
                        fillColor: 0xFF43A047,
                        textColor: 0xFFFAFBFF,
                        callback: evaluate,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
