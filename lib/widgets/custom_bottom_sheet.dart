import 'package:flutter/material.dart';
import '../../ui/ui_files.dart';

class CustomBottomSheet{
 static Future show({required BuildContext context, required Widget widget, bool isDismissible = true, double height = 260, Color backgroundColor = ColorPalette.colorTerciario} ){
    return showModalBottomSheet(
      context: context, 
      backgroundColor: backgroundColor,
      barrierColor: ColorPalette.colorNegro.withOpacity(0.5),
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      builder: (context) => SizedBox(
        height: height,
        width: double.infinity,
        child:  widget
      )
    );
 } 
}