import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/prospecto/prospecto_bloc.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashProspeccionScreen extends StatefulWidget {
  const DashProspeccionScreen({super.key});

  @override
  State<DashProspeccionScreen> createState() => _DashProspeccionScreenState();
}

class _DashProspeccionScreenState extends State<DashProspeccionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prospectoBloc = context.watch<ProspectoBloc>();
    
    return Scaffold(
      body: CustomBackground(
        appBarTitle: 'Prospección',
        content: Column(children: [
          _header(),
          _actions(size, prospectoBloc),
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
                      const Text('Últimos Registros', style: TextStyles.tStyleNegrita16,),
                      _verTodo()
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
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
                                    //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                    color: ColorPalette.colorTerciario,
                                    shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.person, color: ColorPalette.colorPrincipal,)),
                                title: const Text('Nombre Prospecto', style: TextStyles.tStyleTileTitle2,),
                                subtitle: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Estatus: prospecto', style: TextStyles.tStyleTileSubtitle),
                                    Text('01/01/2000', style: TextStyles.tStyleTileSubtitle),
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
          Container(
            padding: const EdgeInsets.only(top: 15),
            margin: const EdgeInsets.only(bottom: 15),
            child: CardContainer(
              backgroundColor: ColorPalette.colorBlanco,
              boxShadowColor: ColorPalette.colorShadow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Visitas', style: TextStyles.tStyleNegrita16,),                      
                  SizedBox(
                    height: size.height * 0.3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
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
                                  decoration:  BoxDecoration(
                                    //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                    color: index % 2 == 0 ? ColorPalette.colorTerciario : ColorPalette.colorPrincipal,
                                    shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.house, color: ColorPalette.colorPrincipal,)),
                                title: const Text('Nombre Prospecto', style: TextStyles.tStyleTileTitle2,),
                                subtitle:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Estatus: por verificar', style: TextStyles.tStyleTileSubtitle),
                                    Text(index % 2 == 0 ? 'por visitar' : 'visitado', style: TextStyles.tStyleTileSubtitle),
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
          )
        ]),
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
              Text('Gestiona tus propectos', style: TextStyles.tStyleGreyBase18,),
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

  Widget _actions(Size size, ProspectoBloc prospectoBloc){
    return Padding(
      padding: const EdgeInsets.only(top: 25,left: 20, right: 20),
      child: Row(
        children: [
          CustomElevatedButton(text: 'Nuevo Prospecto',onPressed: ()=>_displayBottomSheet(context, size, prospectoBloc),)
        ],
      ),
    );
  }

  Widget _verTodo(){
    return Padding(
      padding: const EdgeInsets.only(top: 0,left: 0, right: 00),
      child: Row(
        children: [
          CustomTextButton(onPressed: () => () =>{}, text: 'Ver más', color: ColorPalette.colorNegro, decorationColor: ColorPalette.colorNegro)
        ],
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context, Size size, ProspectoBloc prospectoBloc)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.note_alt_outlined, size: 70, color: ColorPalette.colorPrincipal)),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('¿Como desea capturar al prospecto?.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
              child: CustomMaterialButton(text: 'Escanear INE', isNegative: true, widthContainer: size.width * .5, onPressed: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, 'ocrSolicitudProspecto');
              }),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
              child: CustomMaterialButton(text: 'Captura Manual', isNegative: true, widthContainer: size.width * .5, onPressed: (){
                prospectoBloc.add(NewProspecto(Prospecto()));
                Navigator.pop(context);
                Navigator.pushNamed(context, 'formSolicitudProspecto');
              }),
            ),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, height: 300);
  }
}