import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({super.key, required this.enable, required this.texto, required this.icono, this.onTap});
  final bool enable;
  final String texto;
  final IconData icono;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: const Size(80, 80),
          child: ClipOval(
            child: Material(
              color: !enable ? ColorPalette.colorTerciarioMedio : ColorPalette.colorPrincipal,
              child: InkWell(
                splashColor: ColorPalette.colorSecundario, 
                onTap: onTap, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icono, size: 40, color: ColorPalette.colorBlanco.withOpacity(enable ? 1.0 : 0.3),), // <-- Icon
                    //Text(texto), // <-- Text
                  ],
                ),
              ),
            ),
          ),
        ),
        Text(texto, style: enable ? TextStyles.tStyleNegrita12 : TextStyles.tStyleGrey12, textAlign: TextAlign.center,)
      ],
    );
  }
}