import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

import '../../blocs/blocs.dart';

class FormEvaluacionProspectoScreen extends StatefulWidget {
  const FormEvaluacionProspectoScreen({super.key});

  @override
  State<FormEvaluacionProspectoScreen> createState() => _FormEvaluacionProspectoScreenState();
}

class _FormEvaluacionProspectoScreenState extends State<FormEvaluacionProspectoScreen> {
  int selectedPayment = -1;
  int selectedRequisitos = -1;
  int selectedEdad = -1;
  int selectedInteres = -1;
  int selectedAfiliado = -1;
  final formKey = GlobalKey<FormState>();
  final _limiteController = TextEditingController();
  final _saldoController = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s == '' ? '0' : s));
  final String _currency = NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  bool loading = false;

  changeRadio(int index) => setState(() => selectedPayment = index);
  changeRequisitos(int index) => setState(() => selectedRequisitos = index);
  changeEdad(int index) => setState(() => selectedEdad = index);
  changeInteres(int index) => setState(() => selectedInteres = index);
  changeAfiliado(int index) => setState(() => selectedAfiliado = index);

  @override
  void initState() {
    showSBprospecto();
    super.initState();
  }

  showSBprospecto() async{
    final prospectoEBloc = BlocProvider.of<ProspectoBloc>(context, listen: false);
    await Future.delayed(const Duration(seconds: 3));
    SnackBar snackBar =  SnackBar(
      content: Text('Prospecto registrado con Folio ${prospectoEBloc.state.prospecto?.folioRegistro ?? ''}'.toUpperCase(),
          style: const TextStyle(color: ColorPalette.colorPrincipal, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
      backgroundColor: ColorPalette.colorTerciario,
      //dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10)   
    );

    if(mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double seperacion = 40;

    submit() async {
      FocusScope.of(context).unfocus();

      if(!formKey.currentState!.validate()){
        SnackBar snackBar =  SnackBar(
          content: Text('Por favor revisa el formulario, hay campos que no se han completado correctamente.'.toUpperCase(),
              style: const TextStyle(color: ColorPalette.colorSecundario, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
          backgroundColor: ColorPalette.colorTerciario,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            left: 10,
            right: 10)   
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      if(selectedPayment == -1 || selectedRequisitos == -1 || selectedEdad == -1 || selectedInteres == -1 || selectedAfiliado == -1){
        
        String mensaje = selectedPayment == -1 ? 'Indica si esta Vencido de alguna Relacion?' : selectedRequisitos == -1 ? 'Indica si Reune los Requisitos?' : selectedEdad == -1 ? 'Indica si Cumple la Edad?' : selectedInteres == -1 ? 'Indica si Mostró Interés?' : selectedAfiliado == -1  ? 'Indica si Esta Afiliado?' : 'Contacta a soporte';
        
        SnackBar snackBar =  SnackBar(
          content: Text('$mensaje.'.toUpperCase(),
              style: const TextStyle(color: ColorPalette.colorSecundario, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
          backgroundColor: ColorPalette.colorTerciario,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            left: 10,
            right: 10)   
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      setState(() => loading = true);
      await Future.delayed(const Duration(seconds: 3));
      //if(mounted) Navigator.pushNamed(context, 'dashProspeccion');
      if(mounted) Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SuccessEvalScreen() ));
      setState(() => loading = false);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorPalette.colorBlanco
        ),
        backgroundColor: ColorPalette.colorTerciario,
        surfaceTintColor: ColorPalette.colorTransparent,
        title: const Center(child: Text('Solicitud - Evaluación', style: TextStyles.tStyleAppBar2,)),
        elevation: 0,
        actions: [
          Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.10,),
          const SizedBox(width: 10,),
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        )
      ),
      body: Container(
        color: ColorPalette.colorBlanco,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('EVALUACIÓN', style: TextStyles.tStyleNegritaStrongGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  SizedBox(width: double.infinity, child: Text('¿Cual Es Su Antigüedad Como Distribuidora?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Antigüedad', isDense: true, suffixText: 'Año(s)'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                    validator: (value) => FormValidators.existValidator(value),
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Límite De Crédito Mayor Que Maneja?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  TextFormField(
                    controller: _limiteController,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Límite', isDense: true, prefixText: _currency),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                    onChanged: (string) {
                      string = _formatNumber(string.replaceAll(',', ''));
                      _limiteController.value = TextEditingValue(
                        text: string,
                        selection: TextSelection.collapsed(offset: string.length),
                      );
                    },
                    validator: (value) => FormValidators.existValidator(value),
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Saldo Mayor Como Distribuiora?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  TextFormField(
                    controller: _saldoController,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Saldo', isDense: true, prefixText: _currency),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                    onChanged: (string) {
                      string = _formatNumber(string.replaceAll(',', ''));
                      _saldoController.value = TextEditingValue(
                        text: string,
                        selection: TextSelection.collapsed(offset: string.length),
                      );
                    },
                    validator: (value) => FormValidators.existValidator(value),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Vencido De Alguna Relación?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRadioButton(radioName: 'No', index: 0, selectedPayment: selectedPayment, onPressed: changeRadio,)
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomRadioButton(radioName: 'Sí', index: 1, selectedPayment: selectedPayment, onPressed: changeRadio,)
                      )
                    ],
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Cuantos Clientes Cautivos Tiene?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Clientes', isDense: true),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                    validator: (value) => FormValidators.existValidator(value),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Reune Todos Los Requisitos?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRadioButton(radioName: 'No', index: 0, selectedPayment: selectedRequisitos, onPressed: changeRequisitos,)
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomRadioButton(radioName: 'Sí', index: 1, selectedPayment: selectedRequisitos, onPressed: changeRequisitos,)
                      )
                    ],
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', isLabel: true, hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Cumple Con La Edad Para Afiliarse (De 25 A 65 Años)?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRadioButton(radioName: 'No', index: 0, selectedPayment: selectedEdad, onPressed: changeEdad,)
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomRadioButton(radioName: 'Sí', index: 1, selectedPayment: selectedEdad, onPressed: changeEdad,)
                      )
                    ],
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Mostró Interés Al Afiliarse?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRadioButton(radioName: 'No', index: 0, selectedPayment: selectedInteres, onPressed: changeInteres,)
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomRadioButton(radioName: 'Sí', index: 1, selectedPayment: selectedInteres, onPressed: changeInteres,)
                      )
                    ],
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  SizedBox(width: double.infinity, child: Text('¿Esta Afiliado A Otra Empresa De Vales?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRadioButton(radioName: 'No', index: 0, selectedPayment: selectedAfiliado, onPressed: changeAfiliado,)
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomRadioButton(radioName: 'Sí', index: 1, selectedPayment: selectedAfiliado, onPressed: changeAfiliado,)
                      )
                    ],
                  ),
                  const SizedBox(height: seperacion/10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Comentario', hintText: '(Opcional)', isDense: true),
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MaterialButton(
        minWidth: size.width * 1,
        disabledColor: ColorPalette.colorTerciarioMedio,
        elevation: 0,
        color: ColorPalette.colorSuccess,
        onPressed: loading ? null : () => submit(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: loading ? const CircularProgressIndicator(color: ColorPalette.colorTerciario,) : const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Guardar Evaluación ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
              Icon(Icons.check_outlined, color: ColorPalette.colorBlanco,)
            ],
          ), 
        )
      ),
    );
  }
}

class SuccessEvalScreen extends StatelessWidget {
  const SuccessEvalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorPalette.colorTerciario,
          actions: [
          Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.10,),
            const SizedBox(width: 10,),
          ],
          title: const Center(child: Text('', style: TextStyles.tStyleNegritaGrey16,))),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.fact_check_outlined, size: 180, color: ColorPalette.colorPrincipal,),
                const Text('Bien hecho !', style: TextStyles.tStyleNegrita24),
                const Text('El prospecto y su evaluación se han registrado correctamente.', style: TextStyles.tStyleNegrita16, textAlign: TextAlign.center,),
                const SizedBox(height: 20),
                const Text('Ahora puedes ir a la pantalla de Prospección para dar seguimiento y gestionar tus prospectos registrados.', style: TextStyles.tStyleNegritaGrey14, textAlign: TextAlign.center),
                const SizedBox(height: 30),
                CustomElevatedButton(text: 'Continuar',onPressed: (){
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                }) //Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false)) //Navigator.pushReplacementNamed(context, 'dashProspeccion'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  showCustomSnackBar(context) {
    final prospectoEBloc = BlocProvider.of<ProspectoBloc>(context, listen: false);
    
    SnackBar snackBar =  SnackBar(
      content: Text('Prospecto registrado con Folio ${prospectoEBloc.state.prospecto?.folioRegistro ?? ''}'.toUpperCase(),
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