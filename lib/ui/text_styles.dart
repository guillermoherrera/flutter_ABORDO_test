import 'package:flutter/material.dart';

abstract class TextStyles{
  static const TextStyle tStyleNormal14 = TextStyle(fontSize: 14);
  
  static const TextStyle tStyleTileTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle tStyleTileTitle2 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const TextStyle tStyleTileSubtitle = TextStyle(fontSize: 12);

  static const TextStyle tStyleGrey12 = TextStyle(fontSize: 12, color: Colors.grey);
  static const TextStyle tStyleGrey14 = TextStyle(fontSize: 14, color: Colors.grey);

  static const TextStyle tStyleNegrita12 = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const TextStyle tStyleNegrita14 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const TextStyle tStyleNegrita16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}