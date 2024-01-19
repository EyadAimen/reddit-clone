// this is the screen that contains all the widgets

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_clone/components/video_player.dart';
import 'package:reddit_clone/components/video_player_controllers.dart';
import 'package:video_player/video_player.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // for the comment section
  bool isVisible = false;
  bool isCommentVisible = false;
  // for the height manipulation
  double percent = 1;
  // for the video asset
  String assetVideoPath = "assets/video.MOV";
  // controoler for the vieo player widget and the controll buttons
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // to set the asset that the controller will display
    _videoPlayerController = VideoPlayerController.asset(assetVideoPath)
    // to listen for video changes
    ..addListener(() {setState(() {
      
    });})
    // when ithe widget is loaded it will automatically plays the video
    ..initialize().then((_) => _videoPlayerController.play());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      // appBar where it has:
      // 1. back button -will not do anything-
      // 2. the name of the sub reddit as the title
      // 3. the more button -will not do anything-
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        
        leading: IconButton(
          onPressed: (){},
          icon: AnimatedOpacity(
            opacity: !isVisible == true? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: !isVisible,
              child: const Icon(Icons.arrow_back)
              ),
          ),
        ),
        title: AnimatedOpacity(
          opacity: !isVisible == true? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Visibility(
            visible: !isVisible,
            child: const Text("r/MechanicalKeyBoards"),
            ),
        ),
        actions: [
          AnimatedOpacity(
            opacity: !isVisible == true? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: !isVisible,
              child: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.more_horiz),
                ),
            ),
          ),
        ],
      ),

      // the body will be a Row which contains 2 containers
      // one for the video player and the other for the comments
      body: Column(
          children: [
            // will be a stack with the video,name of the user, caption and the other buttons
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: MediaQuery.of(context).size.height*percent,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    // for the video
                    Center(
                      child: VideoPlayerWidget(videoPlayerController: _videoPlayerController,),
                      
                    ),
                    AnimatedOpacity(
                      opacity: !isVisible == true? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Visibility(
                        visible: !isVisible,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          
                          children: [
                            FaIcon(FontAwesomeIcons.arrowUp),
                            Text("13.5k"),
                            Icon(Icons.arrow_downward),
                            IconButton(
                              onPressed: (){
                                if(isVisible == false){
                                  setState(() {
                                  isVisible = true;
                                  percent = 0.25;
                                });
                                }
                                else{
                                  setState(() {
                                  isVisible = false;
                                  percent = 1;
                                });
                                }
                                
                              },
                              icon: Icon(Icons.comment)
                              ),
                            Icon(Icons.share),
                            
                          ],
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: !isVisible == true? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Visibility(
                        visible: !isVisible,
                        child: Container(
                          margin: EdgeInsets.only(left: 20,right: 60),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.blue,
                                  ),
                                  Text("Xury46"),
                                ],
                              ),
                              Text("After a year of collecting parts for this build, I present my finished Heavy-9 (Thocky typing test at the end!)")
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 50,
                      left: 50,
                      bottom: 20,
                      child: VideoPlayerControllers(videoController: _videoPlayerController)
                      ),
                  ],
                ),
              ),
            ),

            // the comments part
            
              Visibility(
                visible: isVisible,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  child: Container(
                    height: MediaQuery.of(context).size.height*.75,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onVerticalDragDown: (direction){
                            setState(() {
                                isVisible = false;
                                percent = 1;
                              });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              
                              // 
                              border: BorderDirectional(bottom: BorderSide()),
                            ),
                            child: Center(
                              child: Container(
                                height: 10,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                  
                        Expanded(
                          child: ListView.builder(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: list.length,
                            
                          
                            itemBuilder: (context, index){
                              // this container contains the comments and other stuff
                              return Container(
                                
                                padding: EdgeInsets.only(
                                  left: list[index][2] == 0? 10 :
                                  list[index][2] == 1? 20: 
                                  list[index][2] == 2? 30:
                                  list[index][2] == 3? 40:
                                  list[index][2] == 4? 50 : 60,
                                  right: 10
                                ),
                                // to put a space between non related comments
                                margin: EdgeInsets.only(bottom: (index< list.length-1 &&list[index+1][2] == 0)?  10 : 0),
                                color: Colors.grey[900],
                                  
                                
                  
                                child: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border: list[index][2] > 0? Border(
                                    left: BorderSide(color: Colors.red,),
                                    ): null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index][0],
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                      Text(list[index][1],
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.more_horiz),
                                          Icon(Icons.replay),
                                          FaIcon(FontAwesomeIcons.arrowUp),
                                          Text("10"),
                                          Icon(Icons.arrow_downward),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            ),
                        ),
                  
                        Container(
                          
                          height: 50,
                          
                          margin: EdgeInsets.all(5),
                          color: Colors.grey[800],
                          child: Center(
                            child: TextField(
                              onTap: (){
                                setState(() {
                                  isCommentVisible = true;
                                  print(isCommentVisible);
                                });
                              },
                              onSubmitted: (_){
                                setState(() {
                                  isCommentVisible = false;
                                  print(isCommentVisible);
                                  print("==============================");
                                });
                              },
                              // onTapOutside: (_){
                              //   setState(() {
                              //     isCommentVisible = false;
                              //     print(isCommentVisible);
                              //   });
                              // },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Add a comment",
                                suffixIcon: Icon(Icons.photo_album_outlined)
                              ),
                            ),
                          ),
                        ),
                  
                      ],
                    ),
                  ),
                ),
              ),
              
          ],
        ),
      
      
    );

    
  }
  // a list of lists that contains the name of the user and the comment and the reply
// the last element indicates the number of replies so i can desint the boorder on the left
List<List> list = [
  ["eren","here is my comment", 0],
  ["eren","here is my comment about the most intersing part in the world .vv... here i am typing to take some space hhhh", 1],
  ["eren","here is my comment", 2],
  ["eren","here is my comment", 0],
  ["eren","here is my comment", 0],
  ["eren","here is my comment", 1],
  ["eren","here is my comment", 2],
  ["eren","here is my comment", 3],
  ["eren","here is my comment", 0],
  ["eren","here is my comment", 0],
  ["eren","here is my comment", 1],
  ["eren","here is my comment", 2],
  ["eren","here is my comment", 3],
  ["eren","here is my comment", 4],
  ["eren","here is my comment", 0],
  ["eren","here is my comment", 0],
  ["eren","here is my comment", 0],
];
}

