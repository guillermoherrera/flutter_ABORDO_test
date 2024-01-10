import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class FormEvaluacionProspectoScreen extends StatefulWidget {
  const FormEvaluacionProspectoScreen({super.key});

  @override
  State<FormEvaluacionProspectoScreen> createState() => _FormEvaluacionProspectoScreenState();
}

class _FormEvaluacionProspectoScreenState extends State<FormEvaluacionProspectoScreen> {
  int selectedPayment = 0;
  int selectedRequisitos = 0;
  int selectedEdad = 0;
  int selectedInteres = 0;
  int selectedAfiliado = 0;
  final _limiteController = TextEditingController();
  final _saldoController = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  final String _currency = NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  
  changeRadio(int index) => setState(() => selectedPayment = index);
  changeRequisitos(int index) => setState(() => selectedRequisitos = index);
  changeEdad(int index) => setState(() => selectedEdad = index);
  changeInteres(int index) => setState(() => selectedInteres = index);
  changeAfiliado(int index) => setState(() => selectedAfiliado = index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double seperacion = 40;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(9, 85, 179, 1)
        ),
        backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
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
        color: Colors.white,
        child: Form(
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
                    decoration: InputDecorations.formInputDecoration(labelText: 'Antigüedad', isDense: true),
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
                  SizedBox(width: double.infinity, child: Text('¿Límite De Crédito Mayor Que Maneja?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
                  TextFormField(
                    controller: _limiteController,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Límite', isDense: true, prefixText: _currency),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (string) {
                      string = _formatNumber(string.replaceAll(',', ''));
                      _limiteController.value = TextEditingValue(
                        text: string,
                        selection: TextSelection.collapsed(offset: string.length),
                      );
                    },
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
                    onChanged: (string) {
                      string = _formatNumber(string.replaceAll(',', ''));
                      _saldoController.value = TextEditingValue(
                        text: string,
                        selection: TextSelection.collapsed(offset: string.length),
                      );
                    },
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
                  SizedBox(width: double.infinity, child: Text('¿Mostró Interes Al Afiliarse?', style: TextStyles.tStyleNegritaStrongGrey16,textAlign: TextAlign.start)),
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
        disabledColor: Colors.grey,
        elevation: 0,
        color: const Color.fromRGBO(9, 85, 179, 1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Guardar Evaluación ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(230, 230, 230, 1)),),
              Icon(Icons.check_outlined, color: Color.fromRGBO(230, 230, 230, 1),)
            ],
          ), 
        ),
        onPressed: (){
      
        }
      ),
    );
  }
}