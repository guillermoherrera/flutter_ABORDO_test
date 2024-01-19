import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class DashVerificacionScreen extends StatefulWidget {
  const DashVerificacionScreen({super.key});

  @override
  State<DashVerificacionScreen> createState() => _DashVerificacionScreenState();
}

class _DashVerificacionScreenState extends State<DashVerificacionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomBackground(
        appBarTitle: 'Verificación',
        content: Column(
          children: [
            _header(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: CardContainer(
                backgroundColor: ColorPalette.colorBlanco,
                boxShadowColor: ColorPalette.colorShadow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Visitas', style: TextStyles.tStyleNegrita16,),
                        _verTodo()
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Material(
                              child: InkWell(
                                splashColor: ColorPalette.colorSecundario,
                                onTap: (){},
                                child: ListTile(
                                  dense: true,
                                  leading:  Container(
                                    padding: const EdgeInsets.all(0),
                                    decoration: const BoxDecoration(
                                      color: ColorPalette.colorTerciario,
                                      shape: BoxShape.circle
                                    ),
                                    child: const Icon(Icons.house, color: ColorPalette.colorPrincipal,)),
                                  title: const Text('Nombre Prospecto', style: TextStyles.tStyleTileTitle2,),
                                  subtitle: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Estatus: por verificar', style: TextStyles.tStyleTileSubtitle),
                                    ],
                                  ),
                                  trailing: const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios_outlined, color: ColorPalette.colorPrincipal)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      )
    );
  }
  
  Widget _header() {
    return  Padding(
      padding: const EdgeInsets.only(top: 25,left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hola Guillermo Herrera', style: TextStyles.tStyleGreyBase14,),
              Text('Gestiona tus visitas', style: TextStyles.tStyleGreyBase18,),
            ],
          ),
          Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: ColorPalette.colorBlanco,
            shape: BoxShape.circle
          ),
          child: const Icon(Icons.person, size: 40, color: ColorPalette.colorPrincipal))
        ],
      ),
    );
  }

  Widget _verTodo(){
    return Padding(
      padding: const EdgeInsets.only(top: 0,left: 0, right: 00),
      child: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft),
            child: const Text(
              'Ver más',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.colorNegro,
                  decoration: TextDecoration.underline, 
                  decorationColor: ColorPalette.colorNegro),
            ),
            onPressed: () {}),
        ],
      ),
    );
  }
}