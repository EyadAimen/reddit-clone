import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reddit_clone/components/text_style.dart';

// this widget is to represent the upvotes and downvotes
class UpVoteDownVote extends StatefulWidget {
  const UpVoteDownVote({required this.upvoteDownVoteNum, required this.isColumn, super.key});

  final int upvoteDownVoteNum;
  final bool isColumn;
  

  @override
  State<UpVoteDownVote> createState() => _UpVoteDownVoteState();
}

class _UpVoteDownVoteState extends State<UpVoteDownVote> {
  late int upVotes = widget.upvoteDownVoteNum;
  bool isUpvoted = false;
  bool isDownVoted = false;
  @override
  Widget build(BuildContext context) {
    // this is for the video
    if(widget.isColumn) {
      return Column(
      children: [
        // upVote button
        GestureDetector(
          onTap: upvote,
          child: SizedBox(
            height: 25,
            child: Image.asset(
              isUpvoted ? 'assets/icons/up-arrow.png' : 'assets/icons/arrow-up.png',
              color: isUpvoted? Colors.orange[300] : Colors.white,
            ),
          ),
        ),

        Text(
          upVotes.toString(),
          style: UnifiedTextStyle.style,
        ),

        // downVote button
        GestureDetector(
          onTap: downVote,
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
        
      ],
    );
    }

    // this is for the comments
    else {
      return Row(
      children: [
        // upVote button
        GestureDetector(
          onTap: upvote,
          child: SizedBox(
            height: 25,
            child: Image.asset(
              isUpvoted ? 'assets/icons/up-arrow.png' : 'assets/icons/arrow-up.png',
              color: isUpvoted? Colors.orange[300] : Colors.white,
            ),
          ),
        ),

        Text(
          upVotes.toString(),
          style: UnifiedTextStyle.style,
        ),

        // downVote button
        GestureDetector(
          onTap: downVote,
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
        
      ],
    );
    }
    
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