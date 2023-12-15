import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/input_decorations.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class ContrasenaForm extends StatelessWidget {
  const ContrasenaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text('Establecer Contraseña', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
          const SizedBox(height: 50),
          TextFormField(
            //enabled: !loading && !isVAlid,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Contraseña',
                prefixIcon: null,
                errorMessage: 'usuario.errorMessage'),
            //onChanged: (value) => activarCubit.usuarioChanged(value),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 40,
          ),
          CustomMaterialButton(
            text: 'Guardar Contraseña', 
            loading: false,
            onPressed: () => {})
        ],
      ),
    );
  }
}