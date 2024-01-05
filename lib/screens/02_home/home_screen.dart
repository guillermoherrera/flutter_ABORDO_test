import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/text_styles.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void onItemTapped(int index) {
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
          Navigator.pushReplacementNamed(context, 'login', arguments: 0);
          break;
        default:
          //Navigator.pushNamed(context, 'home', arguments: 0);
      }
    }

    return  Scaffold(
      body: HomeBackground(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CardContainer(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    title: Text('Bienvenido Guillermo Herrera', style: TextStyles.tStyleTileTitle,),
                    subtitle: Text('Empleado 001 - Corporativo Torreón', style: TextStyles.tStyleTileSubtitle),
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
                    ButtonCircle(icono: Icons.note_alt_outlined, texto: 'Prospección', enable: true, onTap: () => Navigator.pushNamed(context, 'dashProspeccion'),),
                    ButtonCircle(icono: Icons.fact_check_outlined, texto: 'Verificación', enable: true, onTap: () => Navigator.pushNamed(context, 'dashVerificacion')),
                    const ButtonCircle(icono: Icons.motorcycle_outlined, texto: 'Cobranza', enable: false),
                    const ButtonCircle(icono: Icons.monetization_on_outlined, texto: 'Claridad\nde Pago', enable: false),
                    const ButtonCircle(icono: Icons.school_outlined, texto: 'Capacitación', enable: false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Últimos Registros', style: TextStyles.tStyleNegrita12,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CardContainer(
                      backgroundColor: Colors.white,
                      paddingHorizontal: 0,
                      child: Material(
                        child: InkWell(
                          splashColor: const Color.fromRGBO(209, 57, 41, 1),
                          onTap: (){},
                          child: ListTile(
                            dense: true,
                            leading:  Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                color: Color.fromRGBO(9, 85, 179, 0.1),
                                shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.note_alt_outlined, color: Color.fromRGBO(9, 85, 179, 1),)),
                            title: const Text('Evento descripción', style: TextStyles.tStyleTileTitle2,),
                            subtitle: const Text('01/01/2000', style: TextStyles.tStyleTileSubtitle),
                            trailing: const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(9, 85, 179, 1))),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(209, 57, 41, 1),
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
          decoration: const BoxDecoration(
            color: Color.fromRGBO(9, 85, 179, 0.1),
            shape: BoxShape.circle
          ),
          child: const Icon(Icons.person, size: 100, color: Color.fromRGBO(9, 85, 179, 1)))
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