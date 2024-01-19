import 'package:flutter/material.dart';
import 'package:reddit_clone/components/text_style.dart';
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
  // late int _duration = (widget.videoController.value.duration - widget.videoController.value.position).inSeconds;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            color: Colors.white,
            size: 30,
            
          ),
        ),
        Expanded(
          child: VideoProgressIndicator(
            widget.videoController,
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Colors.white,
              backgroundColor: Colors.grey[900]!,
              ),
          ),
        ),
        Text(
          // to display the remainig time appropriately
         "${((widget.videoController.value.duration - widget.videoController.value.position).inMinutes)}:${((widget.videoController.value.duration - widget.videoController.value.position).inSeconds) % 60}",
        // "${_duration / 60}:${_duration - 60*(_duration % 60)}",
        style: UnifiedTextStyle.style,
        ),
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
          color: Colors.white,
          size: 30,
          ),
        ),
      ],
    );
  }
}