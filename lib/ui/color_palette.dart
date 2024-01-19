import 'package:flutter/material.dart';

abstract class ColorPalette{
  static const Color colorPrincipal = Color.fromRGBO(9, 85, 179, 1);
  static const Color colorSecundario = Color.fromRGBO(209, 57, 41, 1);
  static const Color colorTerciario = Color.fromRGBO(230, 230, 230, 1);
  static const Color colorPrincipalMedio = Color.fromRGBO(4, 68, 155, 1);
  static const Color colorSecundarioMedio = Color.fromRGBO(159, 57, 41, 1);
  static const Color colorTerciarioMedio = Colors.grey;
  
  static const Color colorTransparent = Colors.transparent;
  static const Color colorShadow = Colors.black45;
  static const Color colorSuccess = Color.fromRGBO(9, 179, 85, 1);
  static const Color colorNegro = Color.fromRGBO(0, 0, 0, 1);
  static const Color colorBlanco = Color.fromRGBO(250, 250, 250, 1);
}