import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayZoneState extends ChangeNotifier {
  List<String> playedWords = [];

  void addWord(String word) {
    playedWords.add(word);
    notifyListeners();
  }

  void removeWord(String word) {
    playedWords.remove(word);
    notifyListeners();
  }
}

class DisplayZone extends StatefulWidget {
  const DisplayZone({super.key});

  @override
  State<DisplayZone> createState() => _DisplayZoneState();
}

class _DisplayZoneState extends State<DisplayZone> {
  @override
  Widget build(BuildContext context) {
    final playedWords = [];
    return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(
              height: 55,
            ),
            playedWords.isNotEmpty
                ? Column(
                    children: [
                      Text(
                        'Played Words:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      for (var word in playedWords)
                        Row(
                          children: [Text(word)],
                        )
                    ],
                  )
                : Placeholder(
                    fallbackHeight: 40,
                  ),
          ],
        ));
  }
}
