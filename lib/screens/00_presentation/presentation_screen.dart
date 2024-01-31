import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final video = 'assets/PANTALLA_1.mp4';
  late VideoPlayerController controller;
  final _storage = const FlutterSecureStorage();

  @override
  void initState(){
    super.initState();
    controller = VideoPlayerController.asset(video)
    ..addListener(() => setState(() {}))
    ..setLooping(false)
    ..initialize().then((_) => controller.play());
    
    checkToken();
  }

  checkToken()async{
    String? token = await _storage.read(key: 'token');
    Timer(const Duration(milliseconds: 6550), () {
      if(context.mounted) Navigator.pushReplacementNamed(context, token == null ? 'login' : 'home');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: controller,);
  }
}