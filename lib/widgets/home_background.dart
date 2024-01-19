import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key, required this.child, this.header = false});

  final Widget child;
  final bool? header;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child:  Stack(
        children: [
          _MainBox(),
          header == true ? _HeaderIcon() : Container(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: size.width * 0.25),
        child:  Column(
          children: [
             //Icon(Icons.person_pin_outlined, color: ColorPalette.colorBlanco, size: size.width * 0.40,),
             const Text('Hola !', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
             const SizedBox(height: 10),
             Image(image: const AssetImage('assets/ICONO_RECONOCIMIENTO_FACIAL.png'), width: size.width * 0.35,),
          ],
        ),
      ),
    );
  }
}

class _MainBox extends StatelessWidget {
  //const _MainBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * .1,
      decoration: _mainBackground(),
      child:  Stack(children: [
        //SafeArea(child: Padding(padding: const EdgeInsets.only(top: 10, left: 10), child: Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.20,))),
        Positioned(top: 0, left: 30,child: _Bubble()),
        Positioned(top: 30, right: 0,child: _Bubble()),
        // Positioned(top: -50, right: -20,child: _Bubble()),
        // Positioned(bottom: -50, left: 10,child: _Bubble()),
        // Positioned(bottom: 120, right: 20,child: _Bubble()),
        // Positioned(top: 220, right: 20,child: _Bubble()),
        // Positioned(bottom: 320, right: 200,child: _Bubble()),
      ]),
    );
  }

  BoxDecoration _mainBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(colors: [
        ColorPalette.colorPrincipal,
        ColorPalette.colorPrincipalMedio
      ])
    );
  }
}

class _Bubble extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: ColorPalette.colorBlanco.withOpacity(0.02)
        ),
    );
  }
}