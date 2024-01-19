import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllers extends StatefulWidget {
  const VideoPlayerControllers({required this.videoController, super.key});
  final VideoPlayerController videoController;

  @override
  State<VideoPlayerControllers> createState() => _VideoPlayerControllersState();
}

class _VideoPlayerControllersState extends State<VideoPlayerControllers> {
  late bool isMuted;
  @override
  void initState() {
    isMuted = widget.videoController.value.volume == 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: (){
            if(widget.videoController.value.isPlaying) {
              widget.videoController.pause();
            }
            else {
              widget.videoController.play();
            }
          },
          icon: Icon(
            widget.videoController.value.isPlaying? 
            Icons.pause
            : Icons.play_arrow,
          ),
        ),
        Expanded(
          child: VideoProgressIndicator(
            widget.videoController,
            allowScrubbing: true,
          ),
        ),
        Text("${widget.videoController.value.position.inMinutes}:${widget.videoController.value.position.inSeconds}"),
        IconButton(
          onPressed: () {
            widget.videoController.setVolume(isMuted? 1 : 0).then((value) {
              if(widget.videoController.value.volume != 0) {
                setState(() {
                  isMuted = false;
                });
              }
              else{
                setState(() {
                  isMuted = true;
                });
              }
            });
          },
          icon: Icon(isMuted? Icons.volume_mute : Icons.volume_up,
          color: Colors.red,
          ),
        ),
      ],
    );
  }
}