import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/helpers/form_validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_application_2/ui/input_decorations.dart';

class ActivarForm extends StatefulWidget {
  const ActivarForm({super.key});

  @override
  State<ActivarForm> createState() => _ActivarFormState();
}

class _ActivarFormState extends State<ActivarForm> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isVAlid = false;
  bool isCodeSend = false;
  bool focusCode = false;
  bool focusTel = false;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final activarCubit = context.watch<ActivarCubit>();
    // final usuario = activarCubit.state.usuario;
    // final telefono = activarCubit.state.telefono;
    // final codigo = activarCubit.state.codigo;

    submitSolicitarActivacion() async {
      FocusScope.of(context).unfocus();
      
      if(!formKey.currentState!.validate()) return;
      setState(() {
        loading = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        loading = false;
        isVAlid = true;
        isCodeSend = true;
        focusCode = true;
      });
      activarCubit.isCodeSendChanged(isCodeSend);
      await Future.delayed(const Duration(milliseconds: 1000));
      if(context.mounted) showCustomSnackBar(context);
    }
    
    submitActivacion() async {
      FocusScope.of(context).unfocus();
      
      if(!formKey.currentState!.validate()) return;
      setState(() {
        loading = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      if(context.mounted) await _displayBottomSheetSucces(context);
      setState(() {
        loading = false;
      });
      //activarCubit.deleteActivarState();
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text('Activar Cuenta', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
          const SizedBox(height: 50),
          TextFormField(
            enabled: !loading && !isVAlid,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Usuario',
                prefixIcon: null),
            //onChanged: (value) => activarCubit.usuarioChanged(value),
            textInputAction: TextInputAction.next,
            validator: (value) => FormValidators.existValidator(value),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: !loading && !isVAlid,
            focusNode: focusNode,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Teléfono',
                prefixIcon: null),
            //onChanged: (value) => activarCubit.telefonoChanged(value),
            validator: (value) => FormValidators.lengthValidator(value, 10),
            onFieldSubmitted: (value) => submitSolicitarActivacion() ,
          ),
          !isCodeSend ? Container() : TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight
              ),
            child: const Align(alignment: Alignment.topRight ,child: Text('Corregir Datos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)),
            onPressed: () => _displayBottomSheet(context, activarCubit),  
          ),
          const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : TextFormField(
            autofocus: focusCode,
            enabled: !loading,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 8,
            decoration: InputDecorations.authInputDecoration(
                hintText: '_ _ _ _ _ _ _ _',
                labelText: 'Código',
                prefixIcon: null),
            //onChanged: (value) => activarCubit.codigoChanged(value),
            validator: (value)=>FormValidators.lengthValidator(value, 8),
            onFieldSubmitted: (value) => submitActivacion() ,
          ),
          !isCodeSend ? Container() : const Text('* Ingresa aquí el código de activación recibido', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.justify,),
          !isCodeSend ? Container() : const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Activar' : 'Activando', 
            loading: loading,
            onPressed: () => submitActivacion()),
          isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Solicitar Activación' : 'Solicitando', 
            loading: loading,
            onPressed: () => submitSolicitarActivacion())
        ],
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context, ActivarCubit activarCubit)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.error_outline, size: 70, color:  Color.fromRGBO(209, 57, 41, 1))),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('¿Desea editar los datos capturados para volver a solicitar el código?.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomMaterialButton(text: 'No, volver', isNegative: true, onPressed: () => Navigator.pop(context)),
            CustomMaterialButton(text: 'Si, editar', onPressed: ()async{
              setState(() {
                isVAlid = false;
                isCodeSend = false;
                focusTel = true;
              });
              activarCubit.isCodeSendChanged(isCodeSend);
              Navigator.pop(context);
              await Future.delayed(const Duration(seconds: 1));
              if(context.mounted) FocusScope.of(context).requestFocus(focusNode);
            }),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget);
  }

  Future _displayBottomSheetSucces(BuildContext context)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.check_circle_outline, size: 70, color:  Colors.green)),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('Enhorabuena! Se ha activado el usuario, ahora puedes iniciar sesión.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Center(child: CustomMaterialButton(text: 'Continuar', onPressed: () => Navigator.pushReplacementNamed(context, 'login')))
      ],
    );
    
    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, isDismissible: false);
  }

  showCustomSnackBar(context) {
    SnackBar snackBar =  SnackBar(
      content: Text('Se ha enviado un código de activación al teléfono captaurado.'.toUpperCase(),
          style: const TextStyle(color: Color.fromRGBO(50, 73, 137, 1), fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
      backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
      //dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10)   
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
