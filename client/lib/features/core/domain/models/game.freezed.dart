// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  String get id => throw _privateConstructorUsedError;
  Play? get currentPlay => throw _privateConstructorUsedError;
  Word? get currentWord => throw _privateConstructorUsedError;
  @BoolIntConverter()
  bool get isFavorite => throw _privateConstructorUsedError;
  List<GamePlayer> get players => throw _privateConstructorUsedError;
  int get currentPlayerIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {String id,
      Play? currentPlay,
      Word? currentWord,
      @BoolIntConverter() bool isFavorite,
      List<GamePlayer> players,
      int currentPlayerIndex});

  $PlayCopyWith<$Res>? get currentPlay;
  $WordCopyWith<$Res>? get currentWord;
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentPlay = freezed,
    Object? currentWord = freezed,
    Object? isFavorite = null,
    Object? players = null,
    Object? currentPlayerIndex = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currentPlay: freezed == currentPlay
          ? _value.currentPlay
          : currentPlay // ignore: cast_nullable_to_non_nullable
              as Play?,
      currentWord: freezed == currentWord
          ? _value.currentWord
          : currentWord // ignore: cast_nullable_to_non_nullable
              as Word?,
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
  $PlayCopyWith<$Res>? get currentPlay {
    if (_value.currentPlay == null) {
      return null;
    }

    return $PlayCopyWith<$Res>(_value.currentPlay!, (value) {
      return _then(_value.copyWith(currentPlay: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WordCopyWith<$Res>? get currentWord {
    if (_value.currentWord == null) {
      return null;
    }

    return $WordCopyWith<$Res>(_value.currentWord!, (value) {
      return _then(_value.copyWith(currentWord: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Play? currentPlay,
      Word? currentWord,
      @BoolIntConverter() bool isFavorite,
      List<GamePlayer> players,
      int currentPlayerIndex});

  @override
  $PlayCopyWith<$Res>? get currentPlay;
  @override
  $WordCopyWith<$Res>? get currentWord;
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentPlay = freezed,
    Object? currentWord = freezed,
    Object? isFavorite = null,
    Object? players = null,
    Object? currentPlayerIndex = null,
  }) {
    return _then(_$GameImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currentPlay: freezed == currentPlay
          ? _value.currentPlay
          : currentPlay // ignore: cast_nullable_to_non_nullable
              as Play?,
      currentWord: freezed == currentWord
          ? _value.currentWord
          : currentWord // ignore: cast_nullable_to_non_nullable
              as Word?,
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
class _$GameImpl extends _Game {
  _$GameImpl(
      {required this.id,
      required this.currentPlay,
      required this.currentWord,
      @BoolIntConverter() this.isFavorite = false,
      final List<GamePlayer> players = const [],
      this.currentPlayerIndex = 0})
      : _players = players,
        super._();

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  final String id;
  @override
  final Play? currentPlay;
  @override
  final Word? currentWord;
  @override
  @JsonKey()
  @BoolIntConverter()
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
    return 'Game(id: $id, currentPlay: $currentPlay, currentWord: $currentWord, isFavorite: $isFavorite, players: $players, currentPlayerIndex: $currentPlayerIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
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
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(
      this,
    );
  }
}

abstract class _Game extends Game {
  factory _Game(
      {required final String id,
      required final Play? currentPlay,
      required final Word? currentWord,
      @BoolIntConverter() final bool isFavorite,
      final List<GamePlayer> players,
      final int currentPlayerIndex}) = _$GameImpl;
  _Game._() : super._();

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  String get id;
  @override
  Play? get currentPlay;
  @override
  Word? get currentWord;
  @override
  @BoolIntConverter()
  bool get isFavorite;
  @override
  List<GamePlayer> get players;
  @override
  int get currentPlayerIndex;
  @override
  @JsonKey(ignore: true)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
