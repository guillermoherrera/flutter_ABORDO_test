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
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(9, 85, 179, 1),
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                color: Colors.white,
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
                    color: Color.fromRGBO(230, 230, 230, 1)
                  ),
                  backgroundColor: const Color.fromRGBO(9, 85, 179, 1),
                  title: const Text('Verificación', style: TextStyles.tStyleAppBar,),
                  elevation: 0,
                  actions: [
                    Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.10,),
                    const SizedBox(width: 10,),
                  ],
                ),
                _header(),
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
                                    splashColor: const Color.fromRGBO(209, 57, 41, 1),
                                    onTap: (){},
                                    child: ListTile(
                                      dense: true,
                                      leading:  Container(
                                        padding: const EdgeInsets.all(0),
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(230, 230, 230, 1),
                                          shape: BoxShape.circle
                                        ),
                                        child: const Icon(Icons.person, color: Color.fromRGBO(9, 85, 179, 1),)),
                                      title: const Text('Nombre Prospecto', style: TextStyles.tStyleTileTitle2,),
                                      subtitle: Column(
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
                ),
              ],
            ),
          )
        ]
      ),
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
            color: Colors.white,
            shape: BoxShape.circle
          ),
          child: const Icon(Icons.person, size: 40, color: Color.fromRGBO(9, 85, 179, 1)))
        ],
      ),
    );
  }

  Widget _verTodo(){
    return Padding(
      padding: const EdgeInsets.only(top: 0,left: 0, right: 00),
      child: Row(
        children: [
          CustomElevatedButton(text: 'Ver más',onPressed: (){},)
        ],
      ),
    );
  }
}