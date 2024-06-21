import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/score_multipliers.dart';

/// A class with two methods that convert bools/ints to/from JSON.
class BoolIntConverter implements JsonConverter<bool, int> {
  /// Creates a new instance of the converter.
  const BoolIntConverter();

  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}

/// A class with two methods that convert ScoreMultiplier/ints to/from JSON.
class ScoreMultiplierConverter implements JsonConverter<ScoreMultiplier, int> {
  /// Creates a new instance of the converter.
  const ScoreMultiplierConverter();

  @override
  ScoreMultiplier fromJson(int json) {
    return ScoreMultiplier.values[json];
  }

  @override
  int toJson(ScoreMultiplier object) {
    return object.index;
  }
}
