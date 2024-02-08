import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_2/ui/ui_files.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

import '../../services/api_services.dart';

class FormSolicitudProspectoScreen extends StatefulWidget {
  const FormSolicitudProspectoScreen({super.key});

  @override
  State<FormSolicitudProspectoScreen> createState() => _FormSolicitudProspectoScreenState();
}

class _FormSolicitudProspectoScreenState extends State<FormSolicitudProspectoScreen> {
  int selectedPayment = 0;
  DateTime fechaAux = DateTime.now();
  DateTime fechaNac = DateTime.now();
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreCtrlr = TextEditingController();
  TextEditingController apPaternoCtrlr = TextEditingController();
  TextEditingController apMaternoCtrlr = TextEditingController();
  TextEditingController sexoCtrlr = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  TextEditingController calleCtrlr = TextEditingController();
  TextEditingController noExteriorCtrlr = TextEditingController();
  TextEditingController noInteriorCtrlr = TextEditingController();
  TextEditingController cpCtrlr = TextEditingController();
  TextEditingController coloniaCtrlr = TextEditingController();
  TextEditingController delegacionCtrlr = TextEditingController();
  TextEditingController ciudadCtrlr = TextEditingController();
  TextEditingController estadoCtrlr = TextEditingController();
  TextEditingController telFijoCtrlr = TextEditingController();
  TextEditingController telCelularCtrlr = TextEditingController();
  TextEditingController observacionCtrlr = TextEditingController();
  bool loading = false;
  final _apiCV = ApiService();

  @override
  void initState() {
    super.initState();
    final prospectoEBloc = BlocProvider.of<ProspectoBloc>(context, listen: false);
    String lol = prospectoEBloc.state.prospecto?.fechaNacimiento ?? '';
    dateInputController.text = lol;
    nombreCtrlr.text = prospectoEBloc.state.prospecto?.nombre ?? '';
    apPaternoCtrlr.text = prospectoEBloc.state.prospecto?.primerApellido ?? '';
    apMaternoCtrlr.text = prospectoEBloc.state.prospecto?.segundoApellido ?? '';
    calleCtrlr.text = prospectoEBloc.state.prospecto?.calle ?? '';
    noExteriorCtrlr.text = prospectoEBloc.state.prospecto?.noExterior ?? '';
    cpCtrlr.text = prospectoEBloc.state.prospecto?.cp ?? '';
    coloniaCtrlr.text = prospectoEBloc.state.prospecto?.colonia ?? '';
    delegacionCtrlr.text = prospectoEBloc.state.prospecto?.ciudad ?? '';
    ciudadCtrlr.text = prospectoEBloc.state.prospecto?.ciudad ?? '';
    estadoCtrlr.text = prospectoEBloc.state.prospecto?.estado ?? '';
  }

  pickerFechaNacimiento() async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(fechaAux.year - 99, fechaAux.month, fechaAux.day),
      lastDate: DateTime(fechaAux.year - 18, fechaAux.month, fechaAux.day),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.es,
      titleText: '',
      confirmText: 'Seleccionar',
      cancelText: 'Cerrar',
      looping: true,
      textColor: ColorPalette.colorBlanco,
      backgroundColor: ColorPalette.colorPrincipal,
      reverse: true
    );

    if (datePicked != null) {
      Intl.defaultLocale = 'es';
      var inputFormat = DateFormat('dd/MM/yyyy');
      dateInputController.text = inputFormat.format(datePicked);
      setState(() {fechaNac = datePicked;});
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

      if(prospectoBloc.state.prospecto?.sexo == null || prospectoBloc.state.prospecto?.sexo == '' ){
        SnackBar snackBar =  SnackBar(
          content: Text('Por favor indica el sexo del prospecto.'.toUpperCase(),
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

      final infoUsuarioBloc = BlocProvider.of<InfoUsuarioBloc>(context, listen: false);
      final prospectoEBloc = BlocProvider.of<ProspectoBloc>(context, listen: false);

      var inputFormat = DateFormat('yyyy-MM-dd');
      
      Prospecto newProspecto = Prospecto(
        nombre: nombreCtrlr.text,
        primerApellido: apPaternoCtrlr.text,
        segundoApellido: apMaternoCtrlr.text,
        sexo: prospectoEBloc.state.prospecto!.sexo,
        fechaNacimiento: inputFormat.format(fechaNac),
        calle: calleCtrlr.text,
        noExterior: noExteriorCtrlr.text,
        noInterior: noInteriorCtrlr.text,
        cp: cpCtrlr.text,
        colonia: coloniaCtrlr.text,
        delegacion: delegacionCtrlr.text,
        ciudad: ciudadCtrlr.text,
        estado: estadoCtrlr.text,
        telFijo: telFijoCtrlr.text.replaceAll(RegExp('[^0-9]'), ''),
        telCelular: telCelularCtrlr.text.replaceAll(RegExp('[^0-9]'), ''),
        observacion: observacionCtrlr.text
      );

      setState(() => loading = true);
      await Future.delayed(const Duration(seconds: 1));
      await _apiCV.prospectoRegistro(newProspecto, infoUsuarioBloc.state.infoUsuario?.data?.idNumPlaza ?? 0, infoUsuarioBloc.state.infoUsuario?.data?.idNumSucursal ?? 0).then((ProspectoRegistro res)async{
        if(res.error == 0){
          prospectoBloc.add(ChangeProspectofolioRegistro(res.data?.folioRegistro ?? 0));
          prospectoBloc.add(ChangeProspectoIdCliente(res.data?.idCliente ?? ''));

          _apiCV.prospectosObtenerLista().then((ProspectosObtenerLista res){
            if(res.error == 0){
              final prospectosListaBloc = BlocProvider.of<ProspectosObtenerListaBloc>(context, listen: false);
              prospectosListaBloc.add(NewProspectosObtenerLista(res));
            }        
          }).catchError((e){});

          _apiCV.logUsuario().then((LogUsuario res){
            if(res.error == 0){
              final logBloc = BlocProvider.of<LogUsuarioBloc>(context, listen: false);
              logBloc.add(NewLogUsuario(res));
            }       
          }).catchError((e){});

          if(mounted) Navigator.pushReplacementNamed(context, 'formEvaluacionProspecto');
        }else{
          DialogHelper.exit(context, res.resultado!);
        }        
      }).catchError((e){
        DialogHelper.exit(context, e.toString());
      });
      setState(() => loading = false);

    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorPalette.colorBlanco
        ),
        backgroundColor: ColorPalette.colorTerciario,
        surfaceTintColor: ColorPalette.colorTransparent,
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
        color: ColorPalette.colorBlanco,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // prospectoBloc.state.prospecto?.image == null ? Container() : Container(
                  //   margin: const EdgeInsets.only(bottom: 10.0),
                  //   height: 60,
                  //   width: 100,
                  //   child: Image.memory(prospectoBloc.state.prospecto!.image!,fit: BoxFit.cover),
                  // ),
                  Container(padding: const EdgeInsets.only(left: 0), width: double.infinity, child: Text('INFORMACIÓN DEL PROSPECTO', style: TextStyles.tStyleNegritaStrongGrey12,textAlign: TextAlign.start,)) ,
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    enabled: !loading,
                    controller: nombreCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Nombre'),
                    textInputAction: TextInputAction.next,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()],
                    autofocus: prospectoBloc.state.prospecto?.image == null,
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    enabled: !loading,
                    controller: apPaternoCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Primer Apellido'),
                    textInputAction: TextInputAction.next,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    enabled: !loading,
                    controller: apMaternoCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Segundo Apellido'),
                    textInputAction: TextInputAction.done,
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
                    enabled: !loading,
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
                    enabled: !loading,
                    controller: calleCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Calle'),
                    textInputAction: TextInputAction.next,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          enabled: !loading,
                          controller: noExteriorCtrlr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecorations.formInputDecoration(labelText: 'No Ext.'),
                          textInputAction: TextInputAction.next,
                          validator: (value) => FormValidators.existValidator(value),
                          inputFormatters: [UpperCaseTextFormatter()]
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          enabled: !loading,
                          controller: noInteriorCtrlr,
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
                    enabled: !loading,
                    controller: cpCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Código Postal'),
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    textInputAction: TextInputAction.next,
                    validator: (value) => FormValidators.existValidator(value),
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    enabled: !loading,
                    controller: coloniaCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Colonia'),
                    textInputAction: TextInputAction.next,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    enabled: !loading,
                    controller: delegacionCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Delegación', hintText: 'Opcional'),
                    textInputAction: TextInputAction.next,
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    enabled: !loading,
                    controller: ciudadCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Ciudad'),
                    textInputAction: TextInputAction.next,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    enabled: !loading,
                    controller: estadoCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Estado'),
                    textInputAction: TextInputAction.next,
                    validator: (value) => FormValidators.existValidator(value),
                    inputFormatters: [UpperCaseTextFormatter()]
                  ),
                  const SizedBox(height: seperacion),
                  TextFormField(
                    enabled: !loading,
                    controller: telFijoCtrlr,
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
                    enabled: !loading,
                    controller: telCelularCtrlr,
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
                    enabled: !loading,
                    controller: observacionCtrlr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecorations.formInputDecoration(labelText: 'Observaciones', isLabel: true, hintText: 'Opcional'),
                    textInputAction: TextInputAction.done,
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
        disabledColor: ColorPalette.colorTerciarioMedio,
        elevation: 0,
        color: ColorPalette.colorPrincipal,
        onPressed: loading ? null : () => displayBottomSheet(context, size, submit),//submit(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: loading ? const CircularProgressIndicator(color: ColorPalette.colorTerciario,) : const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Guardar y Continuar ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorTerciario),),
              Icon(Icons.arrow_forward_outlined, color: ColorPalette.colorTerciario,)
            ],
          ),
        )
      ),
    );
  }

  Future displayBottomSheet(BuildContext context, Size size, submit)async{
    Widget widget = Container(
      decoration: BoxDecoration(
        color: ColorPalette.colorTerciario,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(child: Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.15,),),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10), 
            child: Text('¿Los datos capturados son correctos?.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                child: CustomMaterialButton(text: 'Si, continuar', widthContainer: size.width * .5, onPressed: ()async{
                  await Future.delayed(const Duration(milliseconds: 500));
                  if(context.mounted){
                    Navigator.pop(context);
                    submit();
                  }
                }),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                child: CustomMaterialButton(text: 'Revisar datos', isNegative: true, widthContainer: size.width * .5, onPressed: ()async{
                  await Future.delayed(const Duration(milliseconds: 500));
                  if(context.mounted){
                    Navigator.pop(context);
                  }
                }),
              ),
            ],
          )
        ],
      ),
    );

    if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, height: 300);
  }
}