import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class DashVerificacionScreen extends StatefulWidget {
  const DashVerificacionScreen({super.key});

  @override
  State<DashVerificacionScreen> createState() => _DashVerificacionScreenState();
}

class _DashVerificacionScreenState extends State<DashVerificacionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final infoBloc = context.watch<InfoUsuarioBloc>();
    final prospectosListaBloc = context.watch<ProspectosObtenerListaBloc>();
    
    return Scaffold(
      body: CustomBackground(
        appBarTitle: 'Verificación',
        content: Column(
          children: [
            _header(infoBloc),
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
                        const Text('Verificaciones', style: TextStyles.tStyleNegrita16,),
                        _verTodo()
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.6,
                      child: (prospectosListaBloc.state.prospectosLista?.data?.length ?? 0) == 0 
                      ? const EmptyWidget()
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: (prospectosListaBloc.state.prospectosLista?.data?.length ?? 0) >= 10 ? 10 : prospectosListaBloc.state.prospectosLista?.data?.length ?? 0 ,
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
                                  title: Text(prospectosListaBloc.state.prospectosLista?.data?[index].nombre ?? '', style: TextStyles.tStyleTileTitle2,),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(prospectosListaBloc.state.prospectosLista?.data?[index].descClienteStat ?? '', style: TextStyles.tStyleTileSubtitle),
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
  
  Widget _header(infoBloc) {
    return  Padding(
      padding: const EdgeInsets.only(top: 25,left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('HOLA ${infoBloc.state.infoUsuario?.data?.nombre ?? 'CARGANDO'} ${infoBloc.state.infoUsuario?.data?.apPaterno ?? 'USUARIO ...'}', style: TextStyles.tStyleGreyBase14,),
              const Text('Gestiona tus visitas', style: TextStyles.tStyleGreyBase18,),
            ],
          ),
          Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: ColorPalette.colorBlanco,
            shape: BoxShape.circle
          ),
          child: Icon(infoBloc.state.infoUsuario?.data?.sexo ?? false == true ? Icons.person : Icons.person_2, size: 40, color: ColorPalette.colorPrincipal))
        ],
      ),
    );
  }

  Widget _verTodo(){
    return Padding(
      padding: const EdgeInsets.only(top: 0,left: 0, right: 00),
      child: Row(
        children: [
          CustomTextButton(onPressed: ()async{
            await Future.delayed(const Duration(milliseconds: 500));
            if(context.mounted) Navigator.pushNamed(context, 'listProspectos');}, text: 'Ver más', color: ColorPalette.colorNegro, decorationColor: ColorPalette.colorNegro)
        ],
      ),
    );
  }
}