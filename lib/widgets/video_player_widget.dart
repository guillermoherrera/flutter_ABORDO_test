import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_application_2/widgets/auth_backgrpund.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
    ? Container(alignment: Alignment.topCenter, child: buildVideo(),)
    : AuthBackground(header: false, mainBox: false, child: Container());
  }

  Widget buildVideo() => buildVideoPlayer();

  Widget buildVideoPlayer() => VideoPlayer(controller);
}