import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reddit_clone/components/text_style.dart';

// this widget is to represent the upvotes and downvotes
class UpVoteDownVote extends StatefulWidget {
  const UpVoteDownVote({
    required this.upvoteDownVoteNum,
  required this.isColumn,
  required this.upVoteAnimationController,
  required this.downVoteAnimationController,
  super.key});

  final int upvoteDownVoteNum;
  final bool isColumn;
  final AnimationController upVoteAnimationController;
  final AnimationController downVoteAnimationController;
  

  @override
  State<UpVoteDownVote> createState() => _UpVoteDownVoteState();
}

class _UpVoteDownVoteState extends State<UpVoteDownVote> {
  late int upVotes = widget.upvoteDownVoteNum;
  bool isUpvoted = false;
  bool isDownVoted = false;
  // for the animation when clicking
  late Animation<double> _upVoteAnimation;
  late Animation<double> _downVoteAnimation;
  @override
  void initState() {
    _upVoteAnimation = TweenSequence(
      <TweenSequenceItem<double>> [
        TweenSequenceItem<double>(
          tween: Tween(begin: 0, end: 10),
          weight: 50
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 10, end: 0),
          weight: 50
        ),
      ]
    ).animate(widget.upVoteAnimationController);

    _downVoteAnimation = TweenSequence(
      <TweenSequenceItem<double>> [
        TweenSequenceItem<double>(
          tween: Tween(begin: 0, end: 10),
          weight: 50
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 10, end: 0),
          weight: 50
        ),
      ]
    ).animate(widget.downVoteAnimationController);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // this is for the video
    if(widget.isColumn) {
      return Column(
      children: [
        // upVote button
        upVoteWidget(),

        // GestureDetector(

        Text(
          upVotes.toString(),
          style: UnifiedTextStyle.style,
        ),


        // downVote button
        downVoteWidget(),
        
      ],
    );
    }

    // this is for the comments
    else {
      return Row(
      children: [
        // upVote button
        upVoteWidget(),
        Text(
          upVotes.toString(),
          style: UnifiedTextStyle.style,
        ),

        // downVote button
        downVoteWidget(),
      ],
    );
    }
    
  }

  // building the upvotebutton
  Widget upVoteWidget() {
    return AnimatedBuilder(
      animation: widget.upVoteAnimationController,
      builder: (context, _) {
        return Padding(
          padding: EdgeInsets.only(bottom: _upVoteAnimation.value),
          child: GestureDetector(
            onTap: (){
              if(isUpvoted == false) {
                widget.upVoteAnimationController.forward().then((value) {
                  widget.upVoteAnimationController.reset();
                });
              }
              upvote();
              
            },
            child: SizedBox(
              height: 25,
              child: Image.asset(
                isUpvoted ? 'assets/icons/up-arrow.png' : 'assets/icons/arrow-up.png',
                color: isUpvoted? Colors.orange[300] : Colors.white,
              ),
            ),
          ),
        );
      }
    );
  }

  // building the downvotebutton
  Widget downVoteWidget() {
    return AnimatedBuilder(
      animation: widget.downVoteAnimationController,
      builder: (context, _) {
        return Padding(
          padding: EdgeInsets.only(top: _downVoteAnimation.value,),
          child: GestureDetector(
            onTap: () {
              // you will see that the arrow pushes other elemnts to the top istead of going down.. idk why
              if(isDownVoted == false) {
                widget.downVoteAnimationController.forward().then((value) {
                  widget.downVoteAnimationController.reset();
                });
              }
              downVote();
            },
            child: SizedBox(
              height: 25,
              child: Transform.rotate(
                angle: pi,
                child: Image.asset(
                  isDownVoted? 'assets/icons/up-arrow.png' : 'assets/icons/arrow-up.png',
                  color: isDownVoted? Colors.blue[300] : Colors.white,
                ),
              ),
            ),
          ),
        );
      }
      );
  }

  // for the upvote
  void upvote() {
    if(isUpvoted == true) {
      setState(() {
        upVotes--;
        isUpvoted = false;
      });
    }

    else if(isUpvoted == false && isDownVoted == false) {
      setState(() {
        upVotes++;
        isUpvoted = true;
      });
    }
    else if(isUpvoted == false && isDownVoted == true) {
      setState(() {
        upVotes += 2;
        isUpvoted = true;
        isDownVoted = false;
      });
    }
  }

  // for the downvote
  void downVote() {
    if(isDownVoted == true) {
      setState(() {
        upVotes++;
        isDownVoted = false;
      });
    }

    else if(isDownVoted == false && isUpvoted == false) {
      setState(() {
        upVotes--;
        isDownVoted = true;
      });
    }
    else if(isDownVoted == false && isUpvoted == true) {
      setState(() {
        upVotes -= 2;
        isDownVoted = true;
        isUpvoted = false;
      });
    }
  }
}