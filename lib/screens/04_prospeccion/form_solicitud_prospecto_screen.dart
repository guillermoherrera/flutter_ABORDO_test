import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final formKey = GlobalKey<FormState>();
  TextEditingController dateInputController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    final prospectoEBloc = BlocProvider.of<ProspectoBloc>(context, listen: false);
    String lol = prospectoEBloc.state.prospecto?.fechaNacimiento ?? '';
    dateInputController.text = lol;
  }

  pickerFechaNacimiento() async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(fechaAux.year - 70, fechaAux.month, fechaAux.day),
      lastDate: DateTime(fechaAux.year - 20, fechaAux.month, fechaAux.day),
      dateFormat: "dd-MM-yyyy",
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
      var inputFormat = DateFormat('dd/MM/yyyy');
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
    final prospectoBloc = context.watch<ProspectoBloc>();
    
    changeRadio(String sexo) => prospectoBloc.add(ChangeProspectoSexo(sexo));

    submit() async {
      FocusScope.of(context).unfocus();
      
      if(!formKey.currentState!.validate()){
        SnackBar snackBar =  SnackBar(
          content: Text('Por favor revisa el formulario, hay campos que no se han completado correctamente.'.toUpperCase(),
              style: const TextStyle(color: Color.fromRGBO(209, 57, 41, 1), fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
          backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            left: 10,
            right: 10)   
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      if(prospectoBloc.state.prospecto?.sexo == null || prospectoBloc.state.prospecto?.sexo == '' ){
        SnackBar snackBar =  SnackBar(
          content: Text('Por favor indica el sexo del prospecto.'.toUpperCase(),
              style: const TextStyle(color: Color.fromRGBO(209, 57, 41, 1), fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
          backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
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
      if(mounted) Navigator.pushNamed(context, 'formEvaluacionProspecto');
      setState(() => loading = false);
        
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(249, 251, 253, 1)
        ),
        backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
        surfaceTintColor: Colors.transparent,
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
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  prospectoBloc.state.prospecto?.image == null ? Container() : Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    width: double.infinity,
                    height: 100,
                    child: CircleAvatar(backgroundColor: Colors.transparent,child: ClipOval(child: Image.memory(prospectoBloc.state.prospecto!.image!,fit: BoxFit.cover, width: 100, height: 100,))),
                  ),
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('INFORMACIÓN DEL PROSPECTO', style: TextStyles.tStyleNegritaStrongGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Nombre'),
                    textInputAction: TextInputAction.next,
                    initialValue: prospectoBloc.state.prospecto?.nombre,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion), 
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Primer Apellido'),
                    textInputAction: TextInputAction.next,
                    initialValue: prospectoBloc.state.prospecto?.primerApellido,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion), 
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Segundo Apellido'),
                    textInputAction: TextInputAction.next,
                    initialValue: prospectoBloc.state.prospecto?.segundoApellido,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  Container(padding: const EdgeInsets.only(left: 10), width: double.infinity, child: const Text('Sexo', style: TextStyles.tStyleNegritaGrey16,textAlign: TextAlign.start,)) ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRadioSexoButton(radioName: 'Masculino', index: 'H', selectedPayment: prospectoBloc.state.prospecto?.sexo ?? '', onPressed: changeRadio,)
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomRadioSexoButton(radioName: 'Femenino', index: 'M', selectedPayment: prospectoBloc.state.prospecto?.sexo ?? '', onPressed: changeRadio,)
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
                    validator: (value) => FormValidators.existValidator(value),
                    readOnly: true,
                    onTap: () => pickerFechaNacimiento(),
                  ),
                  const SizedBox(height: 50),
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('DOMICILIO', style: TextStyles.tStyleNegritaStrongGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Calle'),
                    textInputAction: TextInputAction.next,
                    initialValue: prospectoBloc.state.prospecto?.calle,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
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
                          initialValue: prospectoBloc.state.prospecto?.noExterior,
                          validator: (value) => FormValidators.existValidator(value),
                          inputFormatters: [UpperCaseTextFormatter()]
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
                          decoration: InputDecorations.formInputDecoration(labelText: 'No Int.', hintText: 'Opcional'),
                          textInputAction: TextInputAction.next,
                          inputFormatters: [UpperCaseTextFormatter()]
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
                    initialValue: prospectoBloc.state.prospecto?.cp,
                    validator: (value) => FormValidators.existValidator(value),
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Colonia'),
                    textInputAction: TextInputAction.next,
                    initialValue: prospectoBloc.state.prospecto?.colonia,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Delegación', hintText: 'Opcional'),
                    textInputAction: TextInputAction.next,
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Ciudad'),
                    textInputAction: TextInputAction.next,
                    initialValue: prospectoBloc.state.prospecto?.ciudad,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Estado'),
                    textInputAction: TextInputAction.next,
                    initialValue: prospectoBloc.state.prospecto?.estado,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Teléfono Fijo', hintText: 'Opcional'),
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
                    decoration: InputDecorations.formInputDecoration(labelText: 'Teléfono Celular'),
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    inputFormatters: [FormMasked.telMaskFormatter],
                    validator: (value){
                      return FormValidators.telValidator(value?.replaceAll(RegExp('[^0-9]'), ''));
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 50),
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('INFORMACIÓN ADICIONAL', style: TextStyles.tStyleNegritaStrongGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Observaciones', isLabel: true, hintText: 'Opcional'),
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
                    inputFormatters: [UpperCaseTextFormatter()]
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
        onPressed: loading ? null : () => submit(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: loading ? const CircularProgressIndicator(color: Color.fromRGBO(230, 230, 230, 1),) : const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Guardar y Continuar ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(230, 230, 230, 1)),),
              Icon(Icons.arrow_forward_outlined, color: Color.fromRGBO(230, 230, 230, 1),)
            ],
          ), 
        )
      ),
    );
  }
}