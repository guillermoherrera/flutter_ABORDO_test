import 'package:flutter/material.dart';

import 'ui_files.dart';

abstract class TextStyles{
  static const TextStyle tStyleNormal14 = TextStyle(fontSize: 14);

  static const TextStyle tStyleAppBar = TextStyle(fontSize: 18, color: ColorPalette.colorTerciario, fontWeight: FontWeight.bold);
  static const TextStyle tStyleAppBar2 = TextStyle(fontSize: 18, color: ColorPalette.colorPrincipal, fontWeight: FontWeight.bold);
  
  static const TextStyle tStyleTileTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle tStyleTileTitle2 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const TextStyle tStyleTileSubtitle = TextStyle(fontSize: 12);

  static const TextStyle tStyleGrey12 = TextStyle(fontSize: 12, color: ColorPalette.colorTerciarioMedio);
  static const TextStyle tStyleGrey14 = TextStyle(fontSize: 14, color: ColorPalette.colorTerciarioMedio);
  static const TextStyle tStyleGrey16 = TextStyle(fontSize: 16, color: ColorPalette.colorTerciarioMedio);

  static const TextStyle tStyleBlue16 = TextStyle(fontSize: 16, color: ColorPalette.colorPrincipal);
  
  static const TextStyle tStyleGreyBase12 = TextStyle(fontSize: 12, color: ColorPalette.colorTerciario, fontWeight: FontWeight.bold);
  static const TextStyle tStyleGreyBase14 = TextStyle(fontSize: 14, color: ColorPalette.colorTerciario, fontWeight: FontWeight.bold);
  static const TextStyle tStyleGreyBase16 = TextStyle(fontSize: 16, color: ColorPalette.colorTerciario, fontWeight: FontWeight.bold);
  static const TextStyle tStyleGreyBase18 = TextStyle(fontSize: 18, color: ColorPalette.colorTerciario, fontWeight: FontWeight.bold);

  static const TextStyle tStyleNegrita12 = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const TextStyle tStyleNegrita14 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const TextStyle tStyleNegrita16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle tStyleNegrita24 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  
  static const TextStyle tStyleNegritaGrey14 = TextStyle(fontSize: 14, color: ColorPalette.colorTerciarioMedio, fontWeight: FontWeight.bold);
  static const TextStyle tStyleNegritaGrey16 = TextStyle(fontSize: 16, color: ColorPalette.colorTerciarioMedio, fontWeight: FontWeight.bold);
  
  static TextStyle tStyleNegritaStrongGrey12 = TextStyle(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.bold);
  static TextStyle tStyleNegritaStrongGrey16 = TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.bold);
}