import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, this.onPressed, required this.text});

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,//()=>_displayBottomSheet(context, size),
      style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return green, otherwise blue
        if (states.contains(MaterialState.pressed)) {
          return const Color.fromRGBO(9, 85, 179, 1);
        }
        return Colors.black;
      }),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.black)
        )
      )
    ), 
      child: Text(text, style: TextStyles.tStyleGreyBase14,)
    );
  }
}