import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/screens/01x1_activar/form_activar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';


class ActivarScreen extends StatelessWidget {
  const ActivarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final activarCubit = context.watch<ActivarCubit>();
    final isCodeSend = activarCubit.state.isCodeSend;
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
                    const ActivarForm(),
                    const SizedBox(height: 20),
                    isCodeSend || loading ? Container() : CustomTextButton(onPressed: ()async{
                      await Future.delayed(const Duration(milliseconds: 500));
                      if(context.mounted) Navigator.pop(context);}, text: 'Iniciar sesión'),
                    const SizedBox(height: 50),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
