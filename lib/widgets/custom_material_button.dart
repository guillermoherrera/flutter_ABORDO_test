import 'package:flutter/material.dart';
import '../../ui/ui_files.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool? loading;
  final bool? isNegative;
  final double? widthContainer;

  const CustomMaterialButton({super.key, required this.text, required this.onPressed, this.loading = false, this.isNegative, this.widthContainer = 150.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith((states) => ColorPalette.colorPrincipal),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: ColorPalette.colorNegro)
          )
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isNegative == true ? ColorPalette.colorTerciarioMedio : ColorPalette.colorSecundario,
              isNegative == true ? ColorPalette.colorTerciarioMedio : ColorPalette.colorSecundario,
              isNegative == true ? ColorPalette.colorTerciarioMedio : ColorPalette.colorSecundarioMedio,
              isNegative == true ? ColorPalette.colorTerciarioMedio : ColorPalette.colorSecundarioMedio,
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Container(
          constraints: BoxConstraints(minWidth: widthContainer!, minHeight: 50.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: loading == true ?  Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco)),
                const SizedBox(width: 10,),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ColorPalette.colorSecundario),
                    backgroundColor: ColorPalette.colorBlanco,
                    strokeWidth: 3,
                  ),
                )
              ],
            ),
          ) : FittedBox(child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco))),
        ),
      ),
    ); 
    // MaterialButton(
    //   padding: const EdgeInsets.all(0),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   disabledColor: ColorPalette.colorTerciarioMedio,
    //   elevation: 10,
    //   splashColor: Colors.transparent,
    //   highlightColor: Colors.red,
    //   color: isNegative == true ? ColorPalette.colorBlanco : ColorPalette.colorSecundario,
    //   onPressed: onPressed,
    //   child: Container(
    //     width: widthContainer,
    //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.00),
    //       gradient:  LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [
    //           isNegative == true ? ColorPalette.colorPrincipal : ColorPalette.colorSecundario,
    //           isNegative == true ? ColorPalette.colorPrincipal : ColorPalette.colorSecundario,
    //           isNegative == true ? ColorPalette.colorPrincipalMedio : ColorPalette.colorSecundarioMedio,
    //           isNegative == true ? ColorPalette.colorPrincipalMedio : ColorPalette.colorSecundarioMedio,
    //         ],
    //       ),
    //     ), 
    //     child: loading == true ?  Padding(
    //       padding: const EdgeInsets.all(0),
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco)),
    //           const SizedBox(width: 10,),
    //           const SizedBox(
    //             height: 20,
    //             width: 20,
    //             child: CircularProgressIndicator(
    //               valueColor: AlwaysStoppedAnimation(ColorPalette.colorSecundario),
    //               backgroundColor: ColorPalette.colorBlanco,
    //               strokeWidth: 3,
    //             ),
    //           )
    //         ],
    //       ),
    //     ) : FittedBox(child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco))),
    //   )
    // );
  }
}