import 'package:flutter/material.dart';

class CustomBottomSheet{
 static Future show({required BuildContext context, required Widget widget, bool isDismissible = true} ){
    return showModalBottomSheet(
      context: context, 
      backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: isDismissible,
      builder: (context) => SizedBox(
        height: 250,
        width: double.infinity,
        child:  widget
      )
    );
 } 
}