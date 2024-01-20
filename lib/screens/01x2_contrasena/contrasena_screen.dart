import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/01x2_contrasena/form_contrasena.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/screens/01x2_contrasena/form_recuperar.dart';
//import 'package:flutter_application_2/screens/01x2_contrasena/form_contrasena.dart';

import '../../ui/ui_files.dart';
import '../../widgets/widgets.dart';

class ContrasenaScreen extends StatelessWidget {
  const ContrasenaScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final activarCubit = context.watch<ContrasenaCubit>();
    final isCodeSend = activarCubit.state.isCodeSend;
    final codigo = activarCubit.state.codigo;
    final loading = activarCubit.state.loading;
    
    return Scaffold(
      body: AuthBackground(
          header: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                CardContainer(
                    child: Column(
                  children: [
                    codigo.length == 6 ? const ContrasenaForm() :  const RecuperarContrasenaForm(),
                    const SizedBox(height: 20),
                    isCodeSend || loading ? Container() : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Ya sé mi contraseña. ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
                        CustomTextButton(onPressed: () => Navigator.pop(context), text: 'Iniciar sesión'),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
