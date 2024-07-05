// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'past_game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PastGame _$PastGameFromJson(Map<String, dynamic> json) {
  return _PastGame.fromJson(json);
}

/// @nodoc
mixin _$PastGame {
  String get id => throw _privateConstructorUsedError;
  Play get currentPlay => throw _privateConstructorUsedError;
  Word get currentWord => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  List<GamePlayer> get players => throw _privateConstructorUsedError;
  int get currentPlayerIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PastGameCopyWith<PastGame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PastGameCopyWith<$Res> {
  factory $PastGameCopyWith(PastGame value, $Res Function(PastGame) then) =
      _$PastGameCopyWithImpl<$Res, PastGame>;
  @useResult
  $Res call(
      {String id,
      Play currentPlay,
      Word currentWord,
      bool isFavorite,
      List<GamePlayer> players,
      int currentPlayerIndex});

  $PlayCopyWith<$Res> get currentPlay;
  $WordCopyWith<$Res> get currentWord;
}

/// @nodoc
class _$PastGameCopyWithImpl<$Res, $Val extends PastGame>
    implements $PastGameCopyWith<$Res> {
  _$PastGameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentPlay = null,
    Object? currentWord = null,
    Object? isFavorite = null,
    Object? players = null,
    Object? currentPlayerIndex = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currentPlay: null == currentPlay
          ? _value.currentPlay
          : currentPlay // ignore: cast_nullable_to_non_nullable
              as Play,
      currentWord: null == currentWord
          ? _value.currentWord
          : currentWord // ignore: cast_nullable_to_non_nullable
              as Word,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
      currentPlayerIndex: null == currentPlayerIndex
          ? _value.currentPlayerIndex
          : currentPlayerIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayCopyWith<$Res> get currentPlay {
    return $PlayCopyWith<$Res>(_value.currentPlay, (value) {
      return _then(_value.copyWith(currentPlay: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WordCopyWith<$Res> get currentWord {
    return $WordCopyWith<$Res>(_value.currentWord, (value) {
      return _then(_value.copyWith(currentWord: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PastGameImplCopyWith<$Res>
    implements $PastGameCopyWith<$Res> {
  factory _$$PastGameImplCopyWith(
          _$PastGameImpl value, $Res Function(_$PastGameImpl) then) =
      __$$PastGameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Play currentPlay,
      Word currentWord,
      bool isFavorite,
      List<GamePlayer> players,
      int currentPlayerIndex});

  @override
  $PlayCopyWith<$Res> get currentPlay;
  @override
  $WordCopyWith<$Res> get currentWord;
}

/// @nodoc
class __$$PastGameImplCopyWithImpl<$Res>
    extends _$PastGameCopyWithImpl<$Res, _$PastGameImpl>
    implements _$$PastGameImplCopyWith<$Res> {
  __$$PastGameImplCopyWithImpl(
      _$PastGameImpl _value, $Res Function(_$PastGameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentPlay = null,
    Object? currentWord = null,
    Object? isFavorite = null,
    Object? players = null,
    Object? currentPlayerIndex = null,
  }) {
    return _then(_$PastGameImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currentPlay: null == currentPlay
          ? _value.currentPlay
          : currentPlay // ignore: cast_nullable_to_non_nullable
              as Play,
      currentWord: null == currentWord
          ? _value.currentWord
          : currentWord // ignore: cast_nullable_to_non_nullable
              as Word,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
      currentPlayerIndex: null == currentPlayerIndex
          ? _value.currentPlayerIndex
          : currentPlayerIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PastGameImpl extends _PastGame {
  const _$PastGameImpl(
      {required this.id,
      required this.currentPlay,
      required this.currentWord,
      this.isFavorite = false,
      final List<GamePlayer> players = const [],
      this.currentPlayerIndex = 0})
      : _players = players,
        super._();

  factory _$PastGameImpl.fromJson(Map<String, dynamic> json) =>
      _$$PastGameImplFromJson(json);

  @override
  final String id;
  @override
  final Play currentPlay;
  @override
  final Word currentWord;
  @override
  @JsonKey()
  final bool isFavorite;
  final List<GamePlayer> _players;
  @override
  @JsonKey()
  List<GamePlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  @JsonKey()
  final int currentPlayerIndex;

  @override
  String toString() {
    return 'PastGame(id: $id, currentPlay: $currentPlay, currentWord: $currentWord, isFavorite: $isFavorite, players: $players, currentPlayerIndex: $currentPlayerIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PastGameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currentPlay, currentPlay) ||
                other.currentPlay == currentPlay) &&
            (identical(other.currentWord, currentWord) ||
                other.currentWord == currentWord) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.currentPlayerIndex, currentPlayerIndex) ||
                other.currentPlayerIndex == currentPlayerIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      currentPlay,
      currentWord,
      isFavorite,
      const DeepCollectionEquality().hash(_players),
      currentPlayerIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PastGameImplCopyWith<_$PastGameImpl> get copyWith =>
      __$$PastGameImplCopyWithImpl<_$PastGameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PastGameImplToJson(
      this,
    );
  }
}

abstract class _PastGame extends PastGame {
  const factory _PastGame(
      {required final String id,
      required final Play currentPlay,
      required final Word currentWord,
      final bool isFavorite,
      final List<GamePlayer> players,
      final int currentPlayerIndex}) = _$PastGameImpl;
  const _PastGame._() : super._();

  factory _PastGame.fromJson(Map<String, dynamic> json) =
      _$PastGameImpl.fromJson;

  @override
  String get id;
  @override
  Play get currentPlay;
  @override
  Word get currentWord;
  @override
  bool get isFavorite;
  @override
  List<GamePlayer> get players;
  @override
  int get currentPlayerIndex;
  @override
  @JsonKey(ignore: true)
  _$$PastGameImplCopyWith<_$PastGameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
