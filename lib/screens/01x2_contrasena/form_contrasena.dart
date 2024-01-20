import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/helpers/form_validators.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import '../../blocs/blocs.dart';
import '../../ui/ui_files.dart';


class ContrasenaForm extends StatefulWidget {
  const ContrasenaForm({super.key});

  @override
  State<ContrasenaForm> createState() => _ContrasenaFormState();
}

class _ContrasenaFormState extends State<ContrasenaForm> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    final contrasenaCubit = context.watch<ContrasenaCubit>();
    final contrasena = contrasenaCubit.state.contrasena; 
    
    submitGuardarContrasena() async {
      FocusScope.of(context).unfocus();
      if(!formKey.currentState!.validate()) return;
      setState(() {
        loading = true;
      });
      contrasenaCubit.loadingChanged(loading);
      await Future.delayed(const Duration(seconds: 3));
      if(context.mounted) await _displayBottomSheetSuccess(context, contrasenaCubit);
      setState(() {
        loading = false;
      });
      contrasenaCubit.loadingChanged(loading);
    }

    chanceObscureText() => setState(()=>obscureText = !obscureText);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text('Establecer Contraseña', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
          const SizedBox(height: 20),
          const Icon(Icons.lock_open, size: 50, color: ColorPalette.colorBlanco),
          const SizedBox(height: 30),
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: ColorPalette.colorPrincipalMedio, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscureText,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                prefixIcon: null, suffixIconOnPressed: chanceObscureText, visibility: obscureText),
            onChanged: (value) => contrasenaCubit.contrasenaChanged(value),
            validator: (value)=> FormValidators.lengthValidator(value, 6),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: ColorPalette.colorPrincipalMedio, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscureText,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Confirmar Contraseña',
                prefixIcon: null, suffixIconOnPressed: chanceObscureText, visibility: obscureText),
            validator: (value){
              String? val;
              val = FormValidators.lengthValidator(value, 6);
              val ??= FormValidators.confirmValidator(value, contrasena);
              return val;
            },
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 40,
          ),
          CustomMaterialButton(
            text: !loading ? 'Guardar Contraseña' : 'Guardando', 
            loading: loading,
            onPressed: loading ? null : (){
              submitGuardarContrasena();
            })
        ],
      ),
    );
  }

  Future _displayBottomSheetSuccess(BuildContext context, ContrasenaCubit contrasenaCubit)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.check_circle_outline, size: 70, color:  ColorPalette.colorSuccess)),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('Felicidades! Ahora ya puedes iniciar sesión con tu Usuario y Contraseña cuando lo necesites.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Center(child: CustomMaterialButton(text: 'Continuar', onPressed: () {
          contrasenaCubit.contrasenaInitial();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'home');
        }))
      ],
    );
    
    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, isDismissible: false);
  }
}