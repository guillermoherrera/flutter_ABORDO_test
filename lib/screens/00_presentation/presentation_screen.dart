import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(video)
    ..addListener(() => setState(() {}))
    ..setLooping(false)
    ..initialize().then((_) => controller.play());
    Timer(const Duration(milliseconds: 6550), () {
      Navigator.pushReplacementNamed(context, 'login');;
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