import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({super.key, required this.enable, required this.texto, required this.icono});
  final bool enable;
  final String texto;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: const Size(80, 80),
          child: ClipOval(
            child: Material(
              color: !enable ? Colors.grey : const Color.fromRGBO(9, 85, 179, 1),
              child: InkWell(
                splashColor: const Color.fromRGBO(209, 57, 41, 1), 
                onTap: !enable ? null : () {}, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icono, size: 40, color: Colors.white.withOpacity(enable ? 1.0 : 0.3),), // <-- Icon
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