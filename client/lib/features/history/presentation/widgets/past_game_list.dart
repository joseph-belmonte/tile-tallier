import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/game.dart';
import 'past_game_list_item.dart';

/// A list of past games, sorted by date.
// ignore: non_constant_identifier_names
ListView PastGameList(
  List<Game> games,
  BuildContext context,
  WidgetRef ref, {
  bool isFavoriteList = false,
}) {
  if (isFavoriteList) {
    games = games.where((game) => game.isFavorite).toList();
  }
  return ListView.builder(
    itemCount: games.length,
    itemBuilder: (context, index) {
      return PastGameListItem(
        game: games[index],
        ref: ref,
      );
    },
  );
}
