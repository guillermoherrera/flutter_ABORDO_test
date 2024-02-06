import 'package:flutter/material.dart';

import '../ui/ui_files.dart';

class ButtonSquare extends StatelessWidget {
  const ButtonSquare({super.key, this.size = 80, this.icon = Icons.person, required this.text, this.iconColor = ColorPalette.colorPrincipal});
  final double? size;
  final IconData? icon;
  final Color? iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: (){},
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => ColorPalette.colorBlanco),
          overlayColor: MaterialStateColor.resolveWith((states) => ColorPalette.colorPrincipal),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: ColorPalette.colorTransparent),
            )
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
          shadowColor: MaterialStateColor.resolveWith((states) => ColorPalette.colorNegro),
          elevation: MaterialStateProperty.resolveWith((states) => 15)
        ), 
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Icon(icon, color: ColorPalette.colorShadow, size: 30 ),
                  Icon(icon, color: iconColor, size: 29),
                ],
              ),
              FittedBox(child: Text(text, style: TextStyles.tStyleNormal14,))
            ],
          ),
        ),
      ),
    );
  }
}