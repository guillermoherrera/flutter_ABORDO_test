import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/helpers/form_validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_application_2/ui/input_decorations.dart';

class RecuperarContrasenaForm extends StatefulWidget {
  const RecuperarContrasenaForm({super.key});

  @override
  State<RecuperarContrasenaForm> createState() => _RecuperarContrasenaFormState();
}

class _RecuperarContrasenaFormState extends State<RecuperarContrasenaForm> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isVAlid = false;
  bool isCodeSend = false;
  
  @override
  Widget build(BuildContext context) {
    
    final contrasenaCubit = context.watch<ContrasenaCubit>();
    // final usuario = contrasenaCubit.state.usuario;
    // final telefono = contrasenaCubit.state.telefono;
    // final codigo = contrasenaCubit.state.codigo;

    submitSolicitarRecuperacion() async {
      FocusScope.of(context).unfocus();
      if(!formKey.currentState!.validate()) return;
      setState(() {
        loading = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        loading = false;
        isCodeSend = true;
      });
      contrasenaCubit.isCodeSendChanged(isCodeSend);
      await Future.delayed(const Duration(seconds: 1));
      if(context.mounted) await _displayBottomSheetSms(context);

    }
    
    submitContrasena() async {
      FocusScope.of(context).unfocus();
      
      //if(contrasenaCubit.onSubmitRecuperacion()){
        setState(() {
          loading = true;
        });
        await Future.delayed(const Duration(seconds: 3));
        //cambiar al form a contraseña
        setState(() {
          loading = false;
        });
      //}
    }

    return Form(
      child: Column(
        children: [
          const Text('Recuperar Contraseña', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
          const SizedBox(height: 50),
          TextFormField(
            enabled: !loading && !isVAlid,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Usuario',
                prefixIcon: null),
            //onChanged: (value) => contrasenaCubit.usuarioChanged(value),
            validator: (value) => FormValidators.existValidator(value),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: !loading && !isVAlid,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Teléfono',
                prefixIcon: null),
            //onChanged: (value) => contrasenaCubit.telefonoChanged(value),
            validator: (value) => FormValidators.lengthValidator(value, 10),
            onFieldSubmitted: (value) => submitSolicitarRecuperacion() ,
          ),
          !isCodeSend ? Container() : TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight
              ),
            child: const Align(alignment: Alignment.topRight ,child: Text('Corregir Datos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)),
            onPressed: () => _displayBottomSheet(context),  
          ),
          const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : TextFormField(
            enabled: !loading,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 8,
            decoration: InputDecorations.authInputDecoration(
                hintText: '_ _ _ _ _ _ _ _',
                labelText: 'Código',
                prefixIcon: null),
            //onChanged: (value) => contrasenaCubit.codigoChanged(value),
            validator: (value) => FormValidators.lengthValidator(value, 8),
            onFieldSubmitted: (value) => submitContrasena() ,
          ),
          !isCodeSend ? Container() : const Text('* Ingresa aquí el código de recuperación recibido', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.justify,),
          !isCodeSend ? Container() : const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Validar código' : 'Procesando', 
            loading: loading,
            onPressed: () => submitContrasena()),
          isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Solicitar recuperación' : 'Solicitando', 
            loading: loading,
            onPressed: () => submitSolicitarRecuperacion())
        ],
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.error_outline, size: 70, color:  Color.fromRGBO(209, 57, 41, 1))),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('¿Desea borrar los datos capturados para volver a solicitar el código?.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomMaterialButton(text: 'No, volver', isNegative: true, onPressed: () => Navigator.pop(context)),
            CustomMaterialButton(text: 'Si, borrar', onPressed: () => Navigator.pushReplacementNamed(context, 'contrasena')),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget);
  }

  Future _displayBottomSheetSms(BuildContext context)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.sms, size: 70, color: Color.fromRGBO(9, 85, 179, 1))),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('Se ha enviado un código de recuperación al teléfono captaurado.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Center(child: CustomMaterialButton(text: 'Enterado', onPressed: () => Navigator.pop(context)))
      ],
    );
    
    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, isDismissible: false);
  }
}
