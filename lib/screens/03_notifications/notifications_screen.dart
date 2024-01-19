import 'package:flutter/material.dart';
import '../../ui/ui_files.dart';
import 'dart:math' as maths;


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  get math => null;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorPalette.colorTerciario
        ),
        backgroundColor: ColorPalette.colorPrincipal,
        title: const Text('Notificaciones', style: TextStyles.tStyleAppBar,),
        actions: [
          Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.10,),
          const SizedBox(width: 10,),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading:  Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color((maths.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.notifications_outlined, color: ColorPalette.colorPrincipal,)),
              title: const Text('Descripción de la notificación', style: TextStyles.tStyleTileTitle2,),
              subtitle: const Text('01/01/2000 00:00:00', style: TextStyles.tStyleTileSubtitle),
            ),
          );
        },
      ),
    );
  }
}