import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import '../../models/models.dart';
import '../../services/api_services.dart';
import '../../ui/ui_files.dart';

class RecuperarContrasenaForm extends StatefulWidget {
  const RecuperarContrasenaForm({super.key});

  @override
  State<RecuperarContrasenaForm> createState() => _RecuperarContrasenaFormState();
}

class _RecuperarContrasenaFormState extends State<RecuperarContrasenaForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userCtrlr = TextEditingController();
  TextEditingController telCtrlr = TextEditingController();
  TextEditingController codCtrlr = TextEditingController();
  bool loading = false;
  bool isVAlid = false;
  bool isCodeSend = false;
  late FocusNode focusNode;
  late FocusNode focusCode;
  Timer? timer;
  int start = 0;
  String? codigoApi = '';
  final _apiCV = ApiService();

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
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final contrasenaCubit = context.watch<ContrasenaCubit>();
    // final usuario = contrasenaCubit.state.usuario;
    //final telefono = contrasenaCubit.state.telefono;
    // final codigo = contrasenaCubit.state.codigo;

    submitSolicitarRecuperacion() async {
      FocusScope.of(context).unfocus();
      
      if(!formKey.currentState!.validate()) return;
      setState(() {loading = true;});
      contrasenaCubit.loadingChanged(loading);
      await Future.delayed(const Duration(seconds: 1));
      codCtrlr = TextEditingController();
      await _apiCV.recuperacionCodigo(int.parse(userCtrlr.text), telCtrlr.text.replaceAll(RegExp(r'[^0-9]'),'')).then((ActivacionCodigo res)async{
        if(res.error == 0){
          setState(() {
            isVAlid = true;
            isCodeSend = true;
            codigoApi = res.data?.codigo;
          });
          contrasenaCubit.isCodeSendChanged(isCodeSend);
          await Future.delayed(const Duration(milliseconds: 500));
          if(context.mounted) FocusScope.of(context).requestFocus(focusCode);
          await Future.delayed(const Duration(milliseconds: 500));
          if(context.mounted) showCustomSnackBar(context);
        }else{
          DialogHelper.exit(context, res.resultado!);
        }        
      }).catchError((e){
        DialogHelper.exit(context, e.toString());
      });
      setState(() {loading = false;});
      contrasenaCubit.loadingChanged(loading);
    }
    
    submitRecuperacion() async {
      FocusScope.of(context).unfocus();
      if(!formKey.currentState!.validate()) return;

      if(codigoApi != codCtrlr.text){
        DialogHelper.exit(context, 'El CÓDIGO QUE INGRESASTE NO ES CORRECTO.');
        return;
      }

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
      //contrasenaCubit.deleteActivarState();
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text('Recuperar Contraseña', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
          const SizedBox(height: 50),
          TextFormField(
            controller: userCtrlr,
            enabled: !loading && !isVAlid,
            style: const TextStyle(color: ColorPalette.colorPrincipalMedio, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Nº Empleado',
                prefixIcon: null, iconField: Icons.numbers),
            //onChanged: (value) => contrasenaCubit.usuarioChanged(value),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (value) => FormValidators.existValidator(value),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: telCtrlr,
            enabled: !loading && !isVAlid,
            focusNode: focusNode,
            style: const TextStyle(color: ColorPalette.colorPrincipalMedio, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 15,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Teléfono',
                prefixIcon: null, iconField: Icons.phone_iphone_outlined),
            onChanged: (value) => contrasenaCubit.telefonoChanged(value),
            validator: (value){
              return FormValidators.telValidator(value?.replaceAll(RegExp('[^0-9]'), ''));
            },
            inputFormatters: [FormMasked.telMaskFormatter],
            onFieldSubmitted: (value) => _displayBottomSheetCode(context, contrasenaCubit, submitSolicitarRecuperacion),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Text('El teléfoo celular debe ser el mismo que proporcionaste cuando se te registró en sistema, puedes consultarlo en sucursal si lo necesitas.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco), textAlign: TextAlign.justify,),
          ),
          !isCodeSend ? Container() :  Align(alignment: Alignment.centerRight, child: CustomTextButton(onPressed: () => _displayBottomSheet(context, contrasenaCubit), text: 'Corregir Datos')),
          const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : const Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text('* Ingresa aquí el Código de Recuperación', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco), textAlign: TextAlign.justify,),
          ),
          !isCodeSend ? Container() : PinCodeTextField(
            controller: codCtrlr,
            appContext: context,
            enabled: !loading,
            focusNode: focusCode,
            errorTextSpace: 15,
            errorAnimationDuration: 500,
            textStyle: const TextStyle(
              color: ColorPalette.colorBlanco,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            obscureText: false,
            cursorColor: ColorPalette.colorBlanco,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 60,
              fieldWidth: 40,
              activeColor: ColorPalette.colorSecundario,
              inactiveColor: ColorPalette.colorBlanco,
              selectedColor: ColorPalette.colorPrincipal,
              activeFillColor: ColorPalette.colorSecundario,
              selectedFillColor: ColorPalette.colorSecundario,
              inactiveFillColor: ColorPalette.colorSecundario,
              errorBorderColor: ColorPalette.colorBlanco,
              errorBorderWidth: 20
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: ColorPalette.colorTransparent,
            enableActiveFill: true,
            onCompleted: (v) {
              submitRecuperacion();
            },
            validator: (value) => FormValidators.lengthValidator(value, 6),
            onSubmitted: (value) => submitRecuperacion()
          ),
          !isCodeSend 
          ? Container() 
          : Align(
            alignment: Alignment.centerRight ,
            child: CustomTextButton(
              onPressed: start > 0 ? (){} : () async{
                setState(() {isCodeSend = false;});
                contrasenaCubit.isCodeSendChanged(isCodeSend);
                await Future.delayed(const Duration(milliseconds: 500));
                if(mounted)_displayBottomSheetCode(context, contrasenaCubit, submitSolicitarRecuperacion);
              },
              color: start > 0 ? ColorPalette.colorTerciarioMedio : ColorPalette.colorBlanco,
              decorationColor: start > 0 ? ColorPalette.colorPrincipal : ColorPalette.colorBlanco,
              text: 'Reenviar código ${start > 0 ? '(espera $start)' : ''}',
            )
          ),
          !isCodeSend ? Container() : const SizedBox(
            height: 40,
          ),
          !isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Continuar' : 'Procesando', 
            loading: loading,
            onPressed: loading ? null : () => submitRecuperacion()),
          isCodeSend ? Container() : CustomMaterialButton(
            text: !loading ? 'Solicitar Recuperación' : 'Solicitando', 
            loading: loading,
            onPressed: loading ? null : () => _displayBottomSheetCode(context, contrasenaCubit, submitSolicitarRecuperacion))
        ],
      ),
    );
  }

  Future _displayBottomSheetCode(BuildContext context, ContrasenaCubit contrasenaCubit, Function() submitSolicitarRecuperacion)async{
    if(!formKey.currentState!.validate()) return;
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.error_outline, size: 70, color:  ColorPalette.colorSecundario)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), 
          child: Text('¿Se enviará un código de recuperación al teléfono capturado ${contrasenaCubit.state.telefono}. Es correcto el número?.', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomMaterialButton(text: 'No, volver', isNegative: true, onPressed: (){
              setState(() {isVAlid = false;});
              Navigator.pop(context);
            }),
            CustomMaterialButton(text: 'Si, envíar', onPressed: () {
              setState(() {start = start + 120;});
              startTimer();
              focusCode = FocusNode();
              submitSolicitarRecuperacion();
              Navigator.pop(context);  
            }),
          ],
        )
      ],
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget);
  }

  Future _displayBottomSheet(BuildContext context, ContrasenaCubit contrasenaCubit)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.error_outline, size: 70, color:  ColorPalette.colorSecundario)),
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
                timer?.cancel();
              });
              contrasenaCubit.isCodeSendChanged(isCodeSend);
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

  Future _displayBottomSheetSuccess(BuildContext context, ContrasenaCubit contrasenaCubit)async{
    Widget widget = Column(
      children: [
        const SizedBox(height: 10),
        const Center(child: Icon(Icons.check_circle_outline, size: 70, color:  ColorPalette.colorSuccess)),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text('Enhorabuena! Ahora crea una contraseña para que puedas iniciar sesión.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
        ),
        const SizedBox(height: 20),
        Center(child: CustomMaterialButton(text: 'Continuar', onPressed: () {
          setState(() {
            isCodeSend = false;
            start = 0;
          });
          contrasenaCubit.isCodeSendChanged(isCodeSend);
          contrasenaCubit.origenChanged('recuperacion');
          contrasenaCubit.codigoChanged(codCtrlr.text);
          contrasenaCubit.usuarioChanged(userCtrlr.text);
          Navigator.pop(context);
        }))
      ],
    );
    
    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, isDismissible: false);
  }

  showCustomSnackBar(context) {
    SnackBar snackBar =  SnackBar(
      content: Text('Se ha enviado un código de recuperación al teléfono capturado.'.toUpperCase(),
          style: const TextStyle(color: ColorPalette.colorPrincipal, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
      backgroundColor: ColorPalette.colorTerciario,
      //dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10)   
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
