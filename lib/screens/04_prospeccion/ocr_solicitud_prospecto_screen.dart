import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_border_type.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line_direction.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line_position.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_result.dart';
import 'package:path_provider/path_provider.dart';

class OcrSolicitudProspectoScreen extends StatefulWidget {
  const OcrSolicitudProspectoScreen({super.key});

  @override
  State<OcrSolicitudProspectoScreen> createState() => _OcrSolicitudProspectoScreenState();
}

class _OcrSolicitudProspectoScreenState extends State<OcrSolicitudProspectoScreen> {
  final _textRecognizaer = TextRecognizer();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prospectoBloc = context.watch<ProspectoBloc>();
    
    Future<void> scannImage(Uint8List imageBytes) async{
      final navigator = Navigator.of(context);
      try {
        final tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}/image.png').create();
        file.writeAsBytesSync(imageBytes);

        final inputImage = InputImage.fromFile(file);
        final recognizedText = await _textRecognizaer.processImage(inputImage);

        final dateFormat = RegExp(r'^([0-9][0-9]\/[012][0-9]\/[0-9]{4})');
        final sexoFormat = RegExp(r'^(SEXO [H-M])');

        bool nom = false;
        bool dom = false;
        bool fhn = false;
        bool sex = false;
        List<String> nombre = [];
        List<String> domicilio = [];
        String fechaNacimiento = '';
        String sexo = '';
        for (var block in recognizedText.blocks) { 
          
          if(fhn){
            for (var line in block.lines) {
              if(dateFormat.hasMatch(line.text)){
                fechaNacimiento = line.text;
                fhn = false;
              }
            }
          }

          if(sex){
            for (var line in block.lines) {
              if(sexoFormat.hasMatch(line.text)){
                sexo = line.text;
                sex = false;
              }
            }
          }

          if(block.text.contains('CLAVE')){
            nom = false;
            dom = false;
            fhn = true;
            sex = true;
          }

          if(block.text.contains('DOMICILIO') || dom){
            for (var line in block.lines) {
              domicilio.add(line.text);
            }
            nom = false;
            dom = true;
          }

          if(block.text.contains('NOMBRE') || nom){
            for (var line in block.lines) {
              nombre.add(line.text);
            }
            nom = true;
          }

        }
        
        if (domicilio[2].length >= 5) {
          domicilio.add(domicilio[2].substring(domicilio[2].length - 5));
          domicilio[2] = domicilio[2].substring(0, domicilio[2].length - 5);
        }

        if (domicilio[3].length >= 3) {
          domicilio.add(domicilio[3].substring(domicilio[3].length - 4));
          domicilio[3] = domicilio[3].substring(0, domicilio[3].length - 5).replaceAll(',', '');
        }

        if(sexo.isNotEmpty){
          sexo = sexo.substring(sexo.length - 1);
        }

        Future<List<dynamic>> weirdSplit(String input) async => <dynamic>[
          ...RegExp(r'\d+|\D+')
              .allMatches(input)
              .map((match) => match[0]!)
              .map((string) => int.tryParse(string) ?? string)
        ];

        List<dynamic> calleNumero = await weirdSplit(domicilio[1]);

        Prospecto prospecto = Prospecto(
          nombre: nombre[3], 
          primerApellido: nombre[1], 
          segundoApellido: nombre[2], 
          fechaNacimiento: fechaNacimiento, 
          sexo: sexo,
          calle: calleNumero[0], 
          noExterior: '${calleNumero[1]}', 
          colonia: domicilio[2], 
          ciudad: domicilio[3], 
          cp: domicilio[4], 
          estado: domicilio[5]);

        prospectoBloc.add(NewProspectoOcr(prospecto));
        navigator.pushNamed('formSolicitudProspecto');
      } catch (e) {
        if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Asegurate que la INE este dento del cuadro punteado u Vulve a Intentarlo. \nError:${e.toString()}')));
      }
    }

    return Stack(
      children: [
        MaskForCameraView(
          visiblePopButton: false,
          appBarColor: const Color.fromRGBO(9, 85, 179, 1),
          title: 'Alinea la INE a la Imagen Guía y Captura',
          takeButtonActionColor: const Color.fromRGBO(9, 85, 179, 1),
          iconsColor: const Color.fromRGBO(230, 230, 230, 1),
          titleStyle: const TextStyle(color: Color.fromRGBO(230, 230, 230, 1), fontWeight: FontWeight.bold, fontSize: 15.0),
          borderType: MaskForCameraViewBorderType.dotted,
          boxBorderWidth: 0,
          boxBorderRadius: 0,
          boxWidth: size.height * .3,
          boxHeight: size.width * 1,
          takeButtonColor: const Color.fromRGBO(230, 230, 230, 1),
          insideLine: MaskForCameraViewInsideLine(
            position: MaskForCameraViewInsideLinePosition.partFour,
            direction: MaskForCameraViewInsideLineDirection.vertical,
          ),
          onTake: (MaskForCameraViewResult? res) => {if (res != null) scannImage(res.croppedImage!)}
        ),
        SafeArea(
          child: Align(alignment: Alignment.topRight,
           child: Visibility(
            visible: true,
            child: Padding(
                padding: const EdgeInsets.only(top: 70,right: 10),
                child: ImageIcon(
                  const AssetImage("assets/landscape.png"),
                  size: size.width * .2,
                  color: const Color.fromRGBO(230, 230, 230, 1),
                )),
          ),),
        ),
        Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: Image(image: const AssetImage('assets/id_card_ine.png'), color: Colors.white.withOpacity(0.3), width: size.width * 1, height: size.height * 0.3, fit: BoxFit.fill)),
        )
      ],
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Text(text),
      ),
    );
  }
}