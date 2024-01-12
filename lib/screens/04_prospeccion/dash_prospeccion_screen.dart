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
              backgroundColor: Colors.white,
              boxShadowColor: Colors.black45,
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
                              splashColor: const Color.fromRGBO(209, 57, 41, 1),
                              onTap: (){},
                              child: ListTile(
                                dense: true,
                                leading:  Container(
                                  padding: const EdgeInsets.all(0),
                                  decoration: const BoxDecoration(
                                    //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                    shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.person, color: Color.fromRGBO(9, 85, 179, 1),)),
                                title: const Text('Nombre Prospecto', style: TextStyles.tStyleTileTitle2,),
                                subtitle: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Estatus: prospecto', style: TextStyles.tStyleTileSubtitle),
                                    Text('01/01/2000', style: TextStyles.tStyleTileSubtitle),
                                  ],
                                ),
                                trailing: const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(9, 85, 179, 1))),
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
              backgroundColor: Colors.white,
              boxShadowColor: Colors.black45,
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
                              splashColor: const Color.fromRGBO(209, 57, 41, 1),
                              onTap: (){},
                              child: ListTile(
                                dense: true,
                                leading:  Container(
                                  padding: const EdgeInsets.all(0),
                                  decoration:  BoxDecoration(
                                    //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                    color: index % 2 == 0 ? const Color.fromRGBO(230, 230, 230, 1) : const Color.fromRGBO(9, 85, 179, 1),
                                    shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.house, color: Color.fromRGBO(9, 85, 179, 1),)),
                                title: const Text('Nombre Prospecto', style: TextStyles.tStyleTileTitle2,),
                                subtitle:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Estatus: por verificar', style: TextStyles.tStyleTileSubtitle),
                                    Text(index % 2 == 0 ? 'por visitar' : 'visitado', style: TextStyles.tStyleTileSubtitle),
                                  ],
                                ),
                                trailing: const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(9, 85, 179, 1))),
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
            color: Colors.white,
            shape: BoxShape.circle
          ),
          child: const Icon(Icons.person, size: 40, color: Color.fromRGBO(9, 85, 179, 1)))
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
                  color: Colors.black,
                  decoration: TextDecoration.underline, 
                  decorationColor: Colors.black),
            ),
            onPressed: () {}),
        ],
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context, Size size, ProspectoBloc prospectoBloc)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.note_alt_outlined, size: 70, color: Color.fromRGBO(9, 85, 179, 1))),
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
            CustomMaterialButton(text: 'Escanear INE', isNegative: true, widthContainer: size.width * .5, onPressed: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, 'ocrSolicitudProspecto');
            }),
            const SizedBox(height: 2),
            CustomMaterialButton(text: 'Captura Manual', isNegative: true, widthContainer: size.width * .5, onPressed: (){
              prospectoBloc.add(NewProspecto(Prospecto()));
              Navigator.pop(context);
              Navigator.pushNamed(context, 'formSolicitudProspecto');
            }),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget);
  }
}