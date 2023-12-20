import 'package:flutter/material.dart';

class CustomBottomSheet{
 static Future show({required BuildContext context, required Widget widget, bool isDismissible = true, double height = 250} ){
    return showModalBottomSheet(
      context: context, 
      backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: isDismissible,
      builder: (context) => SizedBox(
        height: height,
        width: double.infinity,
        child:  widget
      )
    );
 } 
}