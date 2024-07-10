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

/// A converter that converts a ScoreMultiplier to an int and vice versa.
class ScoreMultiplierConverter implements JsonConverter<ScoreMultiplier, int> {
  // ignore: public_member_api_docs
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
