import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class DialogHelper{
  static exit(context, String msg) => showDialog(context: context, builder: (context) => ExitConfirmationDialog(msg: msg));
}

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context, msg),
    );
  }

  _buildChild(BuildContext context, String msg) => Container(
    height: 200,
    decoration: const BoxDecoration(
      color: ColorPalette.colorTerciario,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Image(image: AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: 50,),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Text(msg , style: TextStyles.tStyleNormal14, textAlign: TextAlign.center,),
          ),
          const SizedBox(height: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(onPressed: () async{
                await Future.delayed(const Duration(milliseconds: 500));
                if(context.mounted) Navigator.of(context).pop();}, child: const Text('Ok', style: TextStyles.tStyleGrey16))
              ],
          )
        ],
      ),
    ),
  );
}