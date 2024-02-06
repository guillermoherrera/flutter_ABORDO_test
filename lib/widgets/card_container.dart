import 'package:flutter/material.dart';

import '../ui/ui_files.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.child, this.backgroundColor = ColorPalette.colorTransparent, this.paddingHorizontal = 20, this.boxShadowColor = ColorPalette.colorTransparent, this.paddingVertical = 20});

  final Widget child;
  final Color? backgroundColor;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Color? boxShadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: paddingVertical!, horizontal: paddingHorizontal!),
        decoration: _createCardShape(),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: backgroundColor!,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(color: boxShadowColor!, blurRadius: 15, offset: const Offset(0, 5))
    ]
  );
}