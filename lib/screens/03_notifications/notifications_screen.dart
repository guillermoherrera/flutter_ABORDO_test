import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/models.dart';
import '../../services/api_services.dart';
import '../../ui/ui_files.dart';
import 'dart:math' as maths;

import '../../widgets/widgets.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _apiCV = ApiService();
  bool loadingApi = true;
  get math => null;
  List<DatumNotificaciones>? lista = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async{
    setState(() => loadingApi = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    await _apiCV.notificaciones().then((Notificaciones res){
      if(res.error == 0){
        setState(() {lista = res.data;});
      }else{
        DialogHelper.exit(context, res.resultado!);
      }        
    }).catchError((e){
      DialogHelper.exit(context, e.toString());
    });
    setState(() => loadingApi = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorPalette.colorTerciario
        ),
        backgroundColor: ColorPalette.colorPrincipal,
        title: const Text('Notificaciones', style: TextStyles.tStyleAppBar,),
        actions: [
          Image(image: const AssetImage('assets/ICONO_APLICACION_SOLUCIONES_AB.png'), width: size.width * 0.10,),
          const SizedBox(width: 10,),
        ],
      ),
      body: loadingApi 
      ? const Center(child: CircularProgressIndicator(color: ColorPalette.colorPrincipal))
      : (lista?.length ?? 0) == 0 
      ? const EmptyWidget()
      : ListView.builder(
        shrinkWrap: true,
        itemCount: lista?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading:  Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color((maths.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.notifications_outlined, color: ColorPalette.colorPrincipal,)),
              title: Text('${lista?[index].notificacion}', style: TextStyles.tStyleTileTitle2,),
              subtitle: Text(DateFormat('dd/MM/yyyy hh:mm a').format(lista?[index].fecha ?? DateTime.now()), style: TextStyles.tStyleTileSubtitle),
            ),
          );
        },
      ),
    );
  }
}