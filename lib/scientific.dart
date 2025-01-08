import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:math_expressions/math_expressions.dart';

import 'button.dart';
import 'history_entry.dart';
import 'main.dart';

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({Key? key}) : super(key: key);

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  Color resultColor = const Color.fromRGBO(191, 191, 191, 1);
  Color calculationColor = const Color.fromRGBO(191, 191, 191, 1);
  Color backgroundColor = const Color.fromRGBO(40, 3, 29, 1);
  String result = "";
  String calculation = "";
  bool hasPoint = false;
  bool hasPointChanged = false;
  int parenthesis = 0;
  double height = 0.0;
  double width = 0.0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromRGBO(88, 10, 10, 1)),
      ),
      backgroundColor: backgroundColor,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, width * 12 / 800, height * 4 / 360),
                      alignment: Alignment.centerRight,
                      child: Text(transform(result),
                          style: GoogleFonts.oswald(
                              textStyle: (TextStyle(
                                  fontSize: 42, color: resultColor)))),
                    ),
                  ))),
          Divider(
            height: height * 20 / 360,
            thickness: height * 5 / 360,
            indent: 0,
            endIndent: 0,
            color: Color.fromRGBO(133, 55, 55, 1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "sin",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "cos",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "tan",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "7",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "8",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "9",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "/",
                      onTap: onTapOperator,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "AC",
                      onTap: onTapAC,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "asin",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "acos",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "atan",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "4",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "5",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "6",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "*",
                      onTap: onTapOperator,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "()",
                      onTap: onTapParenthesis,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "sqrt",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "log",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "ln",
                      onTap: onTapFunc,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "1",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "2",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "3",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "-",
                      onTap: onTapOperator,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "%",
                      onTap: onTapPercent,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "^",
                      onTap: onTapOperator,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "π",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "e",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "0",
                      onTap: onTapNumber,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: ".",
                      onTap: onTapPoint,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "⌫",
                      onTap: onTapDelete,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "+",
                      onTap: onTapOperator,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                  Button(
                      text: "=",
                      onTap: onTapEqual,
                      isSimpleButton: false,
                      width: width,
                      height: height),
                ],
              )
            ],
          ),
        ],
      )),
      drawer: Drawer(
          child: Container(
        color: backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: height * 90 / 360,
              child: DrawerHeader(
                child: Text("Calie",
                    style: GoogleFonts.karla(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 22))),
              ),
            ),
            Divider(
                height: height * 12 / 800,
                thickness: height * 5 / 800,
                indent: 0,
                endIndent: 0,
                color: Color.fromRGBO(110, 80, 80, 1)),
            ListTile(
              leading: Text("1+1",
                  style: GoogleFonts.merienda(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold))),
              minLeadingWidth: 10,
              title: Text('Simple',
                  style: GoogleFonts.karla(
                      textStyle: TextStyle(color: Colors.white, fontSize: 22))),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.white),
                minLeadingWidth: 10,
                title: Text('Camera',
                    style: GoogleFonts.karla(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 22))),
                onTap: captureImageFromCamera),
            ListTile(
                leading: Icon(Icons.history, color: Colors.white),
                minLeadingWidth: 10,
                title: Text('History',
                    style: GoogleFonts.karla(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 22))),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/history');
                }),
          ],
        ),
      )),
    );
  }

  void onTapAC(String text) {
    resultColor = const Color.fromRGBO(191, 191, 191, 1);
    hasPoint = false;
    parenthesis = 0;
    setState(() {
      calculation = "";
      result = "";
      calculation = "";
    });
  }

  void onTapParenthesis(String text) {
    setState(() {
      calculation = "";
      if (result.isEmpty) {
        result += "(";
        parenthesis++;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      } else if (result.contains(RegExp(r'[0-9,π,e)]'), result.length - 1) &&
          parenthesis > 0) {
        result += ")";
        parenthesis--;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      } else if (result.contains('.', result.length - 1) && parenthesis > 0) {
        result += "0)";
        parenthesis--;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      } else if (result.contains('(', result.length - 1) ||
          result.contains(RegExp(r'[+,/,*,^]'), result.length - 1) ||
          result.contains('-', result.length - 1)) {
        result += "(";
        parenthesis++;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      }
    });
  }

  void onTapPercent(String text) {
    if (!((result.contains(RegExp(r'[+,/,*,^]'), result.length - 1) ||
            result.contains('-', result.length - 1)) ||
        (result.isEmpty))) {
      setState(() {
        calculation = "";
        double num = double.parse(result);
        num = num / 100;
        result = num.toString();
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      });
    }
  }

  void onTapOperator(String text) {
    if (result.isEmpty) {
      if (text == "-") {
        setState(() {
          calculation = "";
          result = '-';
          resultColor = const Color.fromRGBO(191, 191, 191, 1);
        });
      }
    } else if (((result.contains('-', result.length - 1)) ||
            (result.contains(RegExp(r'[+,/,*,^]'), result.length - 1))) &&
        result != '-') {
      setState(() {
        calculation = "";
        result = result.substring(0, result.length - 1);
        result += text;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      });
    } else if (result.contains('.', result.length - 1)) {
      setState(() {
        calculation = "";
        result = result + '0' + text;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      });
      if (hasPoint == true) {
        hasPoint = false;
        hasPointChanged = true;
      }
    } else if (result.contains(RegExp(r'[0-9,),π,e]'), result.length - 1)) {
      setState(() {
        calculation = "";
        result += text;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      });
      if (hasPoint) {
        hasPoint = false;
        hasPointChanged = true;
      }
    }
  }

  void onTapNumber(String text) {
    setState(() {
      if (calculation.isNotEmpty) {
        result = text;
      } else if (result == "0" || result.isEmpty) {
        result = text;
      } else if (result.contains("e", result.length - 1) ||
          result.contains("π", result.length - 1)) {
        return;
      } else if (!((text == "π" || text == "e") &&
          result.contains(RegExp(r'[0-9,π,e,.]'), result.length - 1))) {
        result += text;
      }
      resultColor = const Color.fromRGBO(191, 191, 191, 1);
      calculation = "";
    });
  }

  void onTapPoint(String text) {
    if (!hasPoint) {
      setState(() {
        calculation = "";
        if (result.isEmpty) {
          result += "0.";
          hasPoint = true;
        } else if (result.contains(RegExp(r'[+,/,*,^]'), result.length - 1) ||
            result.contains('-', result.length - 1)) {
          result += "0.";
          hasPoint = true;
        } else if (result.contains('(', result.length - 1)) {
          result += "0.";
          hasPoint = true;
        } else if (!(result.contains("e", result.length - 1) ||
            result.contains("π", result.length - 1))) {
          result += ".";
          hasPoint = true;
        }
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      });
    }
    return;
  }

  void onTapDelete(String text) {
    if (result.isNotEmpty) {
      if (result.contains('.', result.length - 1) && !hasPointChanged) {
        hasPoint = false;
      } else if (result.contains('.', result.length - 1) && hasPointChanged) {
        hasPoint = true;
        hasPointChanged = false;
      } else if (result.contains('(', result.length - 1)) {
        parenthesis--;
      } else if (result.contains(')', result.length - 1)) {
        parenthesis++;
      }
      setState(() {
        calculation = "";
        result = result.substring(0, result.length - 1);
        if (result.isNotEmpty &&
            result.contains(
                RegExp(r'[S,C,T,X,P,E,R,L,V]'), result.length - 1)) {
          result = result.substring(0, result.length - 1);
        }
      });
    }
  }

  void onTapFunc(String text) {
    if (calculation.isNotEmpty) {
      result = "";
      addFun(text);
      parenthesis++;
    } else if (result.isNotEmpty) {
      if (!(result.contains(RegExp(r'[0-9,),.,π,e]'), result.length - 1))) {
        addFun(text);
        parenthesis++;
      }
    } else {
      addFun(text);
      parenthesis++;
    }
    calculation = "";
    resultColor = const Color.fromRGBO(191, 191, 191, 1);
  }

  void addFun(String text) {
    setState(() {
      switch (text) {
        case "sin":
          {
            result += "S(";
            break;
          }
        case "cos":
          {
            result += "C(";
            break;
          }
        case "tan":
          {
            result += "T(";
            break;
          }
        case "asin":
          {
            result += "X(";
            break;
          }
        case "acos":
          {
            result += "P(";
            break;
          }
        case "atan":
          {
            result += "E(";
            break;
          }
        case "sqrt":
          {
            result += "R(";
            break;
          }
        case "log":
          {
            result += "L(";
            break;
          }
        case "ln":
          {
            result += "V(";
            break;
          }
      }
    });
  }

  void onTapEqual(String text) {
    setState(() {
      parenthesis = 0;
      hasPoint = false;
      try {
        calculation = transform(result);
        result = result.replaceAll("π", "3.141592653589793");
        result = result.replaceAll("e", "2.718281828459045");
        result = transform(result);
        result = result.replaceAll("asin", "arcsin");
        result = result.replaceAll("acos", "arccos");
        result = result.replaceAll("atan", "arctan");
        result = result.replaceAll("log(", "log(10,");
        print(result);
        Parser p = Parser();
        Expression exp = p.parse(result);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (result == "Infinity") {
          result = "";
          calculation = "";
          showAlert("Divided by zero!", context);
          return;
        }
        if (result.contains('.0', result.length - 2)) {
          result = result.substring(0, result.length - 2);
        }
        String calc;
        if (calculation.length > 20) {
          calc = calculation.substring(0, 18) + "...";
        } else {
          calc = calculation + "=";
        }
        Home.entries.add(HistoryEntry(result: result, calculation: calc));
        resultColor = const Color.fromRGBO(28, 153, 71, 1);
      } catch (e) {
        result = "";
        calculation = "";
        showAlert("Something went wrong :(", context);
      }
    });
  }

  showAlert(String msg, BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK",
          style: GoogleFonts.karla(textStyle: TextStyle(fontSize: 16))),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error",
          style: GoogleFonts.karla(
              textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
      content: Text(msg,
          style: GoogleFonts.karla(textStyle: TextStyle(fontSize: 16))),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String transform(String result) {
    String r = result;
    r = r.replaceAll("S", "sin");
    r = r.replaceAll("C", "cos");
    r = r.replaceAll("T", "tan");
    r = r.replaceAll("X", "asin");
    r = r.replaceAll("P", "acos");
    r = r.replaceAll("E", "atan");
    r = r.replaceAll("R", "sqrt");
    r = r.replaceAll("L", "log");
    r = r.replaceAll("V", "ln");
    return r;
  }

  Future captureImageFromCamera() async {
    File? _image;
    InputImage? inputImage;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      inputImage = InputImage.fromFilePath(pickedFile.path);
      imageToText(inputImage);
    } else {
      showAlert("Couldn't take picture", context);
    }
  }

  Future imageToText(inputImage) async {
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    setState(() {
      if (recognisedText.blocks.isNotEmpty) {
        result = recognisedText.blocks[0].text;
        onTapEqual('=');
      } else {
        showAlert(
            "Couldn't recognise a calculation. Please try again and make sure that there isn't any text in the picture besides the calculation. :)",
            context);
      }
    });
  }
}
