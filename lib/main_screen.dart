// this is the screen that contains all the widgets

import 'package:flutter/material.dart';
import 'package:reddit_clone/components/profile_name.dart';
import 'package:reddit_clone/components/text_style.dart';
import 'package:reddit_clone/components/upvote_downvote.dart';
import 'package:reddit_clone/components/video_player.dart';
import 'package:reddit_clone/components/video_player_controllers.dart';
import 'package:video_player/video_player.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// not single cuz i have 2 animation controllers
class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{
  // to controll all the animations
  late AnimationController _upVoteController;
  late AnimationController _downVoteController;
  // for the upvote and downvote
  
  // for the textField when tapping on the reply button it focuses on the textField
  late FocusNode _focusNode;

  // for the comment section
  bool isVisible = false;
  bool isCommentVisible = false;
  // for the height manipulation
  double percent = 1;
  // for the video asset
  String assetVideoPath = "assets/videos/video.MOV";
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



    // initialzing the animation controller for the upvote and downVote
    _upVoteController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );
    _downVoteController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );

    _focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _downVoteController.dispose();
    _upVoteController.dispose();
    super.dispose();
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
        centerTitle: true,
        leading: IconButton(
          onPressed: (){},
          icon: AnimatedOpacity(
            opacity: !isVisible == true? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: !isVisible,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              ),
          ),
        ),
        title: AnimatedOpacity(
          opacity: !isVisible == true? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Visibility(
            visible: !isVisible,
            child: const ProfileName(name: "r/MechanicalKeyBoards"),
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
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 20,
                ),
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
              duration: const Duration(milliseconds: 300),
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
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 50, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            
                            
                            children: [
                              // upvoteDownVote
                              UpVoteDownVote(
                                upvoteDownVoteNum: 135,
                                isColumn: true,
                                upVoteAnimationController: _upVoteController,
                                downVoteAnimationController: _downVoteController,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              
                              GestureDetector(
                                onTap: (){
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
                                child: SizedBox(
                                  height: 25,
                                  child: Image.asset(
                                    "assets/icons/chat.png",
                                    color: Colors.white,
                                    ),
                                ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              SizedBox(
                                height: 25,
                                child: Image.asset(
                                  "assets/icons/upload.png",
                                  color: Colors.white,
                                ),
                                
                              ),

                              const SizedBox(
                                height: 
                                30,
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: !isVisible == true? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Visibility(
                        visible: !isVisible,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20,right: 100,bottom: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              
                              const ProfileName(name: "Xury46"),
                              Text(
                                "After a year of collecting parts for this build, I present my finished Heavy-9 (Thocky typing test at the end!)",
                                style: UnifiedTextStyle.style,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VideoPlayerControllers(videoController: _videoPlayerController),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),






            // the comments part
            
              Visibility(
                visible: isVisible,
                  child: Dismissible(
                    key: Key("value"),
                    direction: DismissDirection.down,
                    onUpdate: (details){
                      if(details.progress >= 0.1) {
                        setState(() {
                        percent = details.progress;
                      });
                      }
                      
                      print("=========================");
                      print(details.progress);
                    },
                    onDismissed: (DismissDirection dismiss) {
                      
                      setState(() {
                        isVisible = false;
                        
                      });
              
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: MediaQuery.of(context).size.height*.75,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            // onVerticalDragDown: (direction){
                            //   setState(() {
                            //       isVisible = false;
                            //       percent = 1;
                            //     });
                            // },
                            child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
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
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: list.length,
                              
                            
                              itemBuilder: (context, index){
                                // this container contains the comments and other stuff
                                return Container(
                                  
                                  padding: EdgeInsets.only(
                                    left: list[index][2] == 0? 10 :
                                    list[index][2] == 1? 30: 
                                    list[index][2] == 2? 50:
                                    list[index][2] == 3? 70:
                                    list[index][2] == 4? 90 : 60,
                                    right: 10
                                  ),
                                  // to put a space between non related comments
                                  margin: EdgeInsets.only(bottom: (index< list.length-1 &&list[index+1][2] == 0)?  10 : 0),
                                  color: Colors.grey[900],
                                    
                                  
                    
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                      border: list[index][2] > 0? const Border(
                                      left: BorderSide(color: Colors.grey,),
                                      ): null,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ProfileName(name: list[index][0]),
                                        Text(list[index][1],
                                        style: UnifiedTextStyle.style),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Icon(Icons.more_horiz,
                                            size: 25,
                                            color: Colors.white,
                                            ),
                                            const SizedBox(width: 5,),
                                            SizedBox(
                                              height: 25,
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context).requestFocus(_focusNode);
                                                },
                                                child: Image.asset(
                                                  "assets/icons/reply.png",
                                                  color: Colors.white,
                                                ),
                                                ),
                                            ),
                    
                                            const SizedBox(width: 5,),
                                            UpVoteDownVote(upvoteDownVoteNum: list[index][3], isColumn: false, upVoteAnimationController: _upVoteController, downVoteAnimationController: _downVoteController),
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
                                focusNode: _focusNode,
                                
                                decoration: const InputDecoration(
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
  // the third element indicates the number of replies so i can desint the boorder on the left
  // the last element is for the upvotes
List<List> list = [
  ["eren","here is my comment", 0,23],
  ["eren","here is my comment about the most intersing part in the world .vv... here i am typing to take some space hhhh", 1,1],
  ["eren","here is my comment", 2,5],
  ["eren","here is my comment", 0,8],
  ["eren","here is my comment", 0,3],
  ["eren","here is my comment", 1,2],
  ["eren","here is my comment", 2,1],
  ["eren","here is my comment", 3,7],
  ["eren","here is my comment", 0,1],
  ["eren","here is my comment", 0,1],
  ["eren","here is my comment", 1,1],
  ["eren","here is my comment", 2,1],
  ["eren","here is my comment", 3,1],
  ["eren","here is my comment", 4,1],
  ["eren","here is my comment", 0,1],
  ["eren","here is my comment", 0,44],
  ["eren","here is my comment", 0,55],
];
}

