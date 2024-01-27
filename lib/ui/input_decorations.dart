import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    String?  hintText,
    required String  labelText,
    IconData? prefixIcon,
    final String? errorMessage,
    final Color? fillCollor = ColorPalette.colorTerciario,
    final Function()? suffixIconOnPressed,
    final bool? visibility,
    final IconData iconField = Icons.person,
  }){
    return InputDecoration(
      isDense: true,
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: ColorPalette.colorPrincipalMedio)),
      enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario)),
      disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: ColorPalette.colorPrincipalMedio, width: 1)),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario, width: 1)),
      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ,borderSide: BorderSide(color: ColorPalette.colorSecundario, width: 1)),
      hintText: hintText,
      //labelText: labelText,
      labelStyle: const  TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorPrincipalMedio),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: ColorPalette.colorSecundario) : null,
      alignLabelWithHint: false,
      label: Center(child: Text(labelText),),
      filled: true,
      fillColor: fillCollor,
      errorStyle: const TextStyle(color: ColorPalette.colorSecundario, backgroundColor: ColorPalette.colorTerciario, fontWeight: FontWeight.bold),
      errorText: errorMessage,
      counterText: "",
      suffixIcon: suffixIconOnPressed != null 
      ? IconButton(onPressed: suffixIconOnPressed, icon: Icon(visibility == true ? Icons.visibility_off : Icons.visibility), color: ColorPalette.colorPrincipalMedio,) 
      : IconButton(onPressed: (){}, icon: Icon(iconField), color: ColorPalette.colorPrincipalMedio,),
      floatingLabelStyle: const TextStyle(color: ColorPalette.colorPrincipalMedio, fontWeight: FontWeight.bold, fontSize: 20, backgroundColor: ColorPalette.colorTerciario)
    );
  }

  static InputDecoration formInputDecoration({
    required String  labelText,
    final bool? isLabel,
    final bool? isDense,
    final String? hintText,
    final String? prefixText,
    final String? suffixText
  }){
    return InputDecoration(
      isDense: isDense,
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(width: 2.0, color:ColorPalette.colorTerciario)),
      enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario)),
      disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorPrincipalMedio, width: 1)),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario, width: 1)),
      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorSecundario, width: 1)),
      prefixIcon: isLabel == true ? null : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(labelText, style: TextStyles.tStyleNegritaGrey16,),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      counterText: "",
      label: isLabel == true ? Text(labelText, style: TextStyles.tStyleNegritaGrey16) : null,
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16, color: ColorPalette.colorTerciarioMedio.withOpacity(0.5), fontWeight: FontWeight.bold),
      prefixText: prefixText,
      suffix: Text(suffixText ?? '')
    );
  }

  static InputDecoration searchInputDecoration({
    required String  labelText,
    final bool? isLabel,
    final bool? isDense,
    final String? hintText,
    final String? prefixText,
    final String? suffixText
  }){
    return InputDecoration(
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario)),
      enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario)),
      disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario, width: 1)),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario, width: 1)),
      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)) ,borderSide: BorderSide(color: ColorPalette.colorTerciario, width: 1)),
      hintText: hintText,
      prefixIcon: const Icon(Icons.search, color: ColorPalette.colorTerciarioMedio),
      filled: true,
      fillColor: ColorPalette.colorBlanco,
      hintStyle: TextStyle(fontSize: 16, color: ColorPalette.colorTerciarioMedio.withOpacity(0.5), fontWeight: FontWeight.bold),
    );
  }
}