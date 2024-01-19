// this file will contain the widget that displays the video and its controller widget


// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// // for the video Widget
// class VideoPlayer extends StatefulWidget {
//   const VideoPlayer({super.key});

//   @override
//   State<VideoPlayer> createState() => _VideoPlayerState();
// }

// class _VideoPlayerState extends State<VideoPlayer> {

//   // // using the CustomVideoPlayerController to add more functionality to the VideoPlayerController
//   // late CustomVideoPlayerController _customVideoPlayerController;

//   String assetVideoPath = "assets/video.MOV";
//   late VideoPlayerController _videoPlayerController;

//   @override
//   void initState() {
//     _videoPlayerController = VideoPlayerController.asset(assetVideoPath)
//     ..addListener(() {setState(() {
      
//     });})
//     ..initialize().then((_) => _videoPlayerController.play());
//     super.initState();
//   }

//   // void initializeVideoPlayer() {
    
//   //   
//   //     _videoPlayerController.addListener(() {

//   //     });
//   //   _v

//   //   // _customVideoPlayerController = CustomVideoPlayerController(context: context, videoPlayerController: _videoPlayerController);

//   // }

//   @override
//   Widget build(BuildContext context) {
//     return  VideoPlayer(
//       _videoPlayerController
//     );
//   }
// }




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
