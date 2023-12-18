import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/screens/01x1_activar/form_activar.dart';
import 'package:flutter_application_2/widgets/auth_backgrpund.dart';
import 'package:flutter_application_2/widgets/card_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivarScreen extends StatelessWidget {
  const ActivarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final activarCubit = context.watch<ActivarCubit>();
    final isCodeSend = activarCubit.state.isCodeSend;

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      isCodeSend ? Container() : TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          child: const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.underline, 
                                decorationColor: Colors.white),
                          ),
                          onPressed: () {
                            //activarCubit.deleteActivarState();
                            Navigator.pop(context);
                          }),
                      const SizedBox(height: 50),
                    ],
                  ))
                ],
              ),
            )),
      ),
    );
  }
}
