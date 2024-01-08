import 'package:flutter/material.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class FormSolicitudProspectoScreen extends StatefulWidget {
  const FormSolicitudProspectoScreen({super.key});

  @override
  State<FormSolicitudProspectoScreen> createState() => _FormSolicitudProspectoScreenState();
}

class _FormSolicitudProspectoScreenState extends State<FormSolicitudProspectoScreen> {
  int selectedPayment = 0;
  DateTime fechaAux = DateTime.now();
  TextEditingController dateInputController = TextEditingController();

  changeRadio(int index) => setState(() => selectedPayment = index);

  pickerFechaNacimiento() async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(fechaAux.year - 70, fechaAux.month, fechaAux.day),
      lastDate: DateTime(fechaAux.year - 20, fechaAux.month, fechaAux.day),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.es,
      titleText: '',
      confirmText: 'Seleccionar',
      cancelText: 'Cerrar',
      looping: true,
      textColor: const  Color.fromRGBO(255, 255, 255, 1),
      backgroundColor: const  Color.fromRGBO(9, 85, 179, 1),
      reverse: true
    );

    if (datePicked != null) {
      Intl.defaultLocale = 'es';
      var inputFormat = DateFormat('dd/MMMM/yyyy');
      dateInputController.text = inputFormat.format(datePicked);
    }else{
      final snackBar = SnackBar(content: Text("No se seleccionó fecha $datePicked"));
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double seperacion = 10;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(9, 85, 179, 1)
        ),
        backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
        title: const Center(child: Text('Solicitud - Prospecto', style: TextStyles.tStyleAppBar2,)),
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
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('INFORMACIÓN DEL PROSPECTO', style: TextStyles.tStyleNegritaStrngGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Nombre'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion), 
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Primer Apellido'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion), 
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Segundo Apellido'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  Container(padding: const EdgeInsets.only(left: 10), width: double.infinity, child: const Text('Sexo', style: TextStyles.tStyleNegritaGrey16,textAlign: TextAlign.start,)) ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRadioButton(radioName: 'Masculino', index: 0, selectedPayment: selectedPayment, onPressed: changeRadio,)
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomRadioButton(radioName: 'Femenino', index: 1, selectedPayment: selectedPayment, onPressed: changeRadio,)
                      )
                    ],
                  ),
                  const SizedBox(height: seperacion), 
                  TextFormField(
                    controller: dateInputController,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Fecha Nacimiento'),
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                    onTap: () => pickerFechaNacimiento(),
                  ),
                  const SizedBox(height: 50),
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('DOMICILIO', style: TextStyles.tStyleNegritaStrngGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Calle'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecorations.formInputDecoration(labelText: 'No Ext.'),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecorations.formInputDecoration(labelText: 'No Int.'),
                          textInputAction: TextInputAction.next,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Código Postal'),
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Colonia'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Delegación'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Ciudad'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Estado'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Teléfono Fijo'),
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    inputFormatters: [FormMasked.telMaskFormatter],
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Teléono Celular'),
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    inputFormatters: [FormMasked.telMaskFormatter],
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 50),
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('INFORMACIÓN ADICIONAL', style: TextStyles.tStyleNegritaStrngGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Observaciones', isLabel: true),
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
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
              Text('Guardar y Continuar ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(230, 230, 230, 1)),),
              Icon(Icons.arrow_forward_outlined, color: Color.fromRGBO(230, 230, 230, 1),)
            ],
          ), 
        ),
        onPressed: (){
      
        }
      ),
    );
  }
}