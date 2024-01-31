import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../blocs/blocs.dart';
import '../../services/api_services.dart';
import '../../ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginBloc = context.watch<LoginBloc>();
    final apiCV = ApiService();

    void onItemTapped(int index) async{
      switch (index) {
        case 0:
          //Navigator.pushNamed(context, 'home', arguments: 0);
          break;
        case 1:
          _displayBottomSheetSuccess(context, size);
          //Navigator.pushNamed(context, 'home', arguments: 0);
          break;
        case 2:
          Navigator.pushNamed(context, 'notificaciones', arguments: 0);
          break;
        case 3:
          await Future.delayed(const Duration(milliseconds: 250));
          if(await apiCV.logout() && context.mounted){
            Navigator.pushReplacementNamed(context, 'login', arguments: 0);
          }
          break;
        default:
          Navigator.pushNamed(context, 'home', arguments: 0);
          break;
      }
    }

    return  Scaffold(
      body: HomeBackground(
        child: Column(
          children: [
            const SizedBox(height: 40),
            CardContainer(
              boxShadowColor: ColorPalette.colorShadow,
              backgroundColor: ColorPalette.colorBlanco,
              paddingHorizontal: 0,
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    title: FittedBox(child: Text('BIENVENID${loginBloc.state.login?.data?.sexo == true ? 'O' : 'A'} ${loginBloc.state.login?.data?.nombre} ${loginBloc.state.login?.data?.apPaterno}', style: TextStyles.tStyleTileTitle,)),
                    subtitle: Text('Inicio Sesión: ${DateFormat('dd-MM-yyyy hh:mm:ss').format(loginBloc.state.login!.data!.fechaLogin)}', style: TextStyles.tStyleTileSubtitle),
                    leading: Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.10,),
                  )
                ],
            ),),
            const SizedBox(height: 20),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 20,
                  children: [
                    ButtonCircle(icono: Icons.note_alt_outlined, texto: 'Prospección', enable: true, onTap: ()async{
                      await Future.delayed(const Duration(milliseconds: 500));
                      if(context.mounted) Navigator.pushNamed(context, 'dashProspeccion');}),
                    ButtonCircle(icono: Icons.fact_check_outlined, texto: 'Verificación', enable: true, onTap: ()async{
                      await Future.delayed(const Duration(milliseconds: 500));
                      if(context.mounted) Navigator.pushNamed(context, 'dashVerificacion');}),
                    const ButtonCircle(icono: Icons.motorcycle_outlined, texto: 'Cobranza', enable: false),
                    const ButtonCircle(icono: Icons.monetization_on_outlined, texto: 'Claridad\nde Pago', enable: false),
                    const ButtonCircle(icono: Icons.school_outlined, texto: 'Capacitación', enable: false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CardContainer(
              backgroundColor: ColorPalette.colorBlanco,
              boxShadowColor: ColorPalette.colorShadow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Últimas acciones', style: TextStyles.tStyleNegrita16,),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.45,
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
                                  child: const Icon(Icons.note_alt_outlined, color: ColorPalette.colorPrincipal,)),
                                title: const Text('Evento descripción', style: TextStyles.tStyleTileTitle2,),
                                subtitle: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
          ],
        )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Mi Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: 'Salir',
          ),
        ],
        selectedItemColor: ColorPalette.colorBlanco,
        unselectedItemColor: ColorPalette.colorBlanco,
        backgroundColor: ColorPalette.colorSecundario,
        onTap: onItemTapped,
      ),
    );
  }

  Future _displayBottomSheetSuccess(BuildContext context, Size size)async{
    Widget widget =  Column(
      children: [
        const SizedBox(height: 5),
        Center(child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: ColorPalette.colorPrincipal.withOpacity(0.1),
            shape: BoxShape.circle
          ),
          child: const Icon(Icons.person, size: 100, color: ColorPalette.colorPrincipal))
        ),
        const SizedBox(height: 5),
        const Center(
          child: Text('Guillermo Herrera R.', style: TextStyles.tStyleNegrita16),
        ),
        const Center(
          child: Text('Empleado 001 - Puesto', style: TextStyles.tStyleNormal14),
        ),
        const SizedBox(height: 10),
        const Divider(),
        detallePerfil('Plaza:', 'Plaza Nombre'),
        detallePerfil('Sucursal:', 'Sucursal Nombre'),
        detallePerfil('Jefe Comercial:', 'Nombre Jefe Comercial'),
        detallePerfil('Teléfono:', '(817) 111-11-11'),
      ]
    );
    
    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, height: size.height * 08);
  }

  Widget detallePerfil(String labelDetalle, String value){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(labelDetalle, style: TextStyles.tStyleNegrita14,),
              Text(value, style: TextStyles.tStyleNormal14,)
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}