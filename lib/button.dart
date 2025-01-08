import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatefulWidget {
  const Button(
      {Key? key,
      required this.text,
      required this.onTap,
      this.isSimpleButton = true,
      required this.height,
      required this.width})
      : super(key: key);

  final String text;
  final Function onTap;
  final bool isSimpleButton;
  final double height;
  final double width;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Color startingColor = const Color.fromRGBO(194, 39, 39, 1);
  Color endingColor = const Color.fromRGBO(187, 72, 71, 0.1);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            widget.width * 4.0 / 360,
            widget.height * 8.0 / 800,
            widget.width * 4.0 / 360,
            widget.height * 8.0 / 800),
        child: GestureDetector(
          onTapDown: (details) => {
            setState(() {
              startingColor = const Color.fromRGBO(186, 40, 41, 1);
              endingColor = const Color.fromRGBO(255, 255, 255, 0.1);
              SystemSound.play(SystemSoundType.click);
              widget.onTap(widget.text);
            })
          },
          onTapUp: (details) => {
            setState(() {
              startingColor = const Color.fromRGBO(194, 39, 39, 1);
              endingColor = const Color.fromRGBO(187, 72, 71, 0.1);
            })
          },
          onTapCancel: () => {
            setState(() {
              startingColor = const Color.fromRGBO(194, 39, 39, 1);
              endingColor = const Color.fromRGBO(187, 72, 71, 0.1);
            })
          },
          child: Container(
            width: widget.isSimpleButton
                ? widget.width * 64 / 360
                : widget.width * 72 / 800,
            height: widget.isSimpleButton
                ? widget.height * 70 / 800
                : widget.height * 46 / 360,
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [startingColor, endingColor]),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(18)),
            child: Center(
              child: Text(widget.text,
                  style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                          fontSize: widget.isSimpleButton ? 30 : 24,
                          color: Colors.black))),
            ),
          ),
        ));
  }
}
