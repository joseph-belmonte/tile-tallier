// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../domain/models/game.dart';
// import 'end_game.dart';

// class SubtractPage extends StatefulWidget {
//   const SubtractPage({required this.game, super.key});

//   final Game game;

//   @override
//   State<SubtractPage> createState() => _SubtractPageState();
// }

// class _SubtractPageState extends State<SubtractPage> {
//   String _rackInput = '';
//   final _rackInputController = TextEditingController();
//   int _playerIndex = 0;

//   @override
//   void dispose() {
//     _rackInputController.dispose();
//     super.dispose();
//   }

//   void onUpdateRack() {
//     _rackInput = _rackInputController.text;
//   }

//   void onSubmitRack() {
//     var players = widget.game.players;
//     players[_playerIndex].endRack = _rackInput;

//     if (_playerIndex == widget.game.players.length - 1) {
//       final winner = widget.game.leader;
//       final playerPositions = widget.game.getPlayersSortedByScore();
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (_) => EndGamePage(
//             winner: winner,
//             rankedPlayers: playerPositions,
//             game: widget.game,
//           ),
//         ),
//       );
//     } else if (_playerIndex > widget.game.players.length - 1) {
//       throw ('Error: _playerIndex is out of bounds');
//     }
//     _rackInputController.clear();
//     setState(() {
//       if (_playerIndex == widget.game.players.length - 1) {
//         _playerIndex = 0;
//       } else {
//         _playerIndex += 1;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var players = widget.game.players;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Subtract Scores'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Text(
//                 'Please enter the leftover tiles on each player\'s rack.',
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "${players[_playerIndex].name}'s Rack:",
//               ),
//               TextField(
//                 textCapitalization: TextCapitalization.characters,
//                 controller: _rackInputController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Tiles',
//                 ),
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
//                 ],
//                 onChanged: (text) => onUpdateRack(),
//               ),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.abc),
//                 onPressed: onSubmitRack,
//                 label: const Text('Submit Rack'),
//               ),
//               SizedBox(height: 300),
//               Column(
//                 children: <Widget>[
//                   for (var player in widget.game.players)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text('${player.name}: ${player.score}'),
//                         SizedBox(width: 20),
//                       ],
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
