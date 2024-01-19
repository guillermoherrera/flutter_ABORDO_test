import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key, required this.appBarTitle, required this.content});

  final String appBarTitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
        children: [
          Container(
            color: ColorPalette.colorPrincipal,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                color: ColorPalette.colorTerciario,
                width: double.infinity,
                height: size.height * 0.5,
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  toolbarHeight: kToolbarHeight + 1,
                  iconTheme: const IconThemeData(
                    color: ColorPalette.colorTerciario
                  ),
                  backgroundColor: ColorPalette.colorPrincipal,
                  title: Text(appBarTitle, style: TextStyles.tStyleAppBar,),
                  elevation: 0,
                  actions: [
                    Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.10,),
                    const SizedBox(width: 10,),
                  ],
                ),
                content
              ],
            ),
          )
        ]
      ); 
    }
}