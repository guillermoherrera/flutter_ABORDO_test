import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    String?  hintText,
    required String  labelText,
    IconData? prefixIcon,
    final String? errorMessage,
    final Color? fillCollor = const Color.fromRGBO(230, 230, 230, 1),
    final Function()? suffixIconOnPressed,
    final bool? visibility,
    final IconData iconField = Icons.person,
  }){
    return InputDecoration(
      isDense: true,
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Color.fromRGBO(4, 68, 155, 1))),
      enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Color.fromRGBO(230, 230, 230, 1))),
      disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Color.fromRGBO(4, 68, 155, 1), width: 1)),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Color.fromRGBO(230, 230, 230, 1), width: 1)),
      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: Color.fromRGBO(209, 57, 41, 1), width: 1)),
      hintText: hintText,
      //labelText: labelText,
      labelStyle: const  TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(4, 68, 155, 1)),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: const Color.fromRGBO(209, 57, 41, 1)) : null,
      alignLabelWithHint: false,
      label: Center(child: Text(labelText),),
      filled: true,
      fillColor: fillCollor,
      errorStyle: const TextStyle(color: Color.fromRGBO(209, 57, 41, 1), backgroundColor: Color.fromRGBO(230, 230, 230, 1), fontWeight: FontWeight.bold),
      errorText: errorMessage,
      counterText: "",
      suffixIcon: suffixIconOnPressed != null 
      ? IconButton(onPressed: suffixIconOnPressed, icon: Icon(visibility == true ? Icons.visibility_off : Icons.visibility), color: const Color.fromRGBO(4, 68, 155, 1),) 
      : IconButton(onPressed: (){}, icon: Icon(iconField), color: const Color.fromRGBO(4, 68, 155, 1),),
      floatingLabelStyle: const TextStyle(color: Color.fromRGBO(4, 68, 155, 1), fontWeight: FontWeight.bold, fontSize: 20, backgroundColor: Color.fromRGBO(230, 230, 230, 1))
    );
  }
}