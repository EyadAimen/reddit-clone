// this file will contain the widget that displays the video widget


// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({required this.videoPlayerController,super.key});
  final VideoPlayerController videoPlayerController;
  

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      child: VideoPlayer(widget.videoPlayerController)
      );
  }
}
