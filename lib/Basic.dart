import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pascaline/Scientific.dart';

class Basic extends StatefulWidget {
  const Basic({Key? key}) : super(key: key);

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  var Input = "";
  var Ans = "";

  final List<String> Mybuttons = [
    "C",
    "Del",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Pascaline",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          backgroundColor: Colors.deepPurple.shade300,
          actions: [IconScifi()],
        ),
        backgroundColor: Colors.deepPurple.shade100,
        body: Column(children: <Widget>[
          Expanded(
              child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Input,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      Ans,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          )),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: Mybuttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Buttons(
                          OnTapped: () {
                            setState(() {
                              Input = "";
                            });
                          },
                          BtTxtColor: Colors.white,
                          BtTxt: Mybuttons[index],
                          BtColor: Colors.green);
                    } else if (index == 1) {
                      return Buttons(
                          OnTapped: () {
                            setState(() {
                              Input = Input.substring(0, Input.length - 1);
                            });
                          },
                          BtTxtColor: Colors.white,
                          BtTxt: Mybuttons[index],
                          BtColor: Colors.red);
                    } else if (index == Mybuttons.length - 1) {
                      return Buttons(
                        BtTxt: '=',
                        BtColor: Colors.deepPurple,
                        BtTxtColor: Colors.white,
                        OnTapped: () {
                          setState(() {
                            EqualPressed();
                          });
                        },
                      );
                    } else {
                      return Buttons(
                        OnTapped: () {
                          setState(() {
                            Input += Mybuttons[index];
                          });
                        },
                        BtTxt: Mybuttons[index],
                        BtTxtColor: OptColor(Mybuttons[index])
                            ? Colors.white
                            : Colors.black,
                        BtColor: OptColor(Mybuttons[index])
                            ? Colors.deepPurple
                            : Colors.white,
                      );
                    }
                  }),
            ),
          )
        ]),
      ),
    );
  }

  void EqualPressed() {
    String FinalAns = Input.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(FinalAns);

    ContextModel cm = ContextModel();
    var eval = exp.evaluate(EvaluationType.REAL, cm);

    Ans = eval.toString();
  }
}

bool OptColor(String x) {
  if (x == '%' ||
      x == '+' ||
      x == '/' ||
      x == 'x' ||
      x == '-' ||
      x == '/' ||
      x == 'C' ||
      x == 'Del' ||
      x == '=' ||
      x == ')' ||
      x == '(') {
    return true;
  } else {
    return false;
  }
}

class IconScifi extends StatelessWidget {
  const IconScifi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.deepPurple.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        icon: Icon(Icons.more_vert_outlined),
        itemBuilder: (context) => [
              PopupMenuItem(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Basic())));
                      },
                      child: Text(
                        "Basic",
                        style: TextStyle(color: Colors.white),
                      )))
            ]);
  }
}

class Buttons extends StatelessWidget {
  final BtTxt;
  final BtColor;
  final BtTxtColor;
  final OnTapped;

  const Buttons({
    Key? key,
    this.BtTxt,
    this.BtColor,
    this.BtTxtColor,
    this.OnTapped,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: OnTapped,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 50,
                  width: 50,
                  color: BtColor,
                  child: Center(
                    child: Text(
                      BtTxt,
                      style: TextStyle(color: BtTxtColor, fontSize: 20),
                    ),
                  ),
                ))));
  }
}
