import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  Future<void> _scannImage(Uint8List imageBytes) async{
    final navigator = Navigator.of(context);
    try {
      //final File file = File.fromRawPath(imageBytes);

      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(imageBytes);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizaer.processImage(inputImage);

      await navigator.push(MaterialPageRoute(builder: (context) => ResultScreen(text: recognizedText.text) ));
    } catch (e) {
      if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error ${e.toString()}')));
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          onTake: (MaskForCameraViewResult? res) => {if (res != null) _scannImage(res.croppedImage!)}
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