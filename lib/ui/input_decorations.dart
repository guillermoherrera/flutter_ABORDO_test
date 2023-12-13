import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    required String  hintText,
    required String  labelText,
    IconData? prefixIcon,
    final String? errorMessage,
  }){
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Color.fromRGBO(209, 57, 41, 1))),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Color.fromRGBO(19, 121, 255, 1), width: 1)),
      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Colors.white, width: 1)),
      hintText: hintText,
      //labelText: labelText,
      labelStyle: const  TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.red) : null,
      alignLabelWithHint: false,
      label: Center(child: Text(labelText),),
      filled: true,
      fillColor: const Color.fromRGBO(209, 57, 41, 1),
      errorStyle: TextStyle(color: Colors.red.shade900, backgroundColor: Colors.white, fontWeight: FontWeight.bold),
      errorText: errorMessage
    );
  }
}