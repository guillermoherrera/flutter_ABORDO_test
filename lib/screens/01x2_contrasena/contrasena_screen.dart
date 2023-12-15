import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/contrasena/contrasena_cubit.dart';
//import 'package:flutter_application_2/screens/01x2_contrasena/form_contrasena.dart';
import 'package:flutter_application_2/screens/01x2_contrasena/form_recuperar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';

class ContrasenaScreen extends StatelessWidget {
  const ContrasenaScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    BlocProvider(
                      create: (context) => ContrasenaCubit(),
                      child: const RecuperarContrasenaForm(),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: const Text.rich(
                          TextSpan(
                            text: 'Ya sé mi contraseña. ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                  text: 'Iniciar sesión',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        onPressed: () => Navigator.pop(context)),
                    const SizedBox(height: 50),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
