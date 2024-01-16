// this is the screen that contains all the widgets

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    
    double firstContainerHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar where it has:
      // 1. back button -will not do anything-
      // 2. the name of the sub reddit as the title
      // 3. the more button -will not do anything-
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("r/MechanicalKeyBoards"),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.more_horiz),
            ),
        ],
      ),

      // the body will be a Row which contains 2 containers
      // one for the video player and the other for the comments
      body: Row(
          children: [
            // will be a stack with the video,name of the user, caption and the other buttons
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Stack(
                  // alignment: Alignment.topRight,
                  children: [
                    // for the video
                    Center(
                      child: Container(
                        color: Colors.red,
                        height: 100,
                      ),
                    ),
                    Column(
                      children: [
                        Icon(Icons.arrow_upward),
                        Text("13.5k"),
                        Icon(Icons.arrow_downward),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              isVisible = true;
                              firstContainerHeight = firstContainerHeight*0.20;
                            });
                          },
                          icon: Icon(Icons.comment)
                          ),
                        Icon(Icons.share),
                        
                      ],
                    ),
                    Column(
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
                  ],
                ),
              ),
            ),

            // the comments part
            
              Container(
                color: Colors.white,
                height: 200,
                width: double.infinity,
              ),
              
          ],
        ),
      
      
    );
  }
}