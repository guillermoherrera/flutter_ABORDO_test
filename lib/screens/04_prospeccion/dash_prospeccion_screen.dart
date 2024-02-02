import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/blocs.dart';
import '../../services/api_services.dart';

class DashProspeccionScreen extends StatefulWidget {
  const DashProspeccionScreen({super.key});

  @override
  State<DashProspeccionScreen> createState() => _DashProspeccionScreenState();
}

class _DashProspeccionScreenState extends State<DashProspeccionScreen> {
  final _apiCV = ApiService();
  bool loadingApi = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async{
    setState(() => loadingApi = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    await _apiCV.prospectosObtenerLista().then((ProspectosObtenerLista res)async{
      if(res.error == 0){
        final prospectosListaBloc = BlocProvider.of<ProspectosObtenerListaBloc>(context, listen: false);
        prospectosListaBloc.add(NewProspectosObtenerLista(res));
      }else{
        DialogHelper.exit(context, res.resultado!);
      }        
    }).catchError((e){
      DialogHelper.exit(context, e.toString());
    });
    setState(() => loadingApi = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final infoBloc = context.watch<InfoUsuarioBloc>();
    final prospectoBloc = context.watch<ProspectoBloc>();
    final prospectosListaBloc = context.watch<ProspectosObtenerListaBloc>();
    
    return Scaffold(
      body: CustomBackground(
        appBarTitle: 'Prospección',
        content: RefreshIndicator(
          onRefresh: () => getData(),
          child: Column(children: [
            _header(infoBloc),
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
                      child: loadingApi 
                      ? const Center(child: CircularProgressIndicator(color: ColorPalette.colorPrincipal))
                      : (prospectosListaBloc.state.prospectosLista?.data?.length ?? 0) == 0 
                      ? const EmptyWidget()
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: (prospectosListaBloc.state.prospectosLista?.data?.length ?? 0) >= 5 ? 5 : prospectosListaBloc.state.prospectosLista?.data?.length ?? 0 ,
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
                                    decoration: BoxDecoration(
                                      //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                      color: Color(int.parse('0xff${prospectosListaBloc.state.prospectosLista?.data?[index].color.replaceAll('#', '')}')),
                                      shape: BoxShape.circle
                                    ),
                                    child: const Icon(Icons.person, color: ColorPalette.colorBlanco,)),
                                  title: Text(prospectosListaBloc.state.prospectosLista?.data?[index].nombre ?? '', style: TextStyles.tStyleTileTitle2, overflow: TextOverflow.ellipsis,),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(prospectosListaBloc.state.prospectosLista?.data?[index].descClienteStat ?? '', style: TextStyles.tStyleTileSubtitle),
                                      Text(DateFormat('dd/MM/yyyy').format(prospectosListaBloc.state.prospectosLista?.data?[index].fechaRegistro ?? DateTime.now()), style: TextStyles.tStyleTileSubtitle),
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
                      child: (prospectosListaBloc.state.prospectosLista?.data?.where((i) => i.descClienteStat == 'PROSPECTO').toList().length ?? 0) == 0 
                      ? const EmptyWidget()
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: prospectosListaBloc.state.prospectosLista?.data?.where((i) => i.descClienteStat == 'PROSPECTO').toList().length,
                        itemBuilder: (context, index) {
                          if (prospectosListaBloc.state.prospectosLista?.data?[index].descClienteStat != 'PROSPECTO') return null;
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
                                    decoration: BoxDecoration(
                                      //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                      color: Color(int.parse('0xff${prospectosListaBloc.state.prospectosLista?.data?[index].color.replaceAll('#', '')}')),
                                      shape: BoxShape.circle
                                    ),
                                    child: const Icon(Icons.person, color: ColorPalette.colorBlanco,)),
                                  title: Text(prospectosListaBloc.state.prospectosLista?.data?[index].nombre ?? '', style: TextStyles.tStyleTileTitle2, overflow: TextOverflow.ellipsis),
                                  subtitle:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(prospectosListaBloc.state.prospectosLista?.data?[index].descClienteStat ?? '', style: TextStyles.tStyleTileSubtitle),
                                      const Text('', style: TextStyles.tStyleTileSubtitle),
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
              const Text('Gestiona tus propectos', style: TextStyles.tStyleGreyBase18,),
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
          CustomTextButton(onPressed: ()async{
            await Future.delayed(const Duration(milliseconds: 500));
            if(context.mounted) Navigator.pushNamed(context, 'listProspectos');}, text: 'Ver más', color: ColorPalette.colorNegro, decorationColor: ColorPalette.colorNegro)
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
              child: CustomMaterialButton(text: 'Escanear INE', isNegative: true, widthContainer: size.width * .5, onPressed: ()async{
                await Future.delayed(const Duration(milliseconds: 500));
                if(context.mounted){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'ocrSolicitudProspecto');
                }
              }),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
              child: CustomMaterialButton(text: 'Captura Manual', isNegative: true, widthContainer: size.width * .5, onPressed: ()async{
                prospectoBloc.add(NewProspecto(Prospecto()));
                await Future.delayed(const Duration(milliseconds: 500));
                if(context.mounted){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'formSolicitudProspecto');
                }
              }),
            ),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, height: 300);
  }
}