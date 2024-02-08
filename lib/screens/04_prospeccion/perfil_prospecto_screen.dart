import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../models/models.dart';
import '../../services/api_services.dart';
import '../../ui/ui_files.dart';
import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class PerfilProspectoScreen extends StatefulWidget {
  const PerfilProspectoScreen({super.key, required this.index});

  final String index;

  @override
  State<PerfilProspectoScreen> createState() => _PerfilProspectoScreenState();
}

class _PerfilProspectoScreenState extends State<PerfilProspectoScreen> {
  final _apiCV = ApiService();
  
  @override
  void initState() {
    getData();
    super.initState();
  }
  
  getData() async{
    final prospectoEBloc = BlocProvider.of<ProspectoObtenerPerfilBloc>(context, listen: false);
    await _apiCV.prospectoObtenerPerfil(prospectoEBloc.state.prospectoPerfil?.data?.folioRegistro ?? 0).then((ProspectoObtenerPerfil res)async{
      if(res.error == 0){
        res.data?.color = prospectoEBloc.state.prospectoPerfil?.data?.color ?? '#000000';
        final prospectoPerfilBloc = BlocProvider.of<ProspectoObtenerPerfilBloc>(context, listen: false);
        prospectoPerfilBloc.add(NewProspectoObtenerPerfil(res));
      }else{
        DialogHelper.exit(context, res.resultado!);
      }        
    }).catchError((e){
      DialogHelper.exit(context, e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prospectoBloc = context.watch<ProspectoObtenerPerfilBloc>();
    
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: CustomBackground(
          height: 0.5,
          appBarTitle: '', 
          content: SingleChildScrollView(
            child: Column(
              children: [
                _header(size, prospectoBloc),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: IntrinsicColumnWidth(),
                          3: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          _generales('PLAZA: ', '${prospectoBloc.state.prospectoPerfil?.data?.descPlaza}', ' SUCURSAL: ', '${prospectoBloc.state.prospectoPerfil?.data?.nomSucursal}'),
                          _generales('SEXO: ', '${prospectoBloc.state.prospectoPerfil?.data?.sexo}', ' F. DE NAC.: ', DateFormat('dd/MM/yyyy').format(prospectoBloc.state.prospectoPerfil?.data?.fecNac ?? DateTime.now())),
                          _generales('TEL. FIJO: ', '${prospectoBloc.state.prospectoPerfil?.data?.telFijo}', ' CELULAR: ', '${prospectoBloc.state.prospectoPerfil?.data?.telCelular}'),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('OBSERVACIONES: ', style: TextStyles.tStyleGreyBase12, overflow: TextOverflow.ellipsis),
                          Flexible(child: Text('${prospectoBloc.state.prospectoPerfil?.data?.observaciones}', style: TextStyles.tStyleGreyBaseNormal12)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Wrap(
                  children: [
                    _buttonSquare('Generales', Icons.person_outline, prospectoBloc),
                    _buttonSquare('Referencias', Icons.groups_outlined, prospectoBloc),
                    _buttonSquare('Fiador', Icons.group_outlined, prospectoBloc),
                    _buttonSquare('Solvencia Dist.', Icons.car_rental_outlined, prospectoBloc),
                    _buttonSquare('Solvencia Aval', Icons.car_rental_sharp, prospectoBloc),
                    _buttonSquare('Documentos', Icons.document_scanner_outlined, prospectoBloc),
                    _buttonSquare('Representantes', Icons.groups, prospectoBloc),
                    _buttonSquare('Info. Digital', Icons.fingerprint, prospectoBloc),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  color: ColorPalette.colorTerciario,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text('Detalle', style: TextStyles.tStyleNegrita16,),
                            Icon(Icons.arrow_downward, color: ColorPalette.colorTerciarioMedio,),
                          ],
                        ),
                      ),
                      _resumen(size, prospectoBloc)
                    ],
                  ),
                ),
                
                // ListView(
                //   shrinkWrap: true,
                //   children: [
                //     optionProfile('Datos Generales'),
                //     optionProfile('Referencias'),
                //     optionProfile('Fiador'),
                //     optionProfile('Documentos'),
                //     optionProfile('Representantes'),
                //     Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Flexible(child: optionProfile('Representantes')),
                //         Flexible(child: optionProfile('Representantes')),
                //       ],
                //     )
                //   ],
                // )
              ],
            ),
          )),
      ),
    );
  }

  Widget _header(Size size, ProspectoObtenerPerfilBloc prospectoBloc) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: 'IconProspecto_${widget.index}',
            child: Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: Color(int.parse('0xff${prospectoBloc.state.prospectoPerfil?.data?.color?.replaceAll('#', '')}')),
              shape: BoxShape.circle
            ),
            child: Icon(Icons.person, size: size.width * 0.20, color: ColorPalette.colorBlanco )),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text('${prospectoBloc.state.prospectoPerfil?.data?.nombre}', style: TextStyles.tStyleGreyBase18,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text('${prospectoBloc.state.prospectoPerfil?.data?.descClienteStat} - ${prospectoBloc.state.prospectoPerfil?.data?.folioRegistro}', style: TextStyles.tStyleGreyBaseNormal12),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined, color: ColorPalette.colorTerciarioMedio,),
                      Flexible(child: Text(prospectoBloc.state.prospectoPerfil?.data?.direccion ?? '', style: TextStyles.tStyleGrey12)),
                    ],
                  ),
                ),
              ],
            ),
          )        
        ],
      ),
    );
  }

  // Widget _optionProfile(String optDesc){
  //   var borderRadius = const BorderRadius.all(Radius.circular(10));

  //   return Container(
  //     padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
  //     decoration: BoxDecoration(
  //       color: ColorPalette.colorTransparent,
  //       borderRadius: BorderRadius.circular(25),
  //       boxShadow: const [
  //         BoxShadow(color: ColorPalette.colorShadow, blurRadius: 15, offset: Offset(0, 5))
  //       ]
  //     ),
  //     child: Material(
  //       shape: RoundedRectangleBorder(borderRadius: borderRadius),
  //       color: ColorPalette.colorTerciario,
  //       child: InkWell(
  //         borderRadius: borderRadius,
  //         splashColor: ColorPalette.colorSecundario,
  //         onTap: ()async{
  //           await Future.delayed(const Duration(milliseconds: 500));
  //           //if(mounted) Navigator.pushNamed(context, 'perfil', arguments: 0);
  //         },
  //         child: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //           child: Row(
  //             children: [
  //               Flexible(child: Text(optDesc, style: TextStyles.tStyleNegrita14, overflow: TextOverflow.ellipsis,)),
  //               const Icon(Icons.arrow_forward_ios_outlined, color: ColorPalette.colorNegro),
  //             ],
  //           ),
  //         )
  //         // ListTile(
  //         //   shape: RoundedRectangleBorder(borderRadius: borderRadius),
  //         //   title: Text(optDesc, style: TextStyles.tStyleNegrita14,),
  //         //   trailing: const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios_outlined, color: ColorPalette.colorNegro)),
  //         // ),
  //       ),
  //     ),
  //   );
  // }

  TableRow _generales(String key, String value, String key2, String value2){
    return TableRow(
      children: [
        Text(key, style: TextStyles.tStyleGreyBase12, overflow: TextOverflow.ellipsis),
        Text(value, style: TextStyles.tStyleGreyBaseNormal12, overflow: TextOverflow.ellipsis),
        Text(key2, style: TextStyles.tStyleGreyBase12, overflow: TextOverflow.ellipsis),
        Text(value2, style: TextStyles.tStyleGreyBaseNormal12, overflow: TextOverflow.ellipsis),
      ] 
    );
  }

  Widget _buttonSquare(text, icon, prospectoBloc){
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ButtonSquare(icon: icon, text: text, iconColor: Color(int.parse('0xff${prospectoBloc.state.prospectoPerfil?.data?.color?.replaceAll('#', '')}')),),
    );
  }

  Widget _resumen(size, ProspectoObtenerPerfilBloc prospectoBloc){
    final List<String> etapas = [
      'Generales',
      'Referencias',
      'Fiador',
      'Solvencia Dist',
      'Solvencia Aval',
      'Documentos',
      'Representates',
      'Info. Digital',  
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: etapas.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return Stack(
          children: [
            Positioned(
              left: 45,
              child: Container(
                height: size.height * 2,
                width: 1.0,
                color: Colors.grey.shade400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: size.width * 0.06),
                  SizedBox(
                    width: size.width * 0.30,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              color: Color(int.parse('0xff${prospectoBloc.state.prospectoPerfil?.data?.color?.replaceAll('#', '')}')),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Text(etapas[i], style: TextStyles.tStyleNormal12),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.55,
                    child:  Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: _detalle(i, etapas[i]),
                    )
                  )
                ],
              ),
            ),
            
            // Positioned(
            //   bottom: 7,
            //   child: Padding(
            //     padding: const EdgeInsets.all(40.0),
            //     child: Container(
            //       height: 20.0,
            //       width: 20.0,
            //       decoration: BoxDecoration(
            //         color: Color(int.parse('0xff${prospectoBloc.state.prospectoPerfil?.data?.color?.replaceAll('#', '')}')),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      }
    );
  }

  Widget _detalle(index, title){
    Widget detalle;

    switch (index) {
      case 0:
        detalle = _generalesDetalle();
        break;
      case 1:
        detalle = _referenciasDetalle();
        break;
      default:
        detalle = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contenido $title'),
            Text(
              'Contenido $title',
              style: const TextStyle(
                  color: Colors.grey, fontSize: 12),
            )
          ],
        );
        break;
    }

    return detalle;
  }

  Widget _generalesDetalle(){
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),},
      children: const [
        TableRow(children: [
          Text('Suc. Sede: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('FCO. I. MADERO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Suc. Atención: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('FCO. I. MADERO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Categoría: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('Senior', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Fecha Captura: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('27/01/2024', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Limite Crédito: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$0.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Jefe Comercial: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Monto Desc.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('COBRANZA', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Lugar Nac.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('COAHUILA DE ZARAGOZA', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Estado Civil: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('CASADO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Regimen Fiscal: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('MANCOMUNADOS', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('RFC: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('XXXX000000XX0', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('CURP: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('XXXX000000xxxxxx00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('IFE: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('0000000000000', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Email: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Casa: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('PROPIA', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Tiempo Resid.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('18 años, 0 meses', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('ACTIVIDAD LABO', style: TextStyles.tStyleBlue1Bold2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end,),
          Text('RAL', style: TextStyles.tStyleBlue1Bold2,)
        ]),
        TableRow(children: [
          Text('Empresa: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('DISTRIBUIDORA DE VALES', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Calle: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('SIN NOMBRE SN', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('N° Ext.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('0', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('N° Int.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('0', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('C.P.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('35111', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Colonia: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('EUREKA DE MEDIA LUNA (EUREKA)', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Delegación: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('GÓMEZ PALACIO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Ciudad: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Estado: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('DURANGO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Giro/Actividad: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('FINANCIERO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Experiencia\nVales/Catálogo: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('6 años, 0 meses', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Pago Relacion: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$20,632.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Departamento: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('VENTAS', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Antigüedad: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('5 años, 0 meses', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Teléfono: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('8712223344', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Ingresos Mens: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$5,000.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Otros Ingresos: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$8,000.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Total Ingresos\nMens.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$13,000.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Puesto: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('DUEÑA', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Tipo: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('COMPLETO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Ext: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Total Egresos\nMens: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$8,000.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('INF0RMACI0N C0', style: TextStyles.tStyleBlue1Bold2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end,),
          Text('NYUGUE', style: TextStyles.tStyleBlue1Bold2,)
        ]),
        TableRow(children: [
          Text('A. Paterno: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('REYES', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('A. Materno: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('LOPEZ', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Nombre: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('ALEJANDRO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Empresa: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('DISTRIBUIDORA DE VALES', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Calle: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('SIN NOMBRE SN', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('N° Ext.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('0', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('N° Int.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('0', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('C.P.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('35111', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Colonia: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('EUREKA DE MEDIA LUNA (EUREKA)', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Delegación: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('GÓMEZ PALACIO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Ciudad: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Estado: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('DURANGO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Giro/Actividad: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('FINANCIERO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Departamento: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('VENTAS', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Antigüedad: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('5 años, 0 meses', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Teléfono: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('8712223344', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Ingresos Mens: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$5,000.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Otros Ingresos: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$8,000.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Total Ingresos\nMens.: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$13,000.00', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Puesto: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('DUEÑA', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Tipo: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('COMPLETO', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Ext: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('', style: TextStyles.tStyleNormal12,)
        ]),
        TableRow(children: [
          Text('Total Egresos\nMens: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
          Text('\$8,000.00', style: TextStyles.tStyleNormal12,)
        ]),
      ],
    );
    // Text('OBSERVACIONES: ', style: TextStyles.tStyleGreyBase12, overflow: TextOverflow.ellipsis),
    //                   Flexible(child: Text('OBSERVACIONES SOBRE EL PROSPECTO A DISTRIBUIDORAS', style: TextStyles.tStyleGreyBaseNormal12)),
  }

  Widget _referenciasDetalle(){
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(1),},
      children: const [
        TableRow(children: [
          Text('REFERENCIAS PERSONALES', style: TextStyles.tStyleBlue1Bold2, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('BRENDA ESPINOZA ORDAZ.', style: TextStyles.tStyleNormal12, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('JUANA MARIA ESPINOZA ORDAZ.', style: TextStyles.tStyleNormal12, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('CECILIA QUIÑONES LOPEZ.', style: TextStyles.tStyleNormal12, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('LUCERO AMADOR ESPINOZA.', style: TextStyles.tStyleNormal12, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('REFERENCIAS CREDITICIAS', style: TextStyles.tStyleBlue1Bold2, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('BHERMANOS DISTRIBUIDORA DE VALES.', style: TextStyles.tStyleNormal12, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('GARANTIAS BIENES RAICES DEL SOLICITANTE', style: TextStyles.tStyleBlue1Bold2, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('PRENDARIA. VALOR \$20,000.00.', style: TextStyles.tStyleNormal12, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('Observaciones: ', style: TextStyles.tStyleNegrita12, overflow: TextOverflow.ellipsis),
        ]),
        TableRow(children: [
          Text('DISTRIBUIDORA CON EXPERIENCIA EN VALES', style: TextStyles.tStyleNormal12),
        ]),
      ]
    );
  }
}