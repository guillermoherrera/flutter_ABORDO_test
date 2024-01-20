import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.onPressed, required this.text, this.color = ColorPalette.colorBlanco, this.decorationColor = ColorPalette.colorBlanco, this.fontSize = 14});

  final Function() onPressed;
  final String text;
  final Color? color;
  final Color? decorationColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith((states) => ColorPalette.colorSecundario),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
        minimumSize:  MaterialStateProperty.all<Size>(const Size(50, 30)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft
      ),
      // style: TextButton.styleFrom(
      //   padding: EdgeInsets.zero,
      //   minimumSize: const Size(50, 30),
      //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //   alignment: Alignment.centerLeft),
      onPressed: onPressed,
      child: Text(
        text, 
        style: TextStyle(
          fontSize: fontSize, 
          fontWeight: FontWeight.bold, 
          color: color, 
          decoration: TextDecoration.underline, 
          decorationColor: decorationColor)),  
    );
  }
}