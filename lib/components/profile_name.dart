import 'package:flutter/material.dart';
import 'package:reddit_clone/components/text_style.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({required this.name,super.key});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5,right: 5),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.blue,
          ),
        ),
        Text(
          name,
          style: UnifiedTextStyle.style,
        ),
        
      ],
    );
  }
}