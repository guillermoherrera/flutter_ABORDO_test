import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_application_2/ui/input_decorations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ActivarForm extends StatefulWidget {
  const ActivarForm({super.key});

  @override
  State<ActivarForm> createState() => _ActivarFormState();
}

class _ActivarFormState extends State<ActivarForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController codigoController = TextEditingController();
  bool loading = false;
  bool isVAlid = false;
  bool isCodeSend = false;
  late FocusNode focusNode;
  late FocusNode focusCode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusCode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    focusCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contrasenaCubit = context.watch<ContrasenaCubit>();
    final activarCubit = context.watch<ActivarCubit>();
    // final usuario = activarCubit.state.usuario;
    //final telefono = activarCubit.state.telefono;
    // final codigo = activarCubit.state.codigo;

    submitSolicitarActivacion() async {
      FocusScope.of(context).unfocus();
      
      if(!formKey.currentState!.validate()) return;
      setState(() {
        loading = true;
      });
      activarCubit.loadingChanged(loading);
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        loading = false;
        isVAlid = true;
        isCodeSend = true;
      });
      activarCubit.loadingChanged(loading);
      activarCubit.isCodeSendChanged(isCodeSend);
      await Future.delayed(const Duration(milliseconds: 500));
      if(context.mounted) FocusScope.of(context).requestFocus(focusCode);
      await Future.delayed(const Duration(milliseconds: 500));
      if(context.mounted) showCustomSnackBar(context);
    }
    
    submitActivacion() async {
      FocusScope.of(context).unfocus();
      
      if(!formKey.currentState!.validate()) return;
      setState(() {
        loading = true;
      });
      activarCubit.loadingChanged(loading);
      await Future.delayed(const Duration(seconds: 3));
      if(context.mounted) await _displayBottomSheetSuccess(context, activarCubit, contrasenaCubit);
      setState(() {
        loading = false;
      });
      activarCubit.loadingChanged(loading);
      //activarCubit.deleteActivarState();
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text('Activar Cuenta', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text('* Recuerda que solo podrás iniciar sesión desde este dispositivo una vez termines la activación.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.justify,),
          ),
          const SizedBox(height: 20),
          TextFormField(
            enabled: !loading && !isVAlid,
            style: const TextStyle(color: Color.fromRGBO(4, 68, 155, 1), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Usuario',
                prefixIcon: null),
            //onChanged: (value) => activarCubit.usuarioChanged(value),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (value) => FormValidators.existValidator(value),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: !loading && !isVAlid,
            focusNode: focusNode,
            style: const TextStyle(color: Color.fromRGBO(4, 68, 155, 1), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 15,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Teléfono',
                prefixIcon: null, iconField: Icons.phone_iphone_outlined),
            onChanged: (value) => activarCubit.telefonoChanged(value),
            validator: (value){
              return FormValidators.telValidator(value?.replaceAll(RegExp('[^0-9]'), ''));
            },
            inputFormatters: [FormMasked.telMaskFormatter],
            onFieldSubmitted: (value) => _displayBottomSheetCode(context, activarCubit, submitSolicitarActivacion),
          ),
          !isCodeSend ? Container() : TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight
              ),
            onPressed: loading ? null : () => _displayBottomSheet(context, activarCubit),  
            child: const Align(alignment: Alignment.topRight ,child: Text('Corregir Datos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
          const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : const Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text('* Ingresa aquí el Código de Activación', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.justify,),
          ),
          !isCodeSend ? Container() : PinCodeTextField(
            controller: codigoController,
            appContext: context,
            enabled: !loading,
            focusNode: focusCode,
            errorTextSpace: 15,
            errorAnimationDuration: 500,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            obscureText: false,
            cursorColor: Colors.white,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 60,
              fieldWidth: 40,
              activeColor: const Color.fromRGBO(209, 57, 41, 1),
              inactiveColor: Colors.white,
              selectedColor: const Color.fromRGBO(9, 85, 179, 1),
              activeFillColor: const Color.fromRGBO(209, 57, 41, 1),
              selectedFillColor: const Color.fromRGBO(209, 57, 41, 1),
              inactiveFillColor: const Color.fromRGBO(209, 57, 41, 1),
              errorBorderColor: Colors.white,
              errorBorderWidth: 20
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            onCompleted: (v) {
              submitActivacion();
            },
            validator: (value) => FormValidators.lengthValidator(value, 6),
            onSubmitted: (value) => submitActivacion()
          ),
          !isCodeSend ? Container() : TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight
              ),
            onPressed: loading ? null : () => _displayBottomSheetCode(context, activarCubit, submitSolicitarActivacion),
            child: const Align(alignment: Alignment.topRight ,child: Text('Reenviar código', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)),  
          ),
          !isCodeSend ? Container() : const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Activar' : 'Activando', 
            loading: loading,
            onPressed: loading ? null : () => submitActivacion()),
          isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Solicitar Activación' : 'Solicitando', 
            loading: loading,
            onPressed: loading ? null : () => _displayBottomSheetCode(context, activarCubit, submitSolicitarActivacion))
        ],
      ),
    );
  }

  Future _displayBottomSheetCode(BuildContext context, ActivarCubit activarCubit, Function() submitSolicitarActivacion)async{
    if(!formKey.currentState!.validate()) return;
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.error_outline, size: 70, color:  Color.fromRGBO(209, 57, 41, 1))),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), 
          child: Text('¿Se enviará un código de activación al teléfono ${activarCubit.state.telefono}. Es correcto el número?.', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomMaterialButton(text: 'No, corregir', isNegative: true, onPressed: () => Navigator.pop(context)),
            CustomMaterialButton(text: 'Si, envíar', onPressed: () {
              focusCode = FocusNode();
              submitSolicitarActivacion();
              Navigator.pop(context);  
            }),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget);
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
              });
              activarCubit.isCodeSendChanged(isCodeSend);
              Navigator.pop(context);
              await Future.delayed(const Duration(milliseconds: 500));
              if(context.mounted) FocusScope.of(context).requestFocus(focusNode);
            }),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget);
  }

  Future _displayBottomSheetSuccess(BuildContext context, ActivarCubit activarCubit, ContrasenaCubit contrasenaCubit)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.check_circle_outline, size: 70, color:  Colors.green)),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('Enhorabuena! Se ha activado tu usuario, ahora crea una contraseña y podrás iniciar sesión.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Center(child: CustomMaterialButton(text: 'Crear Contraseña', onPressed: () {
          setState(() {
            isCodeSend = false;
          });
          activarCubit.isCodeSendChanged(isCodeSend);
          contrasenaCubit.isCodeSendChanged(isCodeSend);
          contrasenaCubit.codigoChanged(codigoController.text);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'contrasena');
        }))
      ],
    );
    
    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, isDismissible: false);
  }

  showCustomSnackBar(context) {
    SnackBar snackBar =  SnackBar(
      content: Text('Se ha enviado un código de activación al teléfono capturado.'.toUpperCase(),
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
