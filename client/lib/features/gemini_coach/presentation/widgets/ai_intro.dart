import 'package:flutter/material.dart';

/// An avatar and text introducing the AI coach.
class AIIntro extends StatelessWidget {
  /// Creates a new [AIIntro] instance.
  const AIIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/img/chatbot.png'),
              radius: 100,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Hello! I am your personalized AI coach. I use the latest in AI technology to provide you with the best advice to improve your game. I will analyze your game history and provide you with personalized advice.',
            ),
          ),
        ),
      ],
    );
  }
}
