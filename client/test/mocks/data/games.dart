import 'package:tile_tally/features/core/domain/models/game.dart';
import 'package:tile_tally/features/core/domain/models/game_player.dart';
import 'package:tile_tally/features/core/domain/models/letter.dart';
import 'package:tile_tally/features/core/domain/models/play.dart';
import 'package:tile_tally/features/core/domain/models/word.dart';

final game1 = Game(
  id: 'game1',
  isFavorite: false,
  players: [],
  currentPlay: null,
  currentWord: null,
);

final game2 = Game(
  id: 'game2',
  isFavorite: false,
  players: [],
  currentPlay: null,
  currentWord: null,
);

final game3 = Game(
  id: 'game3',
  isFavorite: false,
  players: [],
  currentPlay: null,
  currentWord: null,
);

final game4 = Game(
  id: 'game4',
  isFavorite: false,
  players: [],
  currentPlay: null,
  currentWord: null,
);

final game5 = Game(
  id: 'game5',
  isFavorite: false,
  players: [],
  currentPlay: null,
  currentWord: null,
);

final game6 = Game(
  id: 'game6',
  isFavorite: false,
  players: [
    GamePlayer(
      id: 'player1',
      playerId: 'player1',
      gameId: 'game6',
      name: 'Andrea',
      plays: <Play>[
        Play(
          id: 'play1',
          gameId: 'game6',
          timestamp: DateTime.now(),
          playedWords: <Word>[
            Word(
              id: 'word1',
              playedLetters: <Letter>[
                Letter(letter: 'A', id: 'a'),
                Letter(letter: 'B', id: 'b'),
                Letter(letter: 'C', id: 'c'),
              ],
            ),
          ],
        ),
      ],
      endRack: '',
    ),
    GamePlayer(
      id: 'player2',
      playerId: 'player2',
      gameId: 'game6',
      name: 'Joe',
      plays: <Play>[
        Play(
          id: 'play2',
          gameId: 'game6',
          timestamp: DateTime.now(),
          playedWords: <Word>[
            Word(
              id: 'word2',
              playedLetters: <Letter>[
                Letter(letter: 'D', id: 'd'),
                Letter(letter: 'E', id: 'e'),
                Letter(letter: 'F', id: 'f'),
              ],
            ),
          ],
        ),
      ],
      endRack: '',
    ),
  ],
  currentPlay: null,
  currentWord: null,
);
