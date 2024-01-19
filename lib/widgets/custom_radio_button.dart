import 'package:flutter/material.dart';
import '../../ui/ui_files.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({super.key, required this.radioName, required this.index, required this.selectedPayment, required this.onPressed});

  final String radioName;
  final int index;
  final int selectedPayment;
  final Function(int) onPressed;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        widget.onPressed(widget.index);
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (widget.selectedPayment == widget.index) ? 2.0 : 1,
            color: (widget.selectedPayment == widget.index)
                ? ColorPalette.colorNegro
                : ColorPalette.colorTerciario),
      ),
      child: Stack(
        children: [
          Center(
            child: FittedBox(
              child: Text(widget.radioName, style: (widget.selectedPayment == widget.index)
                  ? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorPalette.colorNegro)
                  : TextStyle(fontSize: 16, color: ColorPalette.colorTerciarioMedio.withOpacity(.5))),
            ),
          ),
          if (widget.selectedPayment == widget.index)
            const Positioned(
              child: Icon(Icons.radio_button_checked_outlined, color: ColorPalette.colorNegro),
            ),
        ],
      ),
    );
  }
}

class CustomRadioSexoButton extends StatefulWidget {
  const CustomRadioSexoButton({super.key, required this.radioName, required this.index, required this.selectedPayment, required this.onPressed});

  final String radioName;
  final String index;
  final String selectedPayment;
  final Function(String) onPressed;

  @override
  State<CustomRadioSexoButton> createState() => _CustomRadioSexoButtonState();
}

class _CustomRadioSexoButtonState extends State<CustomRadioSexoButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        widget.onPressed(widget.index);
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (widget.selectedPayment == widget.index) ? 2.0 : 1,
            color: (widget.selectedPayment == widget.index)
                ? ColorPalette.colorNegro
                : ColorPalette.colorTerciario),
      ),
      child: Stack(
        children: [
          Center(
            child: FittedBox(
              child: Text(widget.radioName, style: (widget.selectedPayment == widget.index)
                  ? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorPalette.colorNegro)
                  : TextStyle(fontSize: 16, color: ColorPalette.colorTerciarioMedio.withOpacity(.5))),
            ),
          ),
          if (widget.selectedPayment == widget.index)
            const Positioned(
              child: Icon(Icons.radio_button_checked_outlined, color: ColorPalette.colorNegro),
            ),
        ],
      ),
    );
  }
}