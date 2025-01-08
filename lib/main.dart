import 'dart:io';

import 'package:calie/button.dart';
import 'package:calie/history.dart';
import 'package:calie/history_entry.dart';
import 'package:calie/scientific.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:async';
import 'package:math_expressions/math_expressions.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Home());
  });
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static List<HistoryEntry> entries = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SimpleCalculator(),
          '/scientific': (context) => const ScientificCalculator(),
          '/history': (context) => const History(),
        });
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
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
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 0, width * 12 / 360, height * 8 / 800),
                          alignment: Alignment.centerRight,
                          child: Text(calculation,
                              style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      fontSize: 30, color: calculationColor))),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 0, width * 12 / 360, height * 4 / 800),
                          alignment: Alignment.centerRight,
                          child: Text(result,
                              style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      fontSize: 60, color: resultColor))),
                        )
                      ],
                    ),
                  ))),
          Divider(
              height: height * 20 / 800,
              thickness: height * 5 / 800,
              indent: 0,
              endIndent: 0,
              color: Color.fromRGBO(133, 55, 55, 1)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "AC", onTap: onTapAC, width: width, height: height),
                  Button(
                      text: "()",
                      onTap: onTapParenthesis,
                      width: width,
                      height: height),
                  Button(
                      text: "%",
                      onTap: onTapPercent,
                      width: width,
                      height: height),
                  Button(
                      text: "/",
                      onTap: onTapOperator,
                      width: width,
                      height: height),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "7",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "8",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "9",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "*",
                      onTap: onTapOperator,
                      width: width,
                      height: height),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "4",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "5",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "6",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "-",
                      onTap: onTapOperator,
                      width: width,
                      height: height),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "1",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "2",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "3",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: "+",
                      onTap: onTapOperator,
                      width: width,
                      height: height),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      text: "0",
                      onTap: onTapNumber,
                      width: width,
                      height: height),
                  Button(
                      text: ".",
                      onTap: onTapPoint,
                      width: width,
                      height: height),
                  Button(
                      text: "⌫",
                      onTap: onTapDelete,
                      width: width,
                      height: height),
                  Button(
                      text: "=",
                      onTap: onTapEqual,
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
            Container(
              height: height * 110 / 800,
              alignment: Alignment.bottomLeft,
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
              leading: Text("fx",
                  style: GoogleFonts.merienda(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold))),
              minLeadingWidth: 10,
              title: Text('Scientific',
                  style: GoogleFonts.karla(
                      textStyle: TextStyle(color: Colors.white, fontSize: 22))),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/scientific');
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

  void onTapNumber(String text) {
    setState(() {
      if (calculation.isNotEmpty) {
        result = text;
      } else if (result == "0") {
        result = text;
      } else {
        result += text;
      }
      resultColor = const Color.fromRGBO(191, 191, 191, 1);
      calculation = "";
    });
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

  void onTapPoint(String text) {
    if (!hasPoint) {
      setState(() {
        calculation = "";
        if (result == "") {
          result += "0.";
        } else if (result.contains(RegExp(r'[+,/,*]'), result.length - 1) ||
            result.contains('-', result.length - 1)) {
          result += "0.";
        } else if (result.contains('(', result.length - 1)) {
          result += "0.";
        } else {
          result += ".";
        }
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      });
      hasPoint = true;
    }
    return;
  }

  void onTapPercent(String text) {
    if (!((result.contains(RegExp(r'[+,/,*]'), result.length - 1) ||
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
            (result.contains(RegExp(r'[+,/,*]'), result.length - 1))) &&
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
    } else if (result.contains(RegExp(r'[0-9,)]'), result.length - 1)) {
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
      });
    }
  }

  void onTapParenthesis(String text) {
    setState(() {
      calculation = "";
      if (result.isEmpty) {
        result += "(";
        parenthesis++;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      } else if (result.contains(RegExp(r'[0-9,)]'), result.length - 1) &&
          parenthesis > 0) {
        result += ")";
        parenthesis--;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      } else if (result.contains('.', result.length - 1) && parenthesis > 0) {
        result += "0)";
        parenthesis--;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      } else if (result.contains('(', result.length - 1) ||
          result.contains(RegExp(r'[+,/,*]'), result.length - 1) ||
          result.contains('-', result.length - 1)) {
        result += "(";
        parenthesis++;
        resultColor = const Color.fromRGBO(191, 191, 191, 1);
      }
    });
  }

  void onTapEqual(String text) {
    setState(() {
      parenthesis = 0;
      hasPoint = false;
      try {
        calculation = result;
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
}
