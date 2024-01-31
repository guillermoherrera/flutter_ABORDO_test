import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../blocs/blocs.dart';
import '../../blocs/blocs.dart';
import '../../ui/ui_files.dart';
import '../../widgets/widgets.dart';
import 'dart:math' as maths;

class ListProspectosScreen extends StatefulWidget {
  const ListProspectosScreen({super.key});

  @override
  State<ListProspectosScreen> createState() => _ListProspectosScreenState();
}

class _ListProspectosScreenState extends State<ListProspectosScreen> {
  TextEditingController dateInputController = TextEditingController();
  DateTime fechaAux = DateTime.now();
  List<DatumProspectos>? listaOriginal = [];
  List<DatumProspectos>? lista = [];

  @override
  void initState() {
    super.initState();
    final prospectosBloc = BlocProvider.of<ProspectosObtenerListaBloc>(context, listen: false);
    setState(() {
      listaOriginal = prospectosBloc.state.prospectosLista?.data;
      lista = prospectosBloc.state.prospectosLista?.data;
    });
  }

  _filtroLista(String searchString){

    setState(() {
      lista = searchString.isEmpty ? listaOriginal : listaOriginal?.where((e) => e.nombre.toUpperCase().contains(searchString.toUpperCase()) || e.folioRegistro.toString().toUpperCase().contains(searchString) ).toList();
    });
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
    }else{
      final snackBar = SnackBar(content: Text("No se seleccionó fecha $datePicked"));
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackground(
        appBarTitle: 'Mis Prospectos',
        content: Column(children: [
          _header(),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            height: size.height * .85 , 
            child: _list()
          )
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   splashColor: ColorPalette.colorSecundario,
      //   backgroundColor: ColorPalette.colorNegro,
      //   tooltip: 'Filtrar',
      //   onPressed: ()=>_displayBottomSheet(context, size),
      //   child: const Text('Filtrar', style: TextStyles.tStyleGreyBase14,),
      //   ),
    );
  }

  Widget _header() {
    return  Padding(
      padding: const EdgeInsets.only(top: 0,left: 0, right: 0),
      child: TextFormField(
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecorations.searchInputDecoration(labelText: '', hintText: 'Buscar por Nombre o Folio'),
        textInputAction: TextInputAction.next,
        onChanged: _filtroLista,
      ),
    );
  }

  Widget _list(){
    return Container(
      color: ColorPalette.colorTerciario,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: lista?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Material(
              child: InkWell(
                splashColor: ColorPalette.colorSecundario,
                onTap: (){},
                child: ListTile(
                  isThreeLine: true,
                  leading:  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Color((maths.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1),
                        shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.person, color: ColorPalette.colorTerciarioMedio, size: 50,)),
                  ),
                  title: Text('${lista?[index].folioRegistro} - ${lista?[index].nombre}', style: TextStyles.tStyleTileTitle2,),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ESTATUS ${lista?[index].descClienteStat}', style: TextStyles.tStyleGrey12),
                      Text('REGISTRO ${DateFormat('dd/MM/yyyy').format(lista?[index].fechaRegistro ?? DateTime.now())}', style: TextStyles.tStyleGrey12),
                    ],
                  ),
                  //trailing: const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios_outlined, color: ColorPalette.colorPrincipal)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Future _displayBottomSheet(BuildContext context, Size size)async{
  //   Widget widget = Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             CustomElevatedButton(text: 'Aplicar',onPressed: ()=>Navigator.pop(context))
  //           ],
  //         ),
  //       ),
  //       Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(5),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.all(5),
  //               width: double.infinity,
  //               color: ColorPalette.colorTerciario,
  //               child: const Text('Fecha Registro', style: TextStyles.tStyleNegritaGrey14,))
  //           ]
  //         ),
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: TextFormField(
  //                 controller: dateInputController,
  //                 style: const TextStyle(fontWeight: FontWeight.bold),
  //                 textAlign: TextAlign.end,
  //                 textCapitalization: TextCapitalization.words,
  //                 decoration: InputDecorations.formInputDecoration(labelText: 'Desde', isLabel: true),
  //                 textInputAction: TextInputAction.next,
  //                 readOnly: true,
  //                 onTap: () => pickerFechaNacimiento(),
  //               ),
  //             ),
  //             const SizedBox(width: 20),
  //             Expanded(
  //               child: TextFormField(
  //                 controller: dateInputController,
  //                 style: const TextStyle(fontWeight: FontWeight.bold),
  //                 textAlign: TextAlign.end,
  //                 textCapitalization: TextCapitalization.words,
  //                 decoration: InputDecorations.formInputDecoration(labelText: 'Hasta', isLabel: true),
  //                 textInputAction: TextInputAction.next,
  //                 readOnly: true,
  //                 onTap: () => pickerFechaNacimiento(),
  //               ),
  //             ),
  //           ]
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(5),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.all(5),
  //               color: ColorPalette.colorTerciario,
  //               width: double.infinity,
  //               child: const Text('Estado del Prospecto', style: TextStyles.tStyleNegritaGrey14,))
  //           ]
  //         ),
  //       ),
  //       Expanded(
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: GridView.count(  
  //               crossAxisCount: 4,  
  //               crossAxisSpacing: 1,  
  //               mainAxisSpacing: 1,  
  //               children: List.generate(11, (index) {  
  //                 return Center(  
  //                   child: CustomRadioSexoButton(radioName: 'ACTIVO', index: 'H', selectedPayment: '', onPressed: (i){},),// your widget  
  //                 );  
  //               }  
  //             )  
  //           ),
  //         ),
  //       )
  //     ],
  //   );

  //   if(context.mounted) await CustomBottomSheet.show(context: context, widget: widget, height: 500, backgroundColor: ColorPalette.colorBlanco);
  // }
}